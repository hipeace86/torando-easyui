# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from lib.basehandler import BaseHandler, RESTfulHandler
from lib.urlmap import urlmap
from Right.Entity.UserRole import UserRole


@urlmap(r'/right/userrole')
class UserRoleHandler(BaseHandler):

    def get(self):
        self.render("Right/userrole/index.html")


@urlmap(r'/rest/right/userrole\/?([0-9]*)')
class UserRoleRestHandler(RESTfulHandler):

    def get(self, id=0):
        if id:
            objUserRole = UserRole().get_by_id(id)
            self.finish(objUserRole.toDict())
        else:
            result = {'total': 0, 'rows': []}
            objs = []
            page = int(self.get_argument('page', 1))
            pagesize = int(self.get_argument('rows', self.PageSize))
            objUserRole = UserRole().get_page_list(page, pagesize)
            for obj in objUserRole:
                objs.append(obj.toDict())
            result['total'] = UserRole().get_count()
            result['rows'] = objs
            self.finish(result)

    def post(self, id=0):
        objUserRole = UserRole()
        ''' Replace with form
        objUserRole.UserId = self.get_argument('UserId') 
        objUserRole.RoleId = self.get_argument('RoleId') 
        
        '''
        self.db.add(objUserRole)
        self.db.commit()
        self.finish(objUserRole.toDict())

    def put(self, id=0):
        if id:
            objUserRole = UserRole().get_by_id(id)

            objUserRole.UserId = self.get_argument('UserId')
            objUserRole.RoleId = self.get_argument('RoleId')

            self.db.add(objUserRole)
            self.db.commit()
            result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
            self.finish(result)

    def delete(self, id):
        self.finish({'success': True, 'errorMsg': id})
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
