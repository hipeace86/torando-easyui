insert into trt_compnay set fi_parent_id=0,fs_company_name='集团总部',fi_is_active=1;
insert into trt_department set fi_company=1,fi_parent_id=0,fs_depart_name='董事会';
insert into trt_user set fs_user_name='admin',fs_user_account='admin',fs_password=md5('111222'),fi_is_active=1,fi_is_elogin=1,fi_pos_id=1,fi_department=1;

/* Procedure structure for procedure `GetAllUser` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetAllUser` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `GetAllUser`(uid int)
begin
  declare departid,pos,ismanage,comid,ischarge int;
  if uid = 1 then
    select group_concat(fi_user_id) uid from trt_user;
  else
    /*职位和部门*/
  select fi_pos_id,fi_department into pos,departid from trt_user where fi_user_id = uid;
  /*是否管理职位*/
  select fi_ismanage into ismanage from trt_position where fi_pos_id  = pos;
  /*所在公司id*/
  select fi_company into comid from trt_department where fi_depart_id = departid;
        /*是否管理部门*/
        set ischarge = 0;
  if exists (select 1 from trt_company where fi_com_id = comid and fi_manage_depart = departid) then
               set ischarge =1;
  end if;
  /*员工在公司管理部门下;管理职位任职*/
  if (ischarge =1) and (ismanage =1) then
                select group_concat(u.fi_user_id) uid from trt_user u
                        left join trt_department d on d.fi_depart_id = u.fi_department
                        left join trt_company c on c.fi_com_id = d.fi_company
                where c.fi_com_id in (select comid union select fi_com_id from trt_company where fi_parent_id = comid);
        /*员工在公司管理部门下;非管理职位任职*/
  elseif(ischarge=1) and (ismanage =0)then
                select group_concat(u.fi_user_id) uid from trt_user u
                        left join trt_department d on d.fi_depart_id = u.fi_department
                        left join trt_company c on c.fi_com_id = d.fi_company
                        where c.fi_com_id = comid;
        /*员工不在公司管理部门下;管理职位任职*/
  elseif(ischarge=0) and (ismanage =1) then
                select group_concat(fi_user_id) uid from trt_user where fi_department in (select departid union select fi_depart_id from trt_department where fi_parent_id=departid);
        /*普通员工,只能看到自己数据*/
  else
                select uid;
  end if;
  end if;

    end */$$
DELIMITER ;

/* Procedure structure for procedure `GetMenusForUser` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetMenusForUser` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `GetMenusForUser`(uid int(5))
begin
  declare newnum int;
  declare oldnum int;
  set oldnum =0;
  set newnum =0;
  if (uid =1) then
    select * from trt_menus;
  end if;
  create  table funcid(fi_menu_func_id int(11)) engine=memory;
  insert into funcid select fi_menu_func_id from trt_role_right where fi_role_id in (select fi_role_id from trt_user_role where fi_user_id = uid);
  create table menuid(fi_menu_id int(11)) engine=memory;
  insert into menuid select fi_menu_id from trt_menus_function where fi_menu_func_id in (select fi_menu_func_id from funcid) ;
  select count(*) into newnum from menuid;
  while newnum > oldnum do
    set oldnum = newnum;
    insert into menuid  select fi_parent_id from trt_menus where fi_menu_id in (select fi_menu_id from menuid) and fi_parent_id not in (select fi_menu_id from menuid);
    select count(*) into newnum from menuid;
  end while;
  select * from trt_menus where fi_menu_id in (select fi_menu_id from menuid) or fi_is_share=1;
  drop table funcid;
  drop table menuid;
    end */$$
DELIMITER ;


/*Data for the table `t_statuscode` */

