# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from lib.Route import BaseModel, Basebase


class Typecode(Basebase, BaseModel):
    """
    状态类型表
    """
    __tablename__ = 't_typecode'

    Typeid = Column('fi_typeid', Integer, primary_key=True)
    Typename = Column('fs_typename', String(50))
    TypenameDesc = Column('fs_typename_desc', String(50))
    Flag = Column('fi_flag', Integer)
    StatusCodes = relationship('Statuscode')

    def toDict(self):
        return {
            'Typeid': self.Typeid,
            'Typename': self.Typename,
            'TypenameDesc': self.TypenameDesc,
            'Flag': self.Flag,
        }
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
