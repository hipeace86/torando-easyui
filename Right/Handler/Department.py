# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from lib.basehandler import BaseHandler, RESTfulHandler
from lib.urlmap import urlmap
from Right.Entity.Department import Department


@urlmap(r'/right/department')
class DepartmentHandler(BaseHandler):

    def get(self):
        self.render("Right/department/index.html")


@urlmap(r'/rest/right/department\/?([0-9]*)')
class DepartmentRestHandler(RESTfulHandler):

    def get(self, id=0):
        if id:
            objDepartment = Department().get_by_id(id)
            self.finish(objDepartment.toDict())
        else:
            result = {'total': 0, 'rows': []}
            objs = []
            page = int(self.get_argument('page', 1))
            pagesize = int(self.get_argument('rows', self.PageSize))
            objDepartment = Department().get_page_list(page, pagesize)
            for obj in objDepartment:
                objs.append(obj.toDict())
            result['total'] = Department().get_count()
            result['rows'] = objs
            self.finish(result)

    def post(self, id=0):
        objDepartment = Department()

        objDepartment.Company = self.get_argument('Company', 0)
        objDepartment.ParentId = self.get_argument('ParentId', 0)
        objDepartment.DepartName = self.get_argument('DepartName')
        objDepartment.Comments = self.get_argument('Comments', None)

        self.db.add(objDepartment)
        self.db.commit()
        self.finish(objDepartment.toDict())

    def put(self, id=0):
        if id:
            objDepartment = Department().get_by_id(id)

            objDepartment.Company = self.get_argument('Company', 0)
            objDepartment.ParentId = self.get_argument('ParentId', 0)
            objDepartment.DepartName = self.get_argument('DepartName')
            objDepartment.Comments = self.get_argument('Comments', None)

            self.db.add(objDepartment)
            self.db.commit()
            result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
            self.finish(result)

    def delete(self, id):
        self.finish({'success': True, 'errorMsg': id})
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