insert  into `t_statuscode`(`fi_cs_id`,`fi_typeid`,`fs_cs_name`,`fs_cs_name_desc`,`fi_order`,`fi_create_id`,`ft_create_time`,`fi_update_id`,`ft_update_time`) values (1,1,'Yes','是',1,NULL,NULL,NULL,NULL),(2,1,'No','否',1,NULL,NULL,NULL,NULL),(3,2,'Man','男',1,NULL,NULL,NULL,NULL),(4,2,'Woman','女',1,NULL,NULL,NULL,NULL),(151,41,'Agree','同意',1,NULL,NULL,NULL,NULL),(152,41,'NotAgree','不同意',1,NULL,NULL,NULL,NULL),(153,42,'Create','新建',1,NULL,NULL,NULL,NULL),(154,42,'Cloned','克隆',1,NULL,NULL,NULL,NULL),(155,43,'None','无特别限制',1,NULL,NULL,NULL,NULL),(156,43,'SameDepart','同一部门',1,NULL,NULL,NULL,NULL),(157,43,'SameCompany','同一公司',1,NULL,NULL,NULL,NULL),(158,44,'Exclusive','互斥',1,NULL,NULL,NULL,NULL),(159,44,'Mutual','共存',1,NULL,NULL,NULL,NULL),(160,45,'Value','值',1,NULL,NULL,NULL,NULL),(161,45,'Condition','条件',1,NULL,NULL,NULL,NULL),(162,46,'Great','>',1,NULL,NULL,NULL,NULL),(163,46,'GreatEqual','>=',1,NULL,NULL,NULL,NULL),(164,46,'Equal','=',1,NULL,NULL,NULL,NULL),(165,46,'LessEqual','<=',1,NULL,NULL,NULL,NULL),(166,46,'Less','<',1,NULL,NULL,NULL,NULL),(167,47,'TempSave','暂存',1,NULL,NULL,NULL,NULL),(168,47,'Go2Next','进入下一结点',1,NULL,NULL,NULL,NULL),(169,48,'Processing','正在进行',1,NULL,NULL,NULL,NULL),(170,48,'Stopping','暂停',1,NULL,NULL,NULL,NULL),(171,48,'Succeeded','成功结束',1,NULL,NULL,NULL,NULL),(172,48,'Cancelled','已被取消',1,NULL,NULL,NULL,NULL),(173,43,'NodeExecer','节点执行者',1,NULL,NULL,NULL,NULL),(251,71,'Day','每天',1,NULL,NULL,NULL,NULL),(252,71,'Week','每周',1,NULL,NULL,NULL,NULL),(253,71,'Month','每月',1,NULL,NULL,NULL,NULL),(254,71,'Year','每年',1,NULL,NULL,NULL,NULL),(255,72,'M5','5分钟',1,NULL,NULL,NULL,NULL),(256,72,'M10','10分钟',1,NULL,NULL,NULL,NULL),(257,72,'M20','20分钟',1,NULL,NULL,NULL,NULL),(258,72,'M30','30分钟',1,NULL,NULL,NULL,NULL),(259,72,'M60','1小时',1,NULL,NULL,NULL,NULL),(260,72,'M120','2小时',1,NULL,NULL,NULL,NULL),(261,72,'M720','半天',1,NULL,NULL,NULL,NULL),(262,72,'M1440','1天',1,NULL,NULL,NULL,NULL),(263,72,'M2880','2天',1,NULL,NULL,NULL,NULL),(264,72,'M4320','3天',1,NULL,NULL,NULL,NULL),(265,72,'M5760','4天',1,NULL,NULL,NULL,NULL),(266,72,'M7200','5天',1,NULL,NULL,NULL,NULL),(267,72,'M8640','6天',1,NULL,NULL,NULL,NULL),(268,72,'M10080','1周',1,NULL,NULL,NULL,NULL),(269,73,'Meeting','会议',1,NULL,NULL,NULL,NULL),(270,73,'Project','项目',1,NULL,NULL,NULL,NULL),(271,73,'Training','培训/学习',1,NULL,NULL,NULL,NULL),(272,73,'OutTask','外出办事',1,NULL,NULL,NULL,NULL),(273,73,'BusinessTrip','出差',1,NULL,NULL,NULL,NULL),(274,73,'IllLeave','病假',1,NULL,NULL,NULL,NULL),(275,73,'AffairLeave','事假',1,NULL,NULL,NULL,NULL),(276,73,'Privacy','个人',1,NULL,NULL,NULL,NULL),(277,73,'Party','公司/部门活动',1,NULL,NULL,NULL,NULL),(278,73,'Shopping','购物',1,NULL,NULL,NULL,NULL),(279,73,'Other','其他',1,NULL,NULL,NULL,NULL),(280,74,'NoStart','未开始',1,NULL,NULL,NULL,NULL),(281,74,'Finished','已完成',1,NULL,NULL,NULL,NULL),(282,74,'Cancelled','已取消',1,NULL,NULL,NULL,NULL),(283,74,'Delayed','已推迟',1,NULL,NULL,NULL,NULL),(284,75,'Late','迟到',1,NULL,NULL,NULL,NULL),(285,75,'LeaveEarly','早退',1,NULL,NULL,NULL,NULL),(286,75,'LLE','迟到且早退',1,NULL,NULL,NULL,NULL),(287,75,'Working','正常上班',1,NULL,NULL,NULL,NULL),(288,75,'IllLeave','病假',1,NULL,NULL,NULL,NULL),(289,75,'AffairLeave','事假',1,NULL,NULL,NULL,NULL),(290,75,'AdjustLeave','调休',1,NULL,NULL,NULL,NULL),(291,75,'AnnualLeave','年假',1,NULL,NULL,NULL,NULL),(292,75,'BizTrip','出差',1,NULL,NULL,NULL,NULL),(293,75,'Leave','法定假日',1,NULL,NULL,NULL,NULL),(294,75,'Recheck','补签',1,NULL,NULL,NULL,NULL),(295,75,'Outbiz','因公外出',1,NULL,NULL,NULL,NULL),(296,75,'Absent','旷工',1,NULL,NULL,NULL,NULL),(297,76,'Created','等待付款',1,NULL,NULL,NULL,NULL),(298,76,'Registing','已填报',1,NULL,NULL,NULL,NULL),(299,76,'PublicDoc','待邮寄',1,NULL,NULL,NULL,NULL),(300,76,'PrivateDoc','已邮寄',1,NULL,NULL,NULL,NULL);

