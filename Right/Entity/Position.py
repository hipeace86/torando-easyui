# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from sqlalchemy import Column, Integer, String, DateTime
from lib.Route import BaseModel, RightModel


from Right.Entity.Kit import Kit


class Position(RightModel, BaseModel):
    """
    职位
    """
    __tablename__ = 'trt_position'

    PosId = Column('fi_pos_id', Integer, primary_key=True)
    PosName = Column('fs_pos_name', String(100))
    Comments = Column('fs_comments', String(1000))
    ParentId = Column('fi_parent_id', Integer)
    CreateId = Column('fi_create_id', Integer)
    CreateTime = Column('ft_create_time', DateTime)
    UpdateId = Column('fi_update_id', Integer)
    UpdateTime = Column('ft_update_time', DateTime)
    IsManage = Column('fi_is_manage', Integer)

    def toDict(self):
        return {
            'PosId': self.PosId,
            'PosName': self.PosName,
            'Comments': self.Comments,
            'ParentId': self.ParentId,
            'CreateId': Kit.getUserNameById(self.CreateId),
            'CreateTime': self.CreateTime.strftime('%Y-%m-%d %H:%M:%S') if self.CreateTime else '',
            'UpdateId': Kit.getUserNameById(self.UpdateId),
            'UpdateTime': self.UpdateTime.strftime('%Y-%m-%d %H:%M:%S') if self.UpdateTime else '',
            'ParentName': Kit.getPostionNameById(self.ParentId),
        }
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
