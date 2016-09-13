# -*- coding: utf-8 -*-
"""
Common 
@version:1.0.20130201
@author: Hipeace86
"""
import json
import tornado
from lib.urlmap import urlmap
from lib.basehandler import RESTfulHandler
from lib.RedisCache import RedisCache
from sqlalchemy.orm import aliased

from Right.Entity.User import User
from Right.Entity.Department import Department


from Right.Entity.functions import CompanyTree, AllDepartTree, PositionTree


@urlmap(r'/rest/right/companytree\/?(.*)')
class RightCompanyTreeRestHandler(RESTfulHandler):
    """
    /rest/right/companytree  返回所有有效公司树数据
    /rest/right/companytree/10,13 返回公司编号为10和13的有效公司树数据
    """

    def prepare(self):
        self.RightEnable = False
        super(RightCompanyTreeRestHandler, self).prepare()

    def get(self, filter=None):
        tree = CompanyTree(filter)
        self.finish(json.dumps(tree))


@urlmap(r'/rest/right/usertree\/?(.*)')
class UserTreeRestHandler(RESTfulHandler):
    """
    获取组织架构数据，使用方法：
        /rest/right/usertree  返回所有有效用户树
        /rest/right/usertree/10 返回部门编号为10的有效用户树; 暂不运行多个部门过滤
    """

    def prepare(self):
        self.RightEnable = False
        super(UserTreeRestHandler, self).prepare()

    @tornado.web.asynchronous
    def get(self, filter):
        if RedisCache.exists("UserTree:{0}".format(filter)):
            self.finish(RedisCache.get("UserTree:{0}".format(filter)))
        else:
            key = filter

            u = aliased(User, name='u')
            d = aliased(Department, name='d')
            user = self.db.query(u.UserName, u.UserId, d.DepartName).join(
                d, d.DepartId == u.Department).filter(u.IsActive == 1)
            if filter:
                ufilter = self.db.execute("call GetDepartIds('{0}','1')".format(
                    filter), mapper='right').fetchone()
                user = user.filter(u.Department.in_(ufilter[0].split(',')))
            user = user.all()
            result = []
            for r in user:
                result.append({'id': r[1], 'text': r[0], 'group': r[2]})
            values = json.dumps(result)
            RedisCache.setex("UserTree:{0}".format(key), values, 3600 * 24)
            self.finish(values)


@urlmap(r'/rest/right/departtree')
class DepartmentTreeRestHandler(RESTfulHandler):

    def prepare(self):
        self.RightEnable = False
        super(DepartmentTreeRestHandler, self).prepare()

    def get(self):
        self.finish(json.dumps(AllDepartTree()))


@urlmap(r'/rest/right/positiontree')
class PositionTreeRestHandler(RESTfulHandler):

    def prepare(self):
        self.RightEnable = False
        super(PositionTreeRestHandler, self).prepare()

    def get(self):
        tree = PositionTree()
        self.finish(json.dumps(tree))