/*Data for the table `t_typecode` */

insert  into `t_typecode`(`fi_typeid`,`fs_typename`,`fs_typename_desc`,`fi_flag`) values (1,'YesNo','是否',0),(2,'Gender','性别',0),(41,'Confirm','申批结果',0),(42,'WfModel','流程创建模式',0),(43,'WfeuShip','结点执行人关系',0),(44,'WfjcShip','判断条件之间的关系',0),(45,'WfjfType','判断条件字段内容类型',0),(46,'WfcmpShip','比较关系',0),(47,'WfoptWay','当前操作方式',0),(48,'WfStatus','流程状态',0),(71,'Cycle','重复周期',0),(72,'Remind','提醒时间',0),(73,'DailyType','日程类型',0),(74,'DailyStatus','日程状态',0),(75,'InOutType','考勤类型',0),(76,'OrderItemState','订单项状态',0),(77,'DocFlag','文档类型',0),(78,'Important','重要程度',0),(79,'EduDegree','教育程度',0),(80,'Folk','民族',0),(81,'Relation','家庭成员关系',0),(82,'Postion','职位',0),(83,'TechnicalPost','职称',0),(84,'AssetsState','资产状态',0),(85,'Incentive','奖惩类别',0),(86,'Visage','政治面貌',0),(87,'Marriage','婚姻状况',0);


/*Data for the table `trt_menus` */

