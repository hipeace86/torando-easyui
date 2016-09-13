# -*- coding: utf-8 -*-
from tornado.web import UIModule
from lib.RedisCache import RedisCache


class BaseUIModule(UIModule):

    @property
    def db(self):
        return self.handler.db

    @property
    def Redis(self):
        return RedisCache
