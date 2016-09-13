# -*- coding: utf-8 -*-
"""
RedisCache 
@version:1.0.20130506
@author: Hipeace86
"""

import redis

RedisCache = redis.Redis(host='localhost', port=6379, db=8)
RightsCache = redis.Redis(host='localhost', port=6379, db=10)
