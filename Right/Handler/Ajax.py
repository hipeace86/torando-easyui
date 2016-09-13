# -*- coding: utf-8 -*-
"""
Common 
@version:1.0.20130201
@author: Hipeace86
"""
import re
import json
import tornado
from lxml import etree
from lib.urlmap import urlmap
from lib.basehandler import BaseHandler

from Right.Entity.User import User
from Right.Entity.Menus import Menus
from Common.Entity.Enums import YesNo


@urlmap(r'/right/ajax/checkaccount')
class UserAccountCheckHandler(BaseHandler):

    @tornado.web.asynchronous
    def post(self):
        account = self.get_argument('account', None)
        r = self.db.query(User.UserId).filter(
            User.UserAccount == account).count()
        if r:
            self.finish('true')
        else:
            self.finish('false')


@urlmap(r'/rest/right/menujson')
class MenuJsonHandler(BaseHandler):

    @tornado.web.asynchronous
    def post(self):
        menus = self.db.query(Menus.MenuId, Menus.ParentId, Menus.MenuName, Menus.Order).filter(
            Menus.Visiable == YesNo.Yes).all()
        xmlDoc = self.render_string('Right/xml/menumanage.html', menus=menus)
        fh = open('./xslt/MenusJsonOutput.xslt', 'r')
        xslt_tree = ''.join(fh.readlines())
        fh.close()
        xslt_tree = etree.XML(xslt_tree)
        transform = etree.XSLT(xslt_tree)

        doc_root = etree.XML(xmlDoc)
        result = str(transform(doc_root))
        process = re.compile('\s+')
        result = re.sub(process, '', result)
        values = json.dumps(eval(result))
        self.finish(values)
