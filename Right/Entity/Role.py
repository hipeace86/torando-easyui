# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from sqlalchemy import Column, Integer, String, DateTime
from lib.Route import BaseModel, RightModel

from Right.Entity.Kit import Kit


class Role(RightModel, BaseModel):
    """
    角色
    """
    __tablename__ = 'trt_role'

    RoleId = Column('fi_role_id', Integer, primary_key=True)
    RoleName = Column('fs_role_name', String(100))
    RoleDesc = Column('fs_role_desc', String(1000))
    CreateId = Column('fi_create_id', Integer)
    CreateTime = Column('ft_create_time', DateTime)
    UpdateId = Column('fi_update_id', Integer)
    UpdateTime = Column('ft_update_time', DateTime)

    def toDict(self):
        return {
            'RoleId': self.RoleId,
            'RoleName': self.RoleName,
            'RoleDesc': self.RoleDesc,
            'CreateId': Kit.getUserNameById(self.CreateId),
            'CreateTime': self.CreateTime.strftime('%Y-%m-%d %H:%M:%S') if self.CreateTime else '',
            'UpdateId': Kit.getUserNameById(self.UpdateId),
            'UpdateTime': self.UpdateTime.strftime('%Y-%m-%d %H:%M:%S') if self.UpdateTime else '',
        }
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
