# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from lib.basehandler import BaseHandler, RESTfulHandler
from lib.urlmap import urlmap
from Right.Entity.MenusFunction import MenusFunction


@urlmap(r'/right/menusfunction')
class MenusFunctionHandler(BaseHandler):

    def get(self):
        self.render("Right/menusfunction/index.html")


@urlmap(r'/rest/right/menusfunction\/?([0-9]*)')
class MenusFunctionRestHandler(RESTfulHandler):

    def get(self, id=0):
        if id:
            objMenusFunction = MenusFunction().get_by_id(id)
            self.finish(objMenusFunction.toDict())
        else:
            result = {'total': 0, 'rows': []}
            objs = []
            page = int(self.get_argument('page', 1))
            pagesize = int(self.get_argument('rows', self.PageSize))
            objMenusFunction = MenusFunction().get_page_list(page, pagesize)
            for obj in objMenusFunction:
                objs.append(obj.toDict())
            result['total'] = MenusFunction().get_count()
            result['rows'] = objs
            self.finish(result)

    def post(self, id=0):
        objMenusFunction = MenusFunction()

        objMenusFunction.MenuId = self.get_argument('MenuId')
        objMenusFunction.MenuFuncName = self.get_argument('MenuFuncName')
        objMenusFunction.MenuFuncUrl = self.get_argument('MenuFuncUrl')

        self.db.add(objMenusFunction)
        self.db.commit()
        self.finish(objMenusFunction.toDict())

    def put(self, id=0):
        if id:
            objMenusFunction = MenusFunction().get_by_id(id)

            objMenusFunction.MenuId = self.get_argument('MenuId')
            objMenusFunction.MenuFuncName = self.get_argument('MenuFuncName')
            objMenusFunction.MenuFuncUrl = self.get_argument('MenuFuncUrl')

            self.db.add(objMenusFunction)
            self.db.commit()
            result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
            self.finish(result)

    def delete(self, id):
        self.finish({'success': True, 'errorMsg': id})
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================


@urlmap(r'/rest/right/menusfunctionformenu/([0-9]*)')
class MenusFunctionForMenuRestHandler(RESTfulHandler):

    def get(self, menuid):
        result = {'total': 0, 'rows': []}
        objs = []
        objMenusFunction = self.db.query(MenusFunction).filter(
            MenusFunction.MenuId == menuid).all()
        for obj in objMenusFunction:
            objs.append(obj.toDict())
        result['total'] = self.db.query(MenusFunction).filter(
            MenusFunction.MenuId == menuid).count()
        result['rows'] = objs
        self.finish(result)
