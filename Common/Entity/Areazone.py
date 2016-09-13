# -*- coding: utf-8 -*-
"""
Areazone 
@version:1.0.20130321
@author: Hipeace86
"""
from sqlalchemy import Column, Integer, String, DateTime
from lib.Route import BaseModel, Basebase
from lib.Route import session

from Right.Entity.Kit import Kit


class Areazone(Basebase, BaseModel):
    """
    区域
    """
    __tablename__ = 't_areazone'

    AreaId = Column('fi_area_id', Integer, primary_key=True)
    AreaName = Column('fs_area_name', String(100))
    ParentId = Column('fi_parent_id', Integer)
    Postcode = Column('fs_postcode', String(10))
    Note = Column('fs_note', String(1000))
    CreateId = Column('fi_create_id', Integer)
    CreateTime = Column('ft_create_time', DateTime)
    UpdateId = Column('fi_update_id', Integer)
    UpdateTime = Column('ft_update_time', DateTime)

    def toDict(self):
        return {
            'AreaId': self.AreaId,
            'AreaName': self.AreaName,
            'ParentId': self.ParentId,
            'Postcode': self.Postcode,
            'Note': self.Note,
            'CreateId': Kit.getUserNameById(self.CreateId),
            'CreateTime': self.CreateTime.strftime('%Y-%m-%d %H:%M:%S'),
            'UpdateId': Kit.getUserNameById(self.UpdateId),
            'UpdateTime': self.UpdateTime.strftime('%Y-%m-%d %H:%M:%S'),
        }
#=========================================================================
# 开发人员添加的其它所有代码请加到下面，以便生成的模板修改后重新生成的替换
#=========================================================================


def AreaZoneTree(filters=None):
    query = session.query(
        Areazone.AreaId, Areazone.AreaName, Areazone.ParentId)
    if filters:
        query = query.filter(Areazone.ParentId == filters)
    zones = query.all()
    results = []
    for area in zones:
        item = {'id': area[0], 'text': area[1], 'children': map(
            __CommonIdValueFilter, filter(lambda d: d[2] == area[0], zones))}
        for i in range(len(item['children'])):
            item['children'][i]['children'] = map(__CommonIdValueFilter, filter(
                lambda u: u[2] == item['children'][i]['id'], zones))
        results.append(item)
    return results


def __CommonIdValueFilter(sequence):
    return {'id': sequence[0], 'text': sequence[1]}
