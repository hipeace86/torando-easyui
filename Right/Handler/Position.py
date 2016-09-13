# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from lib.basehandler import BaseHandler, RESTfulHandler
from lib.urlmap import urlmap
from Right.Entity.Position import Position


@urlmap(r'/right/position')
class PositionHandler(BaseHandler):

    def get(self):
        self.render("Right/position/index.html")


@urlmap(r'/rest/right/position\/?([0-9]*)')
class PositionRestHandler(RESTfulHandler):

    def get(self, id=0):
        if id:
            objPosition = Position().get_by_id(id)
            self.finish(objPosition.toDict())
        else:
            result = {'total': 0, 'rows': []}
            objs = []
            page = int(self.get_argument('page', 1))
            pagesize = int(self.get_argument('rows', self.PageSize))
            objPosition = Position().get_page_list(page, pagesize)
            for obj in objPosition:
                objs.append(obj.toDict())
            result['total'] = Position().get_count()
            result['rows'] = objs
            self.finish(result)

    def post(self, id=0):
        objPosition = Position()

        objPosition.PosName = self.get_argument('PosName')
        objPosition.Comments = self.get_argument('Comments', None)
        objPosition.ParentId = self.get_argument('ParentId', 0)

        self.db.add(objPosition)
        self.db.commit()
        self.finish(objPosition.toDict())

    def put(self, id=0):
        if id:
            objPosition = Position().get_by_id(id)

            objPosition.PosName = self.get_argument('PosName')
            objPosition.Comments = self.get_argument('Comments', None)
            objPosition.ParentId = self.get_argument('ParentId', 0)

            self.db.add(objPosition)
            self.db.commit()
            result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
            self.finish(result)

    def delete(self, id):
        self.finish({'success': True, 'errorMsg': id})
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
