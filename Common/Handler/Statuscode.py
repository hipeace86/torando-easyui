# -*- coding: utf-8 -*-
"""
Statuscode 
@version:1.0.20130705
@author: Hipeace86
"""
import tornado
from lib.basehandler import BaseHandler, RESTfulHandler
from lib.urlmap import urlmap
from lib.RedisCache import RedisCache
from Common.Entity.Statuscode import Statuscode
from Common.Entity.Typecode import Typecode
from Common.Entity.Enums import YesNo


@urlmap(r'/common/statuscode')
class StatuscodeHandler(BaseHandler):

    def get(self):
        types = self.db.query(Typecode).filter(
            Typecode.Flag == YesNo.Yes).all()
        self.render("Common/statuscode/index.html", types=types)


@urlmap(r'/rest/common/statuscode\/?([0-9]*)')
class StatuscodeRestHandler(RESTfulHandler):

    @tornado.web.asynchronous
    def get(self, ident=0):
        if ident:
            objStatuscode = Statuscode().get_by_id(ident)
            self.finish(objStatuscode.toDict())
        else:
            result = {'total': 0, 'rows': []}
            objs = []
            page = int(self.get_argument('page', 1))
            pagesize = int(self.get_argument('rows', self.PageSize))
            objStatuscode = Statuscode().get_page_list(page, pagesize)
            for obj in objStatuscode:
                objs.append(obj.toDict())
            result['total'] = Statuscode().get_count()
            result['rows'] = objs
            self.finish(result)

    @tornado.web.asynchronous
    def post(self, ident=0):
        objStatuscode = Statuscode()

        objStatuscode.Typeid = self.get_argument('Typeid', 0)
        objStatuscode.CsName = self.get_argument('CsName', None)
        objStatuscode.CsNameDesc = self.get_argument('CsNameDesc', None)
        objStatuscode.Order = self.get_argument('Order', None)

        self.db.add(objStatuscode)
        self.db.commit()
        result = {'errorMsg': '', 'success': 'true', 'successMsg': '添加成功！'}
        self.finish(result)
        RedisCache.delete(
            'UI.CommonModule.StatusCodeModule.{0}'.format(objStatuscode.Typeid))

    @tornado.web.asynchronous
    def put(self, ident=0):
        if ident:
            objStatuscode = Statuscode().get_by_id(ident)

            objStatuscode.Typeid = self.get_argument('Typeid', None)
            objStatuscode.CsName = self.get_argument('CsName', None)
            objStatuscode.CsNameDesc = self.get_argument('CsNameDesc', None)
            objStatuscode.Order = self.get_argument('Order', None)

            self.db.add(objStatuscode)
            self.db.commit()
            result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
            self.finish(result)
            RedisCache.delete(
                'UI.CommonModule.StatusCodeModule.{0}'.format(objStatuscode.Typeid))

    @tornado.web.asynchronous
    def delete(self, ident):
        self.finish({'success': True, 'errorMsg': ident})
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================


@urlmap(r'/rest/common/typestatus/([0-9]*)')
class TypeStatusRestHandler(RESTfulHandler):

    @tornado.web.asynchronous
    def get(self, typeid):
        objStatuscode = self.db.query(Statuscode).filter(
            Statuscode.Typeid == typeid).order_by(Statuscode.Order).all()
        result = {'total': 0, 'rows': []}
        objs = []
        for obj in objStatuscode:
            objs.append(obj.toDict())
        result['total'] = self.db.query(Statuscode.CsId).filter(
            Statuscode.Typeid == typeid).count()
        result['rows'] = objs
        self.finish(result)
