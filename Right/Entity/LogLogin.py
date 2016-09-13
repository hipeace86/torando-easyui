# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
from sqlalchemy import Column, Integer, String, DateTime
from lib.Route import BaseModel, RightModel
from Right.Entity.Kit import Kit


class LogLogin(RightModel, BaseModel):
    """
    用户登陆日志
    """
    __tablename__ = 'trt_log_login'

    LogId = Column('fi_log_id', Integer, primary_key=True)
    UserId = Column('fi_user_id', Integer)
    Ip = Column('fs_ip', String(50))
    Hostname = Column('fs_hostname', String(100))
    Hostuser = Column('fs_hostuser', String(100))
    Location = Column('fs_location', String(50))
    LoginTime = Column('ft_login_time', DateTime)
    ExitTime = Column('ft_exit_time', DateTime)

    def toDict(self):
        return {
            'LogId': self.LogId,
            'UserId': self.UserId,
            'Ip': self.Ip,
            'Hostname': self.Hostname,
            'Hostuser': self.Hostuser,
            'Location': self.Location,
            'LoginTime': self.LoginTime.strftime('%Y-%m-%d %H:%M:%S') if self.LoginTime else '',
            'ExitTime': self.ExitTime.strftime('%Y-%m-%d %H:%M:%S') if self.ExitTime else '',
            'UserName': Kit.getUserNameById(self.UserId),
        }
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================
