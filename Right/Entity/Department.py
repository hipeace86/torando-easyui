# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from sqlalchemy import Column, Integer, String, DateTime, ForeignKey
from lib.Route import BaseModel, RightModel


from Right.Entity.Kit import Kit


class Department(RightModel, BaseModel):
    """
    部门
    """
    __tablename__ = 'trt_department'

    DepartId = Column('fi_depart_id', Integer, primary_key=True)
    Company = Column('fi_company', Integer)
    ParentId = Column('fi_parent_id', Integer,
                      ForeignKey('trt_department.fi_depart_id'))
    DepartName = Column('fs_depart_name', String(100))
    Comments = Column('fs_comments', String(1000))
    CreateId = Column('fi_create_id', Integer)
    CreateTime = Column('ft_create_time', DateTime)
    UpdateId = Column('fi_update_id', Integer)
    UpdateTime = Column('ft_update_time', DateTime)
    IsCharge = Column('fi_is_charge', Integer)

    def toDict(self):
        return {
            'DepartId': self.DepartId,
            'Company': self.Company,
            'ParentId': self.ParentId,
            'DepartName': self.DepartName,
            'Comments': self.Comments,
            'CreateId': Kit.getUserNameById(self.CreateId),
            'CreateTime': self.CreateTime.strftime('%Y-%m-%d %H:%M:%S') if self.CreateTime else '',
            'UpdateId': Kit.getUserNameById(self.UpdateId),
            'UpdateTime': self.UpdateTime.strftime('%Y-%m-%d %H:%M:%S') if self.UpdateTime else '',
            'CompanyName': Kit.getCompanyNameById(self.Company),
            'ParentName': Kit.getDepartmentNameById(self.ParentId),
        }
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================

    def recursive(self, dest_list):
        if self.Childrens:
            for c in self.Childrens:
                c.recursive(dest_list)
        else:
            dest_list.append(self.DepartId)
        return
