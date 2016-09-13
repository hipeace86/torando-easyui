# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from sqlalchemy import Column, Integer, String, DateTime, ForeignKey
from lib.Route import BaseModel, Basebase


class Statuscode(Basebase, BaseModel):
    """
    状态代码表
    """
    __tablename__ = 't_statuscode'

    CsId = Column('fi_cs_id', Integer, primary_key=True)
    Typeid = Column('fi_typeid', Integer, ForeignKey('t_typecode.fi_typeid'))
    CsName = Column('fs_cs_name', String(50))
    CsNameDesc = Column('fs_cs_name_desc', String(50))
    Order = Column('fi_order', Integer)
    CreateId = Column('fi_create_id', Integer)
    CreateTime = Column('ft_create_time', DateTime)
    UpdateId = Column('fi_update_id', Integer)
    UpdateTime = Column('ft_update_time', DateTime)

    def toDict(self):
        return {
            'CsId': self.CsId,
            'TypeId': self.Typeid,
            'CsName': self.CsName,
            'CsNameDesc': self.CsNameDesc,
            'Order': self.Order,
            'CreateId': self.CreateId,
            'CreateTime': self.CreateTime.strftime('%Y-%m-%d %H:%M:%S') if self.CreateTime else '',
            'UpdateId': self.UpdateId,
            'UpdateTime': self.UpdateTime.strftime('%Y-%m-%d %H:%M:%S') if self.UpdateTime else '',
        }
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
