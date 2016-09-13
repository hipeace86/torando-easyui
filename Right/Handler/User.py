# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from lib.basehandler import BaseHandler, RESTfulHandler
from lib.urlmap import urlmap
from Right.Entity.User import User
from Right.Entity.LogPassword import LogPassword

from lib.tools import md5hash
from lib.RedisCache import RedisCache
import time
from sqlalchemy import func


@urlmap(r'/right/user')
class UserHandler(BaseHandler):

    def get(self):
        self.render("Right/user/index.html")


@urlmap(r'/rest/right/user\/?([0-9]*)')
class UserRestHandler(RESTfulHandler):

    def get(self, id=0):
        if id:
            objUser = User().get_by_id(id)
            self.finish(objUser.toDict())
        else:
            result = {'total': 0, 'rows': []}
            objs = []
            page = int(self.get_argument('page', 1))
            pagesize = int(self.get_argument('rows', self.PageSize))
            username = self.get_argument('username', None)
            if username:
                objUser = self.db.query(User).filter(User.UserName.like('%{0}%'.format(
                    username))).offset((page - 1) * pagesize).limit(pagesize).all()
                result['total'] = self.db.query(User.UserId).filter(
                    User.UserName.like('%{0}%'.format(username))).count()
            else:
                objUser = User().get_page_list(page, pagesize)
                result['total'] = User().get_count()

            for obj in objUser:
                objs.append(obj.toDict())

            result['rows'] = objs
            self.finish(result)

    def post(self, id=0):
        objUser = User()

        objUser.Department = self.get_argument('Department')
        objUser.PosId = self.get_argument('PosId')
        objUser.UserName = self.get_argument('UserName')
        objUser.Gender = self.get_argument('Gender', '1')
        objUser.UserAccount = self.get_argument('UserAccount')
        objUser.Password = md5hash('111222')
        objUser.Phone = self.get_argument('Phone', '')
        objUser.AreaZone = self.get_argument('AreaZone', '')
        objUser.Address = self.get_argument('Address', '')
        objUser.Mobile = self.get_argument('Mobile', '')
        objUser.Email = self.get_argument('Email', '')
        objUser.PostCode = self.get_argument('PostCode', '')
        objUser.IsElogin = self.get_argument('IsElogin', 1)
        objUser.Birth = self.get_argument('Birth', '')
        objUser.IsActive = self.get_argument('IsActive', 1)
        objUser.Note = self.get_argument('Note', '')

        self.db.add(objUser)
        self.db.commit()
        RedisCache.delete("UserTree:{0}".format(objUser.Department))
        RedisCache.delete("UserTree:")
        self.finish(objUser.toDict())

    def put(self, id=0):
        if id:
            objUser = User().get_by_id(id)

            objUser.Department = self.get_argument('Department')
            objUser.PosId = self.get_argument('PosId')
            objUser.UserName = self.get_argument('UserName')
            objUser.Gender = self.get_argument('Gender', '')
            objUser.UserAccount = self.get_argument('UserAccount')
            objUser.Phone = self.get_argument('Phone', '')
            objUser.AreaZone = self.get_argument('AreaZone', '')
            objUser.Address = self.get_argument('Address', '')
            objUser.Mobile = self.get_argument('Mobile', '')
            objUser.Email = self.get_argument('Email', '')
            objUser.PostCode = self.get_argument('PostCode', '')
            objUser.IsElogin = self.get_argument('IsElogin', 1)
            objUser.Birth = self.get_argument('Birth', '')
            objUser.IsActive = self.get_argument('IsActive', 1)
            objUser.Note = self.get_argument('Note', '')

            self.db.add(objUser)
            self.db.commit()
            RedisCache.delete("UserTree:{0}".format(objUser.Department))
            RedisCache.delete("UserTree:")
            RedisCache.hdel("Cache:Right.UserEmail", id)
            RedisCache.hdel("Cache:Right.User", id)
            RedisCache.hdel("Cache:Right.UserEmail", id)
            result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
            self.finish(result)

    def delete(self, id):
        self.finish({'success': True, 'errorMsg': id})
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================


