# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'

from lxml import etree

from lib.basehandler import BaseHandler, RESTfulHandler
from lib.urlmap import urlmap
from Right.Entity.Role import Role

from Right.Entity.Menus import Menus
from Right.Entity.MenusFunction import MenusFunction
from Right.Entity.RoleRight import RoleRight

from Right.Entity.Company import Company
from Right.Entity.Department import Department
from Right.Entity.User import User
from Right.Entity.UserRole import UserRole


@urlmap(r'/right/role')
class RoleHandler(BaseHandler):

    def get(self):
        self.render("Right/role/index.html")


@urlmap(r'/rest/right/role\/?([0-9]*)')
class RoleRestHandler(RESTfulHandler):

    def get(self, id=0):
        if id:
            objRole = Role().get_by_id(id)
            self.finish(objRole.toDict())
        else:
            result = {'total': 0, 'rows': []}
            objs = []
            page = int(self.get_argument('page', 1))
            pagesize = int(self.get_argument('rows', self.PageSize))
            objRole = Role().get_page_list(page, pagesize)
            for obj in objRole:
                objs.append(obj.toDict())
            result['total'] = Role().get_count()
            result['rows'] = objs
            self.finish(result)

    def post(self, id=0):
        objRole = Role()

        objRole.RoleName = self.get_argument('RoleName')
        objRole.RoleDesc = self.get_argument('RoleDesc', None)

        self.db.add(objRole)
        self.db.commit()
        self.finish(objRole.toDict())

    def put(self, id=0):
        if id:
            objRole = Role().get_by_id(id)

            objRole.RoleName = self.get_argument('RoleName')
            objRole.RoleDesc = self.get_argument('RoleDesc', None)

            self.db.add(objRole)
            self.db.commit()
            result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
            self.finish(result)

    def delete(self, id):
        self.finish({'success': True, 'errorMsg': id})
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================


@urlmap(r'/right/assignroleright/([0-9]*)')
class AssignRoleRightHandler(RESTfulHandler):

    def get(self, roleid):
        menus = self.db.query(Menus).all()
        funcs = self.db.query(MenusFunction).all()
        data = {'menus': menus, 'funcs': funcs}

        xmlDoc = self.render_string("Right/xml/menu.html", **data)
        fh = open('./xslt/AssignRoleRight.xslt', 'r')
        xslt_tree = ''.join(fh.readlines())
        fh.close()
        xslt_tree = etree.XML(xslt_tree)
        transform = etree.XSLT(xslt_tree)

        doc_root = etree.XML(xmlDoc)
        result = transform(doc_root)
        rls = self.db.query(RoleRight.MenuFuncId).filter(
            RoleRight.RoleId == roleid).all()
        rights = []
        for r in rls:
            rights.append(str(r[0]))
        data = {'html': str(result), 'rights': ','.join(
            rights), 'roleid': roleid}
        self.render('Right/role/assignroleright.html', **data)

    def post(self, roleid):
        oldRights = self.db.query(RoleRight).filter(
            RoleRight.RoleId == roleid).all()
        newRights = []
        nls = self.get_argument('rights').split(',')
        for r in nls:
            if r:
                newRights.append(r)
        if len(oldRights) > len(newRights):
            rangs = range(len(newRights))
            for r in rangs:
                oldRights[r].MenuFuncId = newRights[r]
                self.db.add(oldRights[r])
            rangs = range(len(newRights), len(oldRights))
            for r in rangs:
                self.db.delete(oldRights[r])
            self.db.commit()
        else:
            rangs = range(len(oldRights))
            for r in rangs:
                oldRights[r].MenuFuncId = newRights[r]
                self.db.add(oldRights[r])
            rangs = range(len(oldRights), len(newRights))
            for r in rangs:
                objRoleRight = RoleRight()
                objRoleRight.RoleId = roleid
                objRoleRight.MenuFuncId = newRights[r]
                self.db.add(objRoleRight)
            self.db.commit()
        result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
        self.finish(result)


@urlmap(r'/right/assignroleuser/([0-9]*)')
class AssignRoleUserHandler(RESTfulHandler):

    def get(self, roleid):
        data = {}
        data['companys'] = self.db.query(
            Company.ComId, Company.CompanyName, Company.ParentId).filter(Company.IsActive == 1).all()
        data['departs'] = self.db.query(
            Department.DepartId, Department.DepartName, Department.Company, Department.ParentId).all()
        data['users'] = self.db.query(
            User.UserId, User.UserName, User.Department).filter(User.IsActive == 1).all()
        xmlDoc = self.render_string("Right/xml/organstructure.html", **data)
        fh = open('./xslt/OrganStructure.xslt', 'r')
        xslt_tree = ''.join(fh.readlines())
        fh.close()
        xslt_tree = etree.XML(xslt_tree)
        transform = etree.XSLT(xslt_tree)

        doc_root = etree.XML(xmlDoc)
        result = transform(doc_root)
        data['html'] = str(result)
        data['roleid'] = roleid
        uls = self.db.query(UserRole.UserId).filter(
            UserRole.RoleId == roleid).all()
        uids = []
        for u in uls:
            uids.append(str(u[0]))
        data['uids'] = ','.join(uids)
        self.render('Right/role/assignroleuser.html', **data)

    def post(self, roleid):
        oldUsers = self.db.query(UserRole).filter(
            UserRole.RoleId == roleid).all()
        uls = self.get_argument('users').split(',')
        newUsers = []
        for u in uls:
            if u:
                newUsers.append(u)
        if len(oldUsers) > len(newUsers):
            rangs = range(len(newUsers))
            for r in rangs:
                oldUsers[r].UserId = newUsers[r]
                self.db.add(oldUsers[r])
            rangs = range(len(newUsers), len(oldUsers))
            for r in rangs:
                self.db.delete(oldUsers[r])
        else:
            rangs = range(len(oldUsers))
            for r in rangs:
                oldUsers[r].UserId = newUsers[r]
                self.db.add(oldUsers[r])
            rangs = range(len(oldUsers), len(newUsers))
            for r in rangs:
                objUserRole = UserRole()
                objUserRole.RoleId = roleid
                objUserRole.UserId = newUsers[r]
                self.db.add(objUserRole)
        self.db.commit()
        result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
        self.finish(result)
