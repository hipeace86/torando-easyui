# -*- coding: utf-8 -*-
import random
import os

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session
from sqlalchemy import desc

from yaml import load

from lib.Extension import DataUpdateExtension

BaseModel = declarative_base()


class Basebase(object):
    __mapper_args__ = {
        'extension': DataUpdateExtension()
    }
    __table_args__ = {
        'mysql_engine': 'MyIsam',
        'mysql_charset': 'utf8'
    }

    @classmethod
    def get_by_id(cls, ident):
        entity = session.query(cls).get(ident)
        session.close_all()
        return entity

    @classmethod
    def get_page_list(cls, page, pagesize):
        if hasattr(cls, 'CreateTime'):
            entitys = session.query(cls).order_by(desc(cls.CreateTime)).offset(
                (page - 1) * pagesize).limit(pagesize).all()
        else:
            entitys = session.query(cls).offset(
                (page - 1) * pagesize).limit(pagesize).all()

        session.close_all()
        return entitys

    @classmethod
    def get_count(cls):
        count = session.query(cls).count()
        session.close_all()
        return count

    @classmethod
    def get_by_list_id(cls, list):
        print cls.__mapper__.primary_key
#        return session.query(cls).filter(cls.pk.in_(list)).all()


class RightModel(Basebase):
    pass


class WorkflowModel(Basebase):
    pass


class ApiModel(Basebase):
    pass

yaml = load(file(os.path.join(os.path.abspath(
    os.path.join(__file__, '../../etc/')), 'config.yaml'), 'r'))
engines = {}
for item in yaml['engines'].items():
    engines[item[0]] = create_engine(
        item[1], pool_recycle=120, echo=True, max_overflow=0, pool_size=5)


class RoutingSession(Session):

    def get_bind(self, mapper=None, clause=None):
        if isinstance(mapper, basestring):
            return engines[mapper]
        elif mapper and issubclass(mapper.class_, RightModel):
            return engines['right']
        elif mapper and issubclass(mapper.class_, WorkflowModel):
            return engines['oa']
        elif mapper and issubclass(mapper.class_, Basebase):
            return engines['base']
        else:
            return engines[
                random.choice(['slave2'])
            ]

Session = sessionmaker(class_=RoutingSession, autocommit=False)
session = Session()
