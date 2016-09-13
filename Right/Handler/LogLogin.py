# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from lib.basehandler import BaseHandler, RESTfulHandler
from lib.urlmap import urlmap
from Right.Entity.LogLogin import LogLogin


@urlmap(r'/right/loglogin')
class LogLoginHandler(BaseHandler):

    def get(self):
        self.render("Right/loglogin/index.html")


@urlmap(r'/rest/right/loglogin\/?([0-9]*)')
class LogLoginRestHandler(RESTfulHandler):

    def get(self, id=0):
        if id:
            objLogLogin = LogLogin().get_by_id(id)
            self.finish(objLogLogin.toDict())
        else:
            result = {'total': 0, 'rows': []}
            objs = []
            page = int(self.get_argument('page', 1))
            pagesize = int(self.get_argument('rows', self.PageSize))
            objLogLogin = LogLogin().get_page_list(page, pagesize)
            for obj in objLogLogin:
                objs.append(obj.toDict())
            result['total'] = LogLogin().get_count()
            result['rows'] = objs
            self.finish(result)

    def post(self, id=0):
        objLogLogin = LogLogin()
        ''' Replace with form
        objLogLogin.UserId = self.get_argument('UserId') 
        objLogLogin.Ip = self.get_argument('Ip') 
        objLogLogin.Hostname = self.get_argument('Hostname') 
        objLogLogin.Hostuser = self.get_argument('Hostuser') 
        objLogLogin.Location = self.get_argument('Location') 
        objLogLogin.LoginTime = self.get_argument('LoginTime') 
        objLogLogin.ExitTime = self.get_argument('ExitTime') 
        
        '''
        self.db.add(objLogLogin)
        self.db.commit()
        self.finish(objLogLogin.toDict())

    def put(self, id=0):
        if id:
            objLogLogin = LogLogin().get_by_id(id)

            objLogLogin.UserId = self.get_argument('UserId')
            objLogLogin.Ip = self.get_argument('Ip')
            objLogLogin.Hostname = self.get_argument('Hostname')
            objLogLogin.Hostuser = self.get_argument('Hostuser')
            objLogLogin.Location = self.get_argument('Location')
            objLogLogin.LoginTime = self.get_argument('LoginTime')
            objLogLogin.ExitTime = self.get_argument('ExitTime')

            self.db.add(objLogLogin)
            self.db.commit()
            result = {'errorMsg': '', 'success': 'true', 'successMsg': '修改成功！'}
            self.finish(result)

    def delete(self, id):
        self.finish({'success': True, 'errorMsg': id})
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