@urlmap(r'/rest/right/userprofile')
class UserProfileHandler(RESTfulHandler):

    def prepare(self):
        self.RightEnable = False
        super(UserProfileHandler, self).prepare()

    def get(self):
        objUser = User().get_by_id(self.get_current_user())
        self.finish(objUser.toDict())

    def put(self):
        objUser = User().get_by_id(self.get_current_user())
        objUser.UserName = self.get_argument('UserName')
        objUser.Gender = self.get_argument('GenderName', 1)
        objUser.Phone = self.get_argument('Phone', None)
        objUser.AreaZone = self.get_argument('AreaZone', None)
        objUser.Address = self.get_argument('Address', None)
        objUser.Mobile = self.get_argument('Mobile', None)
        objUser.Email = self.get_argument('Email', None)
        objUser.PostCode = self.get_argument('PostCode', None)
        objUser.Birth = self.get_argument('Birth', None)
        self.db.add(objUser)
        self.db.commit()
        RedisCache.delete("UserTree:{0}".format(objUser.Department))
        RedisCache.delete("UserTree:")
        RedisCache.hdel("Cache:Right.UserEmail", id)
        RedisCache.hdel("Cache:Right.User", id)
        RedisCache.hdel("Cache:Right.UserEmail", id)
        result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
        self.finish(result)


@urlmap(r'/rest/right/editpassword')
class UserEditPasswordHandler(RESTfulHandler):

    def prepare(self):
        self.RightEnable = False
        super(UserEditPasswordHandler, self).prepare()
    # 判断老密码是否正确，新密码md5

    def put(self):
        oldpass = self.get_argument('oldpass')
        newpass = self.get_argument('password1')

        objUser = User().get_by_id(self.get_current_user())
        if md5hash(oldpass) == objUser.Password:
            objUser.Password = md5hash(newpass)
            objUser.LastUpdatePwd = time.strftime(
                '%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
            self.db.add(objUser)

            objLogPassword = LogPassword()
            objLogPassword.OldPassword = md5hash(oldpass)
            objLogPassword.UserId = self.get_current_user()
            self.db.add(objLogPassword)
            self.db.commit()
            result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功'}
            self.finish(result)
        else:
            result = {'errorMsg': '原始密码不正确!',
                      'success': 'false', 'successMsg': ''}
            self.finish(result)


@urlmap(r'/rest/right/needchangepassword')
class UserNeedChangePasswordHandler(RESTfulHandler):

    def prepare(self):
        self.RightEnable = False

    def post(self):
        oldPass = self.get_argument('current_password')
        newPass = self.get_argument('new_password')
        againPass = self.get_argument('confirm_password')
        msg = {'error': 0, 'msg': '成功修改'}
        if newPass == againPass and newPass is not None:
            objUser = User.get_by_id(self.get_current_user())
            if objUser.Password == md5hash(oldPass):
                than120 =  self.db.query(LogPassword).filter(LogPassword.OldPassword == md5hash(newPass)).\
                    filter(LogPassword.CreateId == self.get_current_user()).\
                    filter(func.datediff(
                        func.now(), LogPassword.CreateTime) < 120).count()
                if than120:
                    msg['error'] = 1
                    msg['msg'] = '新密码在120天内使用过，请重新修改'
                else:
                    objUser.Password = md5hash(newPass)
                    objUser.LastUpdatePwd = time.strftime(
                        '%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
                    self.db.add(objUser)

                    objLogPassword = LogPassword()
                    objLogPassword.OldPassword = md5hash(oldPass)
                    objLogPassword.UserId = self.get_current_user()
                    self.db.add(objLogPassword)
                    self.db.commit()
            else:
                msg['error'] = 2
                msg['msg'] = '原密码不正确，请重新输入'
        else:
            msg['error'] = 2
            msg['msg'] = '新输入的两次密码不一致，请重新输入'
        self.finish(msg)
