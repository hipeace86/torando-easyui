# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
__date__ = 16 / 9 / 5.

from lib.Route import BaseModel
from lib.Route import engines


def common():
    from Common.Entity.Areazone import Areazone
    from Common.Entity.History import History
    from Common.Entity.Typecode import Typecode
    from Common.Entity.Statuscode import Statuscode


def right():
    from Right.Entity.Company import Company
    from Right.Entity.Department import Department
    from Right.Entity.LogLogin import LogLogin
    from Right.Entity.LogPassword import LogPassword
    from Right.Entity.Menus import Menus
    from Right.Entity.MenusFunction import MenusFunction
    from Right.Entity.Position import Position
    from Right.Entity.Role import Role
    from Right.Entity.RoleRight import RoleRight
    from Right.Entity.User import User
    from Right.Entity.UserRole import UserRole
    # insert into trt_user set
    # fs_user_name='admin',fs_user_account='admin',fs_password=md5('111222'),fi_is_active=1,fi_is_elogin=1;


if __name__ == "__main__":
    common()
    right()
    for k, v in engines.iteritems():
        BaseModel.metadata.create_all(v)
