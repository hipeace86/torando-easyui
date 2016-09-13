# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from lxml import etree
from lib.basehandler import BaseHandler, RESTfulHandler
from lib.urlmap import urlmap
from Right.Entity.Menus import Menus


@urlmap(r'/right/menus')
class MenusHandler(BaseHandler):

    def get(self):
        menus = self.db.query(Menus).order_by(Menus.Order).all()
        xmlDoc = self.render_string('Right/xml/menumanage.html', menus=menus)
        fh = open('./xslt/MenusManage.xslt', 'r')
        xslt_tree = ''.join(fh.readlines())
        fh.close()
        xslt_tree = etree.XML(xslt_tree)
        transform = etree.XSLT(xslt_tree)

        doc_root = etree.XML(xmlDoc)
        result = transform(doc_root)
        data = {}
        data['menus'] = str(result)
        self.render("Right/menus/index.html", **data)


@urlmap(r'/rest/right/menus\/?([0-9]*)')
class MenusRestHandler(RESTfulHandler):

    def get(self, id=0):
        if id:
            objMenus = Menus().get_by_id(id)
            self.finish(objMenus.toDict())
        else:
            result = {'total': 0, 'rows': []}
            objs = []
            page = int(self.get_argument('page', 1))
            pagesize = int(self.get_argument('rows', self.PageSize))
            objMenus = Menus().get_page_list(page, pagesize)
            for obj in objMenus:
                objs.append(obj.toDict())
            result['total'] = Menus().get_count()
            result['rows'] = objs
            self.finish(result)

    def post(self, id=0):
        objMenus = Menus()

        objMenus.MenuName = self.get_argument('MenuName')
        objMenus.MenuUrl = self.get_argument('MenuUrl')
        objMenus.ParentId = self.get_argument('ParentId', '0')
        objMenus.Comments = self.get_argument('Comments', None)
        objMenus.Order = self.get_argument('Order', 1)
        objMenus.Visiable = self.get_argument('Visiable', 1)
        self.db.add(objMenus)
        self.db.commit()
        self.finish(objMenus.toDict())

    def put(self, id=0):
        if id:
            objMenus = Menus().get_by_id(id)

            objMenus.MenuName = self.get_argument('MenuName')
            objMenus.MenuUrl = self.get_argument('MenuUrl')
            objMenus.ParentId = self.get_argument('ParentId', '0')
            objMenus.Comments = self.get_argument('Comments', None)
            objMenus.Order = self.get_argument('Order', 1)
            objMenus.Visiable = self.get_argument('Visiable', 1)

            self.db.add(objMenus)
            self.db.commit()
            result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
            self.finish(result)

    def delete(self, id):
        self.finish({'success': True, 'errorMsg': id})
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
