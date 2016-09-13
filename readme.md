# tornado+easyui 项目示例

## 运行

* 0x00

        pip install -r requirements.txt

* 0x01

        创建/etc/config.yaml里配置的数据库

* 0x02

        python initdb.py

* 0x03

         insert into trt_user set fs_user_name='admin',fs_user_account='admin',fs_password=md5('111222'),fi_is_active=1,fi_is_elogin=1;

* 0x04

        cd templates
        python pycompress.py

* 0x05

        python app.py

* 0x06

        google-chrome localhost:4000

# 功能

* RBAC权限管理
* ....
