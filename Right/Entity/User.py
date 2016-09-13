# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from sqlalchemy import Column, Integer, String, DateTime
from lib.Route import BaseModel, RightModel
from Common.Entity.functions import getStatusDescById

from Right.Entity.Kit import Kit


class User(RightModel, BaseModel):
    """
    用户
    """
    __tablename__ = 'trt_user'

    UserId = Column('fi_user_id', Integer, primary_key=True)
    Department = Column('fi_department', Integer)
    PosId = Column('fi_pos_id', Integer)
    UserName = Column('fs_user_name', String(100))
    Gender = Column('fi_gender', Integer)
    UserAccount = Column('fs_user_account', String(50))
    Password = Column('fs_password', String(100))
    Phone = Column('fs_phone', String(50))
    AreaZone = Column('fi_area_zone', Integer)
    Address = Column('fs_address', String(200))
    Mobile = Column('fs_mobile', String(50))
    Email = Column('fs_email', String(100))
    PostCode = Column('fs_post_code', String(10))
    IsElogin = Column('fi_is_elogin', Integer)
    Birth = Column('ft_birth', DateTime)
    LastLogin = Column('ft_last_login', DateTime)
    LastUpdatePwd = Column('ft_last_update_pwd', DateTime)
    IsActive = Column('fi_is_active', Integer)
    Note = Column('fs_note', String(1000))
    CreateId = Column('fi_create_id', Integer)
    CreateTime = Column('ft_create_time', DateTime)
    UpdateId = Column('fi_update_id', Integer)
    UpdateTime = Column('ft_update_time', DateTime)

    def toDict(self):
        return {
            'UserId': self.UserId,
            'Department': self.Department,
            'PosId': self.PosId,
            'UserName': self.UserName,
            'Gender': self.Gender,
            'UserAccount': self.UserAccount,
            'Password': self.Password,
            'Phone': self.Phone,
            'AreaZone': self.AreaZone,
            'Address': self.Address,
            'Mobile': self.Mobile,
            'Email': self.Email,
            'PostCode': self.PostCode,
            'IsElogin': self.IsElogin,
            'Birth': self.Birth.strftime('%Y-%m-%d %H:%M:%S') if self.Birth else '',
            'LastLogin': self.LastLogin.strftime('%Y-%m-%d %H:%M:%S') if self.LastLogin else '',
            'LastUpdatePwd': self.LastUpdatePwd.strftime('%Y-%m-%d %H:%M:%S') if self.LastUpdatePwd else '',
            'IsActive': self.IsActive,
            'Note': self.Note,
            'CreateId': Kit.getUserNameById(self.CreateId),
            'CreateTime': self.CreateTime.strftime('%Y-%m-%d %H:%M:%S') if self.CreateTime else '',
            'UpdateId': Kit.getUserNameById(self.UpdateId),
            'UpdateTime': self.UpdateTime.strftime('%Y-%m-%d %H:%M:%S') if self.UpdateTime else '',
            'IsElogins': getStatusDescById(self.IsElogin),
            'IsActives': getStatusDescById(self.IsActive),
            'GenderName': getStatusDescById(self.Gender),
            'DepartmentName': Kit.getDepartmentNameById(self.Department),
            'PosName': Kit.getPostionNameById(self.PosId),
        }
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
