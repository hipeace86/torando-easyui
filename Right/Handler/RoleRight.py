# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from lib.basehandler import BaseHandler, RESTfulHandler
from lib.urlmap import urlmap
from Right.Entity.RoleRight import RoleRight


@urlmap(r'/right/roleright')
class RoleRightHandler(BaseHandler):

    def get(self):
        self.render("Right/roleright/index.html")


@urlmap(r'/rest/right/roleright\/?([0-9]*)')
class RoleRightRestHandler(RESTfulHandler):

    def get(self, id=0):
        if id:
            objRoleRight = RoleRight().get_by_id(id)
            self.finish(objRoleRight.toDict())
        else:
            result = {'total': 0, 'rows': []}
            objs = []
            page = int(self.get_argument('page', 1))
            pagesize = int(self.get_argument('rows', self.PageSize))
            objRoleRight = RoleRight().get_page_list(page, pagesize)
            for obj in objRoleRight:
                objs.append(obj.toDict())
            result['total'] = RoleRight().get_count()
            result['rows'] = objs
            self.finish(result)

    def post(self, id=0):
        objRoleRight = RoleRight()

        objRoleRight.RoleId = self.get_argument('RoleId')
        objRoleRight.MenuFuncId = self.get_argument('MenuFuncId')

        self.db.add(objRoleRight)
        self.db.commit()
        self.finish(objRoleRight.toDict())

    def put(self, id=0):
        if id:
            objRoleRight = RoleRight().get_by_id(id)

            objRoleRight.RoleId = self.get_argument('RoleId')
            objRoleRight.MenuFuncId = self.get_argument('MenuFuncId')

            self.db.add(objRoleRight)
            self.db.commit()
            result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
            self.finish(result)

    def delete(self, id):
        self.finish({'success': True, 'errorMsg': id})
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