insert  into `trt_menus`(`fi_menu_id`,`fs_menu_name`,`fs_menu_url`,`fi_parent_id`,`fs_comments`,`fi_order`,`fi_visiable`,`fi_create_id`,`ft_create_time`,`fi_update_id`,`ft_update_time`,`fi_is_share`) values (1,'系统设置','',0,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2,'权限设置','',1,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(3,'部门管理','/right/department',2,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(4,'部门管理','/rest/right/department/?([0-9]*)',25,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(5,'公司管理','/right/company',2,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(6,'公司管理','/rest/right/company/?([0-9]*)',25,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(7,'职位管理','/right/position',2,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(8,'职位管理','/rest/right/position/?([0-9]*)',25,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(9,'用户管理','/right/user',2,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(10,'用户管理','/rest/right/user/?([0-9]*)',25,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(11,'角色管理','/right/role',2,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(12,'角色管理','/rest/right/role/?([0-9]*)',25,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(13,'分配权限','/right/assignroleright/([0-9]*)',25,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(14,'分配用户','/right/assignroleuser/([0-9]*)',25,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(15,'分配流程','/right/assignrolenode/([0-9]*)',25,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(16,'菜单功能','/right/menusfunction',2,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(17,'菜单功能','/rest/right/menusfunction/?([0-9]*)',25,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(18,'登陆日志','/right/loglogin',2,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(19,'登陆日志','/rest/right/loglogin/?([0-9]*)',25,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(20,'密码修改日志','/right/logpassword',2,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(21,'密码修改日志','/rest/right/logpassword/?([0-9]*)',25,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(22,'菜单管理','/right/menus',2,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(23,'菜单管理','/rest/right/menus/?([0-9]*)',25,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(24,'系统设置',NULL,0,NULL,NULL,2,NULL,NULL,NULL,NULL,0),(25,'权限控制',NULL,24,NULL,NULL,2,NULL,NULL,NULL,NULL,0),(101,'我的流程','',0,NULL,20,1,NULL,NULL,NULL,NULL,1),(102,'加载流程','/workflow/launch/([0-9]*)',101,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(103,'流程执行','/workflow/exec/([0-9]*)/([0-9]*)/([0-9]*)',101,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(104,'流程执行下一步','/workflow/go2next/([0-9]*)/([0-9]*)/([0-9]*)',101,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(105,'流程列表','/workflow/list/?([0-9]*)',101,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL);


/*Data for the table `trt_menus_function` */

insert  into `trt_menus_function`(`fi_menu_func_id`,`fi_menu_id`,`fs_menu_func_name`,`fs_menu_func_url`,`fi_create_id`,`ft_create_time`,`fi_update_id`,`ft_update_time`) values (1,3,'查询','get',NULL,NULL,NULL,NULL),(2,0,'新建','post',NULL,NULL,NULL,NULL),(3,0,'修改','put',NULL,NULL,NULL,NULL),(4,0,'删除','delete',NULL,NULL,NULL,NULL),(5,4,'查询','get',NULL,NULL,NULL,NULL),(6,4,'新建','post',NULL,NULL,NULL,NULL),(7,4,'修改','put',NULL,NULL,NULL,NULL),(8,4,'删除','delete',NULL,NULL,NULL,NULL),(9,5,'查询','get',NULL,NULL,NULL,NULL),(10,0,'新建','post',NULL,NULL,NULL,NULL),(11,0,'修改','put',NULL,NULL,NULL,NULL),(12,0,'删除','delete',NULL,NULL,NULL,NULL),(13,6,'查询','get',NULL,NULL,NULL,NULL),(14,6,'新建','post',NULL,NULL,NULL,NULL),(15,6,'修改','put',NULL,NULL,NULL,NULL),(16,6,'删除','delete',NULL,NULL,NULL,NULL),(17,7,'查询','get',NULL,NULL,NULL,NULL),(18,0,'新建','post',NULL,NULL,NULL,NULL),(19,0,'修改','put',NULL,NULL,NULL,NULL),(20,0,'删除','delete',NULL,NULL,NULL,NULL),(21,8,'查询','get',NULL,NULL,NULL,NULL),(22,8,'新建','post',NULL,NULL,NULL,NULL),(23,8,'修改','put',NULL,NULL,NULL,NULL),(24,8,'删除','delete',NULL,NULL,NULL,NULL),(25,9,'查询','get',NULL,NULL,NULL,NULL),(26,0,'新建','post',NULL,NULL,NULL,NULL),(27,0,'修改','put',NULL,NULL,NULL,NULL),(28,0,'删除','delete',NULL,NULL,NULL,NULL),(29,10,'查询','get',NULL,NULL,NULL,NULL),(30,10,'新建','post',NULL,NULL,NULL,NULL),(31,10,'修改','put',NULL,NULL,NULL,NULL),(32,10,'删除','delete',NULL,NULL,NULL,NULL),(33,11,'查询','get',NULL,NULL,NULL,NULL),(34,0,'新建','post',NULL,NULL,NULL,NULL),(35,0,'修改','put',NULL,NULL,NULL,NULL),(36,0,'删除','delete',NULL,NULL,NULL,NULL),(37,12,'查询','get',NULL,NULL,NULL,NULL),(38,12,'新建','post',NULL,NULL,NULL,NULL),(39,12,'修改','put',NULL,NULL,NULL,NULL),(40,12,'删除','delete',NULL,NULL,NULL,NULL),(41,13,'查询','get',NULL,NULL,NULL,NULL),(42,13,'新建','post',NULL,NULL,NULL,NULL),(43,13,'修改','put',NULL,NULL,NULL,NULL),(44,13,'删除','delete',NULL,NULL,NULL,NULL),(45,14,'查询','get',NULL,NULL,NULL,NULL),(46,14,'新建','post',NULL,NULL,NULL,NULL),(47,14,'修改','put',NULL,NULL,NULL,NULL),(48,14,'删除','delete',NULL,NULL,NULL,NULL),(49,15,'查询','get',NULL,NULL,NULL,NULL),(50,15,'新建','post',NULL,NULL,NULL,NULL),(51,15,'修改','put',NULL,NULL,NULL,NULL),(52,15,'删除','delete',NULL,NULL,NULL,NULL),(53,16,'查询','get',NULL,NULL,NULL,NULL),(54,0,'新建','post',NULL,NULL,NULL,NULL),(55,0,'修改','put',NULL,NULL,NULL,NULL),(56,0,'删除','delete',NULL,NULL,NULL,NULL),(57,17,'查询','get',NULL,NULL,NULL,NULL),(58,17,'新建','post',NULL,NULL,NULL,NULL),(59,17,'修改','put',NULL,NULL,NULL,NULL),(60,17,'删除','delete',NULL,NULL,NULL,NULL),(61,18,'查询','get',NULL,NULL,NULL,NULL),(62,0,'新建','post',NULL,NULL,NULL,NULL),(63,0,'修改','put',NULL,NULL,NULL,NULL),(64,0,'删除','delete',NULL,NULL,NULL,NULL),(65,19,'查询','get',NULL,NULL,NULL,NULL),(66,19,'新建','post',NULL,NULL,NULL,NULL),(67,19,'修改','put',NULL,NULL,NULL,NULL),(68,19,'删除','delete',NULL,NULL,NULL,NULL),(69,20,'查询','get',NULL,NULL,NULL,NULL),(70,0,'新建','post',NULL,NULL,NULL,NULL),(71,0,'修改','put',NULL,NULL,NULL,NULL),(72,0,'删除','delete',NULL,NULL,NULL,NULL),(73,21,'查询','get',NULL,NULL,NULL,NULL),(74,21,'新建','post',NULL,NULL,NULL,NULL),(75,21,'修改','put',NULL,NULL,NULL,NULL),(76,21,'删除','delete',NULL,NULL,NULL,NULL),(77,22,'查询','get',NULL,NULL,NULL,NULL),(78,0,'新建','post',NULL,NULL,NULL,NULL),(79,0,'修改','put',NULL,NULL,NULL,NULL),(80,0,'删除','delete',NULL,NULL,NULL,NULL),(81,23,'查询','get',NULL,NULL,NULL,NULL),(82,23,'新建','post',NULL,NULL,NULL,NULL),(83,23,'修改','put',NULL,NULL,NULL,NULL),(84,23,'删除','delete',NULL,NULL,NULL,NULL);

/* Change auto_increment value*/
ALTER TABLE trt_menus AUTO_INCREMENT = 200;
ALTER TABLE trt_menus_function AUTO_INCREMENT = 1000;
