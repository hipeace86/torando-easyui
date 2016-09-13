# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, ForeignKey

from lib.Route import BaseModel, RightModel
from Common.Entity.functions import getStatusDescById
from Right.Entity.Kit import Kit


class Menus(RightModel, BaseModel):
    """
    菜单
    """
    __tablename__ = 'trt_menus'

    MenuId = Column('fi_menu_id', Integer, primary_key=True)
    MenuName = Column('fs_menu_name', String(100))
    MenuUrl = Column('fs_menu_url', String(100))
    ParentId = Column('fi_parent_id', Integer,
                      ForeignKey('trt_menus.fi_menu_id'))
    Comments = Column('fs_comments', String(1000))
    Order = Column('fi_order', Integer)
    Visiable = Column('fi_visiable', Integer)
    CreateId = Column('fi_create_id', Integer)
    CreateTime = Column('ft_create_time', DateTime)
    UpdateId = Column('fi_update_id', Integer)
    UpdateTime = Column('ft_update_time', DateTime)
    IsShare = Column('fi_is_share', Integer)

    def toDict(self):
        if not self.CreateTime:
            self.CreateTime = datetime.now()
        return {
            'MenuId': self.MenuId,
            'MenuName': self.MenuName,
            'MenuUrl': self.MenuUrl,
            'ParentId': self.ParentId,
            'Comments': self.Comments,
            'Order': self.Order,
            'Visiable': self.Visiable,
            'CreateId': Kit.getUserNameById(self.CreateId),
            'CreateTime': self.CreateTime.strftime('%Y-%m-%d %H:%M:%S') if self.CreateTime else '',
            'UpdateId': Kit.getUserNameById(self.UpdateId),
            'UpdateTime': self.UpdateTime.strftime('%Y-%m-%d %H:%M:%S') if self.UpdateTime else '',
            'id': self.MenuId,
            'text': self.MenuName,
            'VisiableName': getStatusDescById(self.Visiable),
            'ParentName': Kit.getMenuNameById(self.ParentId),
        }
