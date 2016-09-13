# -*- coding: utf-8 -*-
"""
Typecode 
@version:1.0.20130705
@author: Hipeace86
"""
import tornado
from lib.basehandler import BaseHandler, RESTfulHandler
from lib.urlmap import urlmap
from Common.Entity.Typecode import Typecode


@urlmap(r'/common/typecode')
class TypecodeHandler(BaseHandler):

    def get(self):
        self.render("Common/typecode/index.html")


@urlmap(r'/rest/common/typecode\/?([0-9]*)')
class TypecodeRestHandler(RESTfulHandler):

    @tornado.web.asynchronous
    def get(self, ident=0):
        if ident:
            objTypecode = Typecode().get_by_id(ident)
            self.finish(objTypecode.toDict())
        else:
            result = {'total': 0, 'rows': []}
            objs = []
            page = int(self.get_argument('page', 1))
            pagesize = int(self.get_argument('rows', self.PageSize))
            objTypecode = Typecode().get_page_list(page, pagesize)
            for obj in objTypecode:
                objs.append(obj.toDict())
            result['total'] = Typecode().get_count()
            result['rows'] = objs
            self.finish(result)

    @tornado.web.asynchronous
    def post(self):
        objTypecode = Typecode()

        objTypecode.Typename = self.get_argument('Typename', None)
        objTypecode.TypenameDesc = self.get_argument('TypenameDesc', None)
        objTypecode.Flag = self.get_argument('Flag', None)

        self.db.add(objTypecode)
        self.db.commit()
        result = {'errorMsg': '', 'success': 'true', 'successMsg': '添加成功！'}
        self.finish(result)

    @tornado.web.asynchronous
    def put(self, ident=0):
        if ident:
            objTypecode = Typecode().get_by_id(ident)

            objTypecode.Typename = self.get_argument('Typename', None)
            objTypecode.TypenameDesc = self.get_argument('TypenameDesc', None)
            objTypecode.Flag = self.get_argument('Flag', None)

            self.db.add(objTypecode)
            self.db.commit()
            result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
            self.finish(result)

    @tornado.web.asynchronous
    def delete(self, ident):
        self.finish({'success': True, 'errorMsg': ident})
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
