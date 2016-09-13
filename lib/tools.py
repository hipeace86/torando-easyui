# -*- coding: utf-8 -*-
__author__ = 'Hipeace86'
import types
import md5
import os
import uuid
from datetime import datetime
import pickle
import cStringIO
import base64


def str_to_class(s):
    if s in globals() and isinstance(globals()[s], types.ClassType):
        return globals()[s]
    return None


def import_class(cl):
    d = cl.encode('utf8').rfind(".")
    classname = cl[d + 1:len(cl)]
    m = __import__(cl[0:d], globals(), locals(), [classname])
    return getattr(m, classname)


def LoadClass(clsname):
    try:
        r = clsname.rfind('.')
        dname = '__main__'
        bname = clsname
        if r >= 0:
            dname = clsname[0:r]
            bname = clsname[r + 1:]
        mod = __import__(dname)
        klass = getattr(mod, bname)
        return klass
    except:
        return None


def md5hash(s):
    m = md5.new(s)
    m.digest()
    return m.hexdigest()


def saveUploadFile(fileinfo):
    fname = fileinfo['filename']
    extn = os.path.splitext(fname)[1]
    cname = str(uuid.uuid4()) + extn
    fpath = "uploads/%s/" % (datetime.now().strftime('%Y/%m/%d'))
    if not os.path.exists(fpath):
        os.makedirs(fpath)
    fh = open(fpath + cname, 'w')
    fh.write(fileinfo['body'])
    fh.close()
    return fpath + cname


def Serialization(obj):
    """
        返回序列化后对象的base64表示
    """
    base = cStringIO.StringIO()
    fs = cStringIO.StringIO()
    pick = pickle.Pickler(fs)
    pick.dump(obj)
    fs.seek(0)
    base64.encode(fs, base)
    base.seek(0)
    result = base.getvalue()
    fs.close()
    base.close()
    return result


def UnSerialization(str):
    """
        把base64字符串反序列化为对象
    """
    st = cStringIO.StringIO()
    so = cStringIO.StringIO()
    st.write(str)
    st.seek(0)
    base64.decode(st, so)
    so.seek(0)
    unpick = pickle.Unpickler(so)
    obj = unpick.load()
    st.close()
    so.close()
    return obj

# 人民币金额转大写程序Python版本
# Copyright: zinges at foxmail.com
# blog: http://zingers.iteye.com
# 感谢zinges提供了Python的版本
import math


def Number2Chinese(num):
    capUnit = ['万', '亿', '万', '', '']
    capDigit = {2: ['角', '分', ''], 4: ['仟', '佰', '拾', '']}
    capNum = ['零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖']
    snum = str('%019.02f') % num
    if snum.index('.') > 16:
        return ''
    ret, nodeNum, subret, subChr = '', '', '', ''
    CurChr = ['', '']
    for i in range(5):
        j = int(i * 4 + math.floor(i / 4))
        subret = ''
        nodeNum = snum[j:j + 4]
        lens = len(nodeNum)
        for k in range(lens):
            if int(nodeNum[k:]) == 0:
                continue
            CurChr[k % 2] = capNum[int(nodeNum[k:k + 1])]
            if nodeNum[k:k + 1] != '0':
                CurChr[k % 2] += capDigit[lens][k]
            if not ((CurChr[0] == CurChr[1]) and (CurChr[0] == capNum[0])):
                if not((CurChr[k % 2] == capNum[0]) and (subret == '') and (ret == '')):
                    subret += CurChr[k % 2]
        subChr = [subret, subret + capUnit[i]][subret != '']
        if not ((subChr == capNum[0]) and (ret == '')):
            ret += subChr
    return [ret, capNum[0] + capUnit[3]][ret == '']
