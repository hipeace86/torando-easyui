# -*- coding: utf-8 -*-

from lib.Route import session
from lib.Route import RightModel
from lib.RedisCache import RedisCache


class Kit(RightModel):

    @classmethod
    def getPostionNameById(cls, ident):
        if ident:
            if RedisCache.hexists('Cache:Right.Postion', ident):
                return RedisCache.hget('Cache:Right.Postion', ident)
            else:
                result = session.execute("select fs_pos_name from trt_position where fi_pos_id=%s limit 1" % (
                    ident,), mapper='right').fetchone()
                session.close_all()
                if result:
                    RedisCache.hset('Cache:Right.Postion', ident, result[0])
                    return result[0]
                else:
                    return ''

    @classmethod
    def getCompanyNameById(cls, ident):
        if ident:
            if RedisCache.hexists('Cache:Right.Company', ident):
                return RedisCache.hget('Cache:Right.Company', ident)
            else:
                result = session.execute("select fs_company_name from trt_company where fi_com_id=%s limit 1" % (
                    ident,), mapper='right').fetchone()
                session.close_all()
                if result:
                    RedisCache.hset('Cache:Right.Company', ident, result[0])
                    return result[0]
                else:
                    return ''

    @classmethod
    def getDepartmentNameById(cls, ident):
        if ident:
            if RedisCache.hexists('Cache:Right.Department', ident):
                return RedisCache.hget('Cache:Right.Department', ident)
            else:
                result = session.execute("select fs_depart_name from trt_department where fi_depart_id=%s limit 1" % (
                    ident,), mapper='right').fetchone()
                session.close_all()
                if result:
                    RedisCache.hset('Cache:Right.Department', ident, result[0])
                    return result[0]
                else:
                    RedisCache.hset('Cache:Right.Department', ident, '')
                    return ''

    @classmethod
    def getEmailByUserId(cls, ident):
        if ident:
            if RedisCache.hexists('Cache:Right.UserEmail', ident):
                return RedisCache.hget('Cache:Right.UserEmail', ident)
            else:
                result = session.execute("select fs_email from trt_user where fi_user_id=%s limit 1" % (
                    ident,), mapper='right').fetchone()
                session.close_all()
                if result:
                    RedisCache.hset('Cache:Right.UserEmail', ident, result[0])
                    return result[0]
                else:
                    RedisCache.hset('Cache:Right.UserEmail', ident, '')
                    return ''

    @classmethod
    def getRoleNameById(cls, ident):
        if ident:
            if RedisCache.hexists('Cache:Right.Role', ident):
                return RedisCache.hget('Cache:Right.Role', ident)
            else:
                result = session.execute("select fs_role_name from trt_role where fi_role_id=%s limit 1" % (
                    ident,), mapper='right').fetchone()
                session.close_all()
                if result:
                    RedisCache.hset('Cache:Right.Role', ident, result[0])
                    return result[0]
                else:
                    RedisCache.hset('Cache:Right.Role', ident, '')
                    return ''

    @classmethod
    def getMenuNameById(cls, ident):
        if ident:
            if RedisCache.hexists('Cache:Right.Menu', ident):
                return RedisCache.hget('Cache:Right.Menu', ident)
            else:
                result = session.execute("select fs_menu_name from trt_menus where fi_menu_id=%s limit 1" % (
                    ident,), mapper='right').fetchone()
                session.close_all()
                if result:
                    RedisCache.hset('Cache:Right.Menu', ident, result[0])
                    return result[0]
                else:
                    RedisCache.hset('Cache:Right.Menu', ident, '')
                    return ''

    @classmethod
    def getUserNameById(cls, ident):
        if ident:
            if RedisCache.hexists('Cache:Right.User', ident):
                return RedisCache.hget('Cache:Right.User', ident)
            else:
                ident = abs(int(ident))
                result = session.execute("select fs_user_name from trt_user where fi_user_id=%s limit 1" % (
                    ident,), mapper='right').fetchone()
                session.close_all()
                if result:
                    RedisCache.hset('Cache:Right.User', ident,
                                    result[0].encode('utf8'))
                    return result[0].encode('utf8')
                else:
                    RedisCache.hset('Cache:Right.User', ident, '')
                    return ''

    @classmethod
    def getUserDepartIdById(cls, ident):
        if ident:
            ident = abs(int(ident))
            if RedisCache.hexists('Cache.Right.UserDepartId', ident):
                return RedisCache.hget('Cache.Right.UserDepartId', ident)
            else:
                result = session.execute('select fi_department from trt_user where fi_user_id={0} limit 1'.format(
                    ident), mapper='right').fetchone()
                session.close_all()
                if result:
                    RedisCache.hset('Cache.Right.UserDepartId',
                                    ident, result[0])
                    return result[0]
                else:
                    RedisCache.hset('Cache.Right.UserDepartId', ident, '')
                    return ''
if __name__ == "__main__":
    print Kit.getPostionNameById(1)
