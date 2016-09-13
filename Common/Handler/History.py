# -*- coding: utf-8 -*-
"""
History 
@version:1.0.20130903
@author: Hipeace86
"""
import tornado
from lib.basehandler import BaseHandler, RESTfulHandler
from lib.urlmap import urlmap
from Common.Entity.History import History
from lib.tools import UnSerialization


@urlmap(r'/common/history')
class HistoryHandler(BaseHandler):

    def get(self):
        self.render("Common/history/index.html")


@urlmap(r'/rest/common/history\/?([0-9]*)')
class HistoryRestHandler(RESTfulHandler):

    @tornado.web.asynchronous
    def get(self, ident=0):
        if ident:
            objHistory = History().get_by_id(ident)
            self.finish(objHistory.toDict())
        else:
            result = {'total': 0, 'rows': []}
            objs = []
            page = int(self.get_argument('page', 1))
            pagesize = int(self.get_argument('rows', self.PageSize))

            objHistory = self.db.query(History)
            objTotal = self.db.query(History.IncrId)

            CreateId = self.get_argument('CreateId', None)
            if CreateId:
                objHistory = objHistory.filter(History.CreateId == CreateId)
                objTotal = objTotal.filter(History.CreateId == CreateId)

            Module = self.get_argument('Module', None)
            if Module:
                objHistory = objHistory.filter(History.Module == Module)
                objTotal = objTotal.filter(History.Module == Module)

            Ident = self.get_argument('Ident', None)
            if Ident:
                objHistory = objHistory.filter(History.Ident == Ident)
                objTotal = objTotal.filter(History.Ident == Ident)

            objHistory = objHistory.offset(
                (page - 1) * pagesize).limit(pagesize).all()
            for obj in objHistory:
                objs.append(obj.toDict())
            result['total'] = objTotal.count()
            result['rows'] = objs
            self.finish(result)

    @tornado.web.asynchronous
    def post(self, ident=0):
        objHistory = History()

        objHistory.Module = self.get_argument('Module', None)
        objHistory.Ident = self.get_argument('Ident', None)
        objHistory.Old = self.get_argument('Old', None)
        objHistory.New = self.get_argument('New', None)
        objHistory.Postion = self.get_argument('Postion', None)

        self.db.add(objHistory)
        self.db.commit()
        result = {'errorMsg': '', 'success': 'true', 'successMsg': '添加成功！'}
        self.finish(result)

    @tornado.web.asynchronous
    def put(self, ident=0):
        if ident:
            objHistory = History().get_by_id(ident)

            objHistory.Module = self.get_argument('Module', None)
            objHistory.Ident = self.get_argument('Ident', None)
            objHistory.Old = self.get_argument('Old', None)
            objHistory.New = self.get_argument('New', None)
            objHistory.Postion = self.get_argument('Postion', None)

            self.db.add(objHistory)
            self.db.commit()
            result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
            self.finish(result)

    @tornado.web.asynchronous
    def delete(self, ident):
        self.finish({'success': True, 'errorMsg': ident})
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================


@urlmap(r'/common/history/detail/([0-9]*)')
class HistoryDetailHandler(BaseHandler):

    def get(self, id):
        objHistory = History().get_by_id(id)
        data = {'oldObj': UnSerialization(objHistory.Old).toDict(), 'newObj': UnSerialization(
            objHistory.New).toDict(), 'history': objHistory.toDict()}
        self.render('Common/history/detail.html', **data)
