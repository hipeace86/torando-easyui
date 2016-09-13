# -*- coding: utf-8 -*-
from lxml import etree
from datetime import datetime
from lib.basehandler import BaseHandler
from lib.urlmap import urlmap
from lib.tools import md5hash
from Common.Entity.Enums import YesNo

from Right.Entity.User import User
from Right.Entity.RoleRight import RoleRight
from Right.Entity.Menus import Menus
from Right.Entity.MenusFunction import MenusFunction
from Right.Entity.UserRole import UserRole
from Right.Entity.LogLogin import LogLogin
from Right.Entity.Kit import Kit

import tornado

from lib.RedisCache import RightsCache

import json


@urlmap(r'/')
class MainHandler(BaseHandler):

    @tornado.web.authenticated
    def get(self):
        objUser = User.get_by_id(self.get_current_user())
        ChangePwdFlag = True
        errorMsg = ''
        if objUser.LastUpdatePwd:
            if (datetime.now() - objUser.LastUpdatePwd).days > 59:
                errorMsg = '您已经有{0}天没有修改过密码，请改下密码吧！'.format(
                    (datetime.now() - objUser.LastUpdatePwd).days)
            else:
                ChangePwdFlag = False
        else:
            errorMsg = '您还在使用初始密码，请改下密码吧！'
        if ChangePwdFlag:
            self.render("needpwd.html", errorMsg=errorMsg)
        else:
            menus = self.db.execute('call GetMenusForUser(%s)' % (
                self.get_current_user(),), mapper='right').fetchall()

            xmlDoc = self.render_string(
                'Right/xml/usermenu.html', menus=menus, workflowtmpl=[], workflownodes=[])
            fh = open('./xslt/UserMenu.xslt', 'r')
            xslt_tree = ''.join(fh.readlines())
            fh.close()
            xslt_tree = etree.XML(xslt_tree)
            transform = etree.XSLT(xslt_tree)

            doc_root = etree.XML(xmlDoc)
            result = transform(doc_root)
            data = {}

            data['menus'] = str(result)
            data['UserId'] = self.get_current_user()
            data['UserName'] = Kit.getUserNameById(self.get_current_user())
            data['Department'] = Kit.getDepartmentNameById(
                self.get_cookie('d'))
            data['Postion'] = Kit.getPostionNameById(self.get_cookie('p'))
            self.render("index.html", **data)


@urlmap(r'/login')
class LoginHandler(BaseHandler):

    def get(self):
        self.render('login.html', msg='')

    def post(self):
        username = self.get_argument('login-name', '')
        password = self.get_argument('login-pass', '')
        try:
            user = self.db.query(User).filter(User.UserAccount == username, User.Password == md5hash(password)).\
                filter(User.IsActive == YesNo.Yes).filter(
                    User.IsElogin == YesNo.Yes).first()
            if user:
                self._doLogin(user)
            else:
                self.render('login.html', msg='用户名或密码错误！')
        except Exception, e:
            self.write(str(e))

    def _doLogin(self, user):
        self.set_secure_cookie('user', str(user.UserId), expires_days=0.5)
        self.set_cookie('d', str(user.Department))
        self.set_cookie('p', str(user.PosId))
        rightlist = self.db.query(MenusFunction.MenuFuncUrl, Menus.MenuUrl).join(Menus, Menus.MenuId == MenusFunction.MenuId).\
            join(RoleRight, RoleRight.MenuFuncId == MenusFunction.MenuFuncId).\
            join(UserRole, UserRole.RoleId == RoleRight.RoleId).filter(UserRole.UserId == user.UserId).\
            filter(Menus.Visiable == YesNo.No).all()
        rights = dict((k, [i[0] for i in rightlist if i[1] == k])
                      for k in frozenset(j[1] for j in rightlist))
        RightsCache.set("User%sRight" % (user.UserId), json.dumps(rights))
        objLogLogin = LogLogin()
        objLogLogin.UserId = user.UserId
        # objLogLogin.Ip = self.request.headers['X-Real-Ip']
        objLogLogin.LoginTime = datetime.now()
        self.db.add(objLogLogin)
        self.db.commit()
        self.set_cookie('logid', str(objLogLogin.LogId))
        self.redirect('/')


@urlmap(r'/logout')
class LogoutHandler(BaseHandler):

    def get(self):
        logid = self.get_cookie('logid')
        if logid:
            objLogLogin = LogLogin().get_by_id(logid)
            objLogLogin.ExitTime = datetime.now()
            self.db.add(objLogLogin)
            self.db.commit()
        uid = int(self.get_current_user())
        if RightsCache.hexists('LoginedUser', uid):
            RightsCache.hset('LoginedUser', uid, 0)
        self.clear_cookie("user")
        self.clear_cookie("userid")
        self.redirect('/login')
