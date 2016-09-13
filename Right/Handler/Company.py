# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from lib.basehandler import BaseHandler, RESTfulHandler
from lib.urlmap import urlmap
from Right.Entity.Company import Company
from Right.Entity.functions import CompanyTree
import json


@urlmap(r'/right/company')
class CompanyHandler(BaseHandler):

    def get(self):
        self.render("Right/company/index.html")


@urlmap(r'/rest/right/company\/?([0-9]*)')
class CompanyRestHandler(RESTfulHandler):

    def get(self, id=0):
        if id:
            objCompany = Company().get_by_id(id)
            self.finish(objCompany.toDict())
        else:
            result = {'total': 0, 'rows': []}
            objs = []
            page = int(self.get_argument('page', 1))
            pagesize = int(self.get_argument('rows', self.PageSize))
            objCompany = Company().get_page_list(page, pagesize)
            for obj in objCompany:
                objs.append(obj.toDict())
            result['total'] = Company().get_count()
            result['rows'] = objs
            self.finish(result)

    def post(self, id=0):
        objCompany = Company()

        objCompany.ParentId = self.get_argument('ParentId', 0)
        objCompany.CompanyName = self.get_argument('CompanyName')
        objCompany.AreaZone = self.get_argument('AreaZone', None)
        objCompany.Address = self.get_argument('Address', None)
        objCompany.Trade = self.get_argument('Trade', None)
        objCompany.KindCode = self.get_argument('KindCode', None)
        objCompany.Size = self.get_argument('Size', None)
        objCompany.Phone = self.get_argument('Phone', None)
        objCompany.Fax = self.get_argument('Fax', None)
        objCompany.Homepage = self.get_argument('Homepage', None)
        objCompany.IsActive = self.get_argument('IsActive', None)
        objCompany.Comment = self.get_argument('Comment', None)

        self.db.add(objCompany)
        self.db.commit()
        self.finish(objCompany.toDict())

    def put(self, id=0):
        if id:
            objCompany = Company().get_by_id(id)

            objCompany.ParentId = self.get_argument('ParentId', 0)
            objCompany.CompanyName = self.get_argument('CompanyName')
            objCompany.AreaZone = self.get_argument('AreaZone', None)
            objCompany.Address = self.get_argument('Address', None)
            objCompany.Trade = self.get_argument('Trade', None)
            objCompany.KindCode = self.get_argument('KindCode', None)
            objCompany.Size = self.get_argument('Size', None)
            objCompany.Phone = self.get_argument('Phone', None)
            objCompany.Fax = self.get_argument('Fax', None)
            objCompany.Homepage = self.get_argument('Homepage', None)
            objCompany.IsActive = self.get_argument('IsActive', None)
            objCompany.Comment = self.get_argument('Comment', None)

            self.db.add(objCompany)
            self.db.commit()
            result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
            self.finish(result)

    def delete(self, id):
        self.finish({'success': True, 'errorMsg': id})
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================


@urlmap(r'/rest/right/companytree\/?(.*)')
class CompanyTreeRestHandler(RESTfulHandler):
    """公司数据
        /rest/right/companytree 返回所有有效公司
        /rest/right/companytree/1,2 返回ID为1和2的公司并包含下级公司 
    """

    def get(self, filter):
        if filter:
            filter = filter.split(',')
        self.finish(json.dumps(CompanyTree(filter)))
