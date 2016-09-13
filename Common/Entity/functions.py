# -*- coding: utf-8 -*-
"""
Customer 
@version:1.0.20130130
@author: Hipeace86
"""

from Common.Entity.Typecode import Typecode
from Common.Entity.Statuscode import Statuscode

from lib.Route import session

from lib.RedisCache import RedisCache, RightsCache


def getStatusDescById(ident):
    if ident:
        if RedisCache.hexists('Cache:Statuscode', ident):
            return RedisCache.hget('Cache:Statuscode', ident)
        else:
            status = Statuscode().get_by_id(ident)
            if status:
                RedisCache.hset('Cache:Statuscode', ident, status.CsNameDesc)
                return status.CsNameDesc
            else:
                return ''
    else:
        return ''


def getTelphoneZone(phone):
    if phone:
        if RightsCache.hexists('Cache:TelphoneZone', phone[:3]):
            return RightsCache.hget('Cache:TelphoneZone', phone[:3])
        elif RightsCache.hexists('Cache:TelphoneZone', phone[:4]):
            return RightsCache.hget('Cache:TelphoneZone', phone[:4])
        else:
            return ''


def getMobileAreaZone(mobile):
    if mobile:
        mobile = mobile[:7]
        if mobile[:1] == '0':
            return getTelphoneZone(mobile)
        if RightsCache.hexists('Cache:MobileAreaZone', mobile):
            return RightsCache.hget('Cache:MobileAreaZone', mobile)
    return ''


def autoInsertStatusCode(typeid, NameDesc):
    try:
        sc = Statuscode()
        sc.Typeid = typeid
        sc.CsNameDesc = NameDesc
        sc.CsName = 'AT'
        session.add(sc)
        session.flush()
        sc.CsName = 'AT%s' % (sc.CsId,)
        session.commit()
        session.close_all()
        return sc.CsId
    except Exception, e:
        raise e
