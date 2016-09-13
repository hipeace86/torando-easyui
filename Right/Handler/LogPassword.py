# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from lib.basehandler import BaseHandler, RESTfulHandler
from lib.urlmap import urlmap
from Right.Entity.LogPassword import LogPassword


@urlmap(r'/right/logpassword')
class LogPasswordHandler(BaseHandler):

    def get(self):
        self.render("Right/logpassword/index.html")


@urlmap(r'/rest/right/logpassword\/?([0-9]*)')
class LogPasswordRestHandler(RESTfulHandler):

    def get(self, id=0):
        if id:
            objLogPassword = LogPassword().get_by_id(id)
            self.finish(objLogPassword.toDict())
        else:
            result = {'total': 0, 'rows': []}
            objs = []
            page = int(self.get_argument('page', 1))
            pagesize = int(self.get_argument('rows', self.PageSize))
            objLogPassword = LogPassword().get_page_list(page, pagesize)
            for obj in objLogPassword:
                objs.append(obj.toDict())
            result['total'] = LogPassword().get_count()
            result['rows'] = objs
            self.finish(result)

    def post(self, id=0):
        objLogPassword = LogPassword()
        ''' Replace with form
        objLogPassword.UserId = self.get_argument('UserId') 
        objLogPassword.OldPassword = self.get_argument('OldPassword') 
        
        '''
        self.db.add(objLogPassword)
        self.db.commit()
        self.finish(objLogPassword.toDict())

    def put(self, id=0):
        if id:
            objLogPassword = LogPassword().get_by_id(id)

            objLogPassword.UserId = self.get_argument('UserId')
            objLogPassword.OldPassword = self.get_argument('OldPassword')

            self.db.add(objLogPassword)
            self.db.commit()
            result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
            self.finish(result)

    def delete(self, id):
        self.finish({'success': True, 'errorMsg': id})
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
