# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from sqlalchemy import Column, Integer, String, DateTime
from lib.Route import BaseModel, RightModel


class RoleRight(RightModel, BaseModel):
    """
    角色权限
    """
    __tablename__ = 'trt_role_right'

    RightId = Column('fi_right_id', Integer, primary_key=True)
    RoleId = Column('fi_role_id', Integer)
    MenuFuncId = Column('fi_menu_func_id', Integer)
    CreateId = Column('fi_create_id', Integer)
    CreateTime = Column('ft_create_time', DateTime)
    UpdateId = Column('fi_update_id', Integer)
    UpdateTime = Column('ft_update_time', DateTime)

    def toDict(self):
        return {
            'RightId': self.RightId,
            'RoleId': self.RoleId,
            'MenuFuncId': self.MenuFuncId,
            'CreateId': self.CreateId,
            'CreateTime': self.CreateTime.strftime('%Y-%m-%d %H:%M:%S') if self.CreateTime else '',
            'UpdateId': self.UpdateId,
            'UpdateTime': self.UpdateTime.strftime('%Y-%m-%d %H:%M:%S') if self.UpdateTime else '',
        }
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
