# -*- coding: utf-8 -*-
"""
CommonModules 
@version:1.0.20130628
@author: Hipeace86
"""
from Common.Entity.Statuscode import Statuscode
from Common.Entity.Typecode import Typecode

from UI.BaseUIModule import BaseUIModule


class StatusCodeModule(BaseUIModule):

    def render(self, typeid, select=None, ismust=0):
        typeid = str(typeid)
        if self.Redis.exists('UI.CommonModule.StatusCodeModule.{0}.{1}'.format(typeid, select)):
            return self.Redis.get('UI.CommonModule.StatusCodeModule.{0}.{1}'.format(typeid, select))
        else:
            typeid = typeid.split(',')
            lst = self.db.query(Statuscode.CsId, Statuscode.CsNameDesc).filter(
                Statuscode.Typeid.in_(typeid)).order_by(Statuscode.Order).all()
            html = self.render_string(
                'Common/statusui.html', items=lst, select=select, ismust=ismust)
            self.Redis.setex('UI.CommonModule.StatusCodeModule.{0}.{1}'.format(
                typeid, select), html, 3600 * 24)
            return html


class RadioModule(BaseUIModule):

    def render(self, typeid, select=None, event=None):
        typeid = str(typeid)
        if self.Redis.exists('UI.CommonModule.RadioModule.{0}.{1}'.format(typeid, select)):
            return self.Redis.get('UI.CommonModule.RadioModule.{0}.{1}'.format(typeid, select))
        else:
            typeid = typeid.split(',')
            lst = self.db.query(Statuscode.CsId, Statuscode.CsNameDesc, Typecode.Typename).join(
                Typecode, Typecode.Typeid == Statuscode.Typeid).filter(Statuscode.Typeid.in_(typeid)).order_by(Statuscode.CsId).all()
            html = self.render_string(
                'Common/radioui.html', items=lst, events=event, selects=select)
            self.Redis.setex('UI.CommonModule.RadioModule.{0}.{1}'.format(
                typeid, select), html, 3600 * 24)
            return html


class CheckboxModule(BaseUIModule):

    def render(self, typeid, select=None, event=None):
        typeid = str(typeid)
        if self.Redis.exists('UI.CommonModule.CheckboxModule.{0}.{1}'.format(typeid, select)):
            return self.Redis.get('UI.CommonModule.CheckboxModule.{0}.{1}'.format(typeid, select))
        else:
            typeid = typeid.split(',')
            lst = self.db.query(Statuscode.CsId, Statuscode.CsNameDesc, Typecode.Typename).join(
                Typecode, Typecode.Typeid == Statuscode.Typeid).filter(Statuscode.Typeid.in_(typeid)).order_by(Statuscode.CsId).all()
            html = self.render_string(
                'Common/Checkbox.html', items=lst, events=event, selects=select)
            self.Redis.setex('UI.CommonModule.CheckboxModule.{0}.{1}'.format(
                typeid, select), html, 3600 * 24)
            return html
