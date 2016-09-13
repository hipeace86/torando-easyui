# -*- coding: utf-8 -*-
from sqlalchemy.orm import aliased

from lib.Route import session
from Right.Entity.Menus import Menus
from Right.Entity.User import User
from Right.Entity.Company import Company
from Right.Entity.Department import Department
from Right.Entity.Position import Position


def MenusForUser(uid):
    if uid == 1:
        menus = session.query(Menus).filter(Menus.ParentId == 0).all()
    return menus


def Organstructure(filterdepart=None):
    """
    组织架构树形结构返回
    """
    #@TODO:返回子级
    u = aliased(User, name='u')
    d = aliased(Department, name='d')
    c = aliased(Company, name='c')
    query = session.query(u.UserName, u.UserId, d.DepartName, d.DepartId, c.CompanyName, c.ComId).join(d, d.DepartId == u.Department).join(c, c.ComId == d.Company).\
        filter(u.IsActive == 1)
    if filterdepart:
        query = query.filter(d.DepartId.in_(filterdepart))
    coms = query.group_by(c.CompanyName).all()
    result = []
    departs = query.group_by(d.DepartName).order_by(c.ComId).all()
    user = query.all()
    for com in coms:
        item = {'id': 'c%s' % (com.ComId,), 'text': com.CompanyName, 'children': map(
            __DepartIdValueMake, filter(lambda d: d.ComId == com.ComId, departs))}
        for i in range(len(item['children'])):
            item['children'][i]['children'] = map(__UserIdValueMake, filter(
                lambda u: 'd%s' % (u[3]) == item['children'][i]['id'], user))
        result.append(item)
    session.close_all()
    return result


def __DepartIdValueMake(sequence):
    return {'id': 'd%s' % (sequence[3],), 'text': sequence[2]}


def __UserIdValueMake(sequence):
    return {'id': sequence[1], 'text': sequence[0]}


def __CommonIdValueFilter(sequence):
    return {'id': sequence[0], 'text': sequence[1]}


def CompanyTree(filter=None):
    query = session.query(Company.ComId, Company.CompanyName,
                          Company.ParentId).filter(Company.IsActive == 1)
    if filter:
        query = query.filter(Company.ComId.in_(filter))
    coms = query.all()

    tops = filter(lambda c: c.ParentId == 0, coms)
    result = []
    for com in tops:
        item = {'id': com.ComId, 'text': com.CompanyName, 'children': map(
            __CommonIdValueFilter, filter(lambda c: c.ParentId == com.ComId, coms))}
        result.append(item)
    session.close_all()
    return result


def AllDepartTree():
    """
    所有部门树数据构造
    """
    coms = session.query(Company.ComId, Company.CompanyName,
                         Company.ParentId).filter(Company.IsActive == 1)
    departs = session.query(Department.DepartId, Department.DepartName,
                            Department.ParentId, Department.Company).all()
    result = []
    for com in coms:
        item = {'id': com.ComId, 'text': com.CompanyName, 'children': map(
            __CommonIdValueFilter, filter(lambda d: d.Company == com.ComId, departs))}
        result.append(item)
    session.close_all()
    return result


def PositionTree():
    """
    职位树数据构造
    """
    pos = session.query(Position.PosId, Position.PosName,
                        Position.ParentId).all()
    tops = filter(lambda p: p.ParentId == 0, pos)
    result = []
    for p in tops:
        item = {'id': p.PosId, 'text': p.PosName, 'children': map(
            __CommonIdValueFilter, filter(lambda i: i.ParentId == p.PosId, pos))}
        result.append(item)
    session.close_all()
    return result


def DepartUserList(departid):
    """
    获取指定部门用户id列表
    """
    if departid:
        result = session.query(User.UserId).filter(
            User.Department == departid).all()
        session.close_all()
        return result
    return None
