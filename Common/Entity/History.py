# -*- coding: utf-8 -*-
"""
History 
@version:1.0.20130903
@author: Hipeace86
"""
from sqlalchemy import Column, Integer, String, DateTime, Text
from lib.Route import BaseModel

from Right.Entity.Kit import Kit


class History(BaseModel):
    """
    修改历史
    """
    __tablename__ = 't_history'

    IncrId = Column('fi_incr_id', Integer, primary_key=True)
    Module = Column('fs_module', String(200))
    Ident = Column('fs_ident', String(20))
    Old = Column('fs_old', Text)
    New = Column('fs_new', Text)
    Postion = Column('fs_postion', String(200))
    CreateId = Column('fi_create_id', Integer)
    CreateTime = Column('ft_create_time', DateTime)
    UpdateId = Column('fi_update_id', Integer)
    UpdateTime = Column('ft_update_time', DateTime)

    def toDict(self):
        return {
            'IncrId': self.IncrId,
            'Module': self.Module,
            'Ident': self.Ident,
            'Old': self.Old,
            'New': self.New,
            'Postion': self.Postion,
            'CreateId': Kit.getUserNameById(self.CreateId),
            'CreateTime': self.CreateTime.strftime('%Y-%m-%d %H:%M:%S') if self.CreateTime else '',
            'UpdateId': Kit.getUserNameById(self.UpdateId),
            'UpdateTime': self.UpdateTime.strftime('%Y-%m-%d %H:%M:%S') if self.UpdateTime else '',
        }
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
