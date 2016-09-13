# -*- coding: utf-8 -*-
import os
import shutil
import re


for root, dirs, files in os.walk('.'):
    for file in files:
        if file[-3:] == 'tpl':
            filename = "{0}/{1}".format(root, file)
            print filename
            f, ext = os.path.splitext(file)
            fh = open(filename)
            lines = fh.readlines()
            fh.close()
            process = re.compile('\s+')
            fh = open(os.path.join(root, f + ".html"), 'w')
            fh.write(re.sub(process, ' ', ''.join(lines)))
            fh.close()
shutil.copyfile('needpwd.tpl', 'needpwd.html')
