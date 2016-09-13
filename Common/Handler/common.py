# -*- coding: utf-8 -*-
"""
Common 
@version:1.0.20130201
@author: Hipeace86
"""
import json
from Common.Entity.Statuscode import Statuscode
from Common.Entity.Areazone import AreaZoneTree

from lib.basehandler import RESTfulHandler, BaseHandler
from lib.tools import saveUploadFile
from lib.urlmap import urlmap
from lib.RedisCache import RedisCache, RightsCache
import tornado
from tornado.web import HTTPError


@urlmap(r'/rest/common/incr/(.*)')
class GetIncrValueHandler(RESTfulHandler):

    def prepare(self):
        self.RightEnable = False
        super(GetIncrValueHandler, self).prepare()

    def get(self, key):
        self.finish('{0:04d}'.format(int(RedisCache.incr(key))))


@urlmap(r'/rest/common/areazone\/?([0-9]*)')
class AreaZoneTreeHandler(RESTfulHandler):

    def prepare(self):
        self.RightEnable = False
        super(AreaZoneTreeHandler, self).prepare()

    @tornado.web.asynchronous
    def get(self, id='0'):
        if RedisCache.exists('Common:AreaZone:Tree:{0}'.format(id)):
            self.finish(RedisCache.get('Common:AreaZone:Tree:{0}'.format(id)))
        else:
            tree = AreaZoneTree(str(id))
            RedisCache.setex('Common:AreaZone:Tree:{0}'.format(
                id), json.dumps(tree), 3600 * 24)
            self.finish(json.dumps(tree))


@urlmap(r'/common/fileupload')
class FileUploadHandler(BaseHandler):
    """docstring for FileUploadHandler"""

    def prepare(self):
        self.RightEnable = False
        super(FileUploadHandler, self).prepare()

    @tornado.web.asynchronous
    def post(self):
        try:
            fileinfo = self.request.files['Filedata'][0]
            if len(fileinfo['body']) > 1024 * 1024 * 2:
                raise HTTPError(501, u'文件大小超过2M,请重新上传！')
            else:
                fileName = saveUploadFile(fileinfo)
                self.finish(fileName)
        except Exception, e:
            self.set_status(501)
            self.finish(e.log_message)


@urlmap(r'/removeloginuser\/?([0-9]*)')
class RemoveLoginUserHandler(BaseHandler):

    def get(self, uid=0):
        if uid:
            if RightsCache.hexists('LoginedUser', int(uid)):
                RightsCache.hset('LoginedUser', int(uid), 0)
        else:
            self.finish(RightsCache.hgetall('LoginedUser'))
