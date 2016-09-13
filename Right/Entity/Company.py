# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from sqlalchemy import Column, Integer, String, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from lib.Route import BaseModel, RightModel

from Common.Entity.functions import getStatusDescById
from Right.Entity.Kit import Kit


class Company(RightModel, BaseModel):
    """
    公司
    """
    __tablename__ = 'trt_company'

    ComId = Column('fi_com_id', Integer, primary_key=True)
    ParentId = Column('fi_parent_id', Integer,
                      ForeignKey('trt_company.fi_com_id'))
    CompanyName = Column('fs_company_name', String(100))
    AreaZone = Column('fi_area_zone', Integer)
    Address = Column('fs_address', String(200))
    Trade = Column('fi_trade', Integer)
    KindCode = Column('fi_kind_code', Integer)
    Size = Column('fi_size', Integer)
    Phone = Column('fs_phone', String(50))
    Fax = Column('fs_fax', String(50))
    Homepage = Column('fs_homepage', String(100))
    IsActive = Column('fi_is_active', Integer)
    Comment = Column('fs_comment', String(1000))
    CreateId = Column('fi_create_id', Integer)
    CreateTime = Column('ft_create_time', DateTime)
    UpdateId = Column('fi_update_id', Integer)
    UpdateTime = Column('ft_update_time', DateTime)
    Childrens = relationship("Company")

    def toDict(self):
        return {
            'ComId': self.ComId,
            'ParentId': self.ParentId,
            'CompanyName': self.CompanyName,
            'AreaZone': self.AreaZone,
            'Address': self.Address,
            'Trade': self.Trade,
            'KindCode': self.KindCode,
            'Size': self.Size,
            'Phone': self.Phone,
            'Fax': self.Fax,
            'Homepage': self.Homepage,
            'IsActive': self.IsActive,
            'Comment': self.Comment,
            'CreateId': Kit.getUserNameById(self.CreateId),
            'CreateTime': self.CreateTime.strftime('%Y-%m-%d %H:%M:%S') if self.CreateTime else '',
            'UpdateId': Kit.getUserNameById(self.UpdateId),
            'UpdateTime': self.UpdateTime.strftime('%Y-%m-%d %H:%M:%S') if self.UpdateTime else '',
            'IsActives': getStatusDescById(self.IsActive),
            'ParentName': Kit.getCompanyNameById(self.ParentId)
        }
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
