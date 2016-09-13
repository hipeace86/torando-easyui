<table id="dgUser{{handler.uuid}}" title="用户" toolbar="#toolbar-for-User-{{handler.uuid}}" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true"></table>
<div id="toolbar-for-User-{{handler.uuid}}">
    <div>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newEntity('User','right','新建用户','{{handler.uuid}}')">新建用户</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editEntity('User','right','修改用户','UserId','{{handler.uuid}}')">修改用户</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyEntity('User','right','UserId','{{handler.uuid}}')">删除用户</a>
        <label>名称:</label><input id="UserName" class="easyui-validatebox" >
        <a href="javascript:SearchUser();" class="easyui-linkbutton" iconCls="icon-search">{{_("Search")}}</a>
    </div>
</div>

<div id="dlgUser{{handler.uuid}}" class="easyui-dialog" style="width:800px;height:490px;padding:10px 20px" closed="true" buttons="#dlg-buttons-User-{{handler.uuid}}">
	<div class="ftitle">
		用户
	</div>
	<form id="formUser{{handler.uuid}}" method="post" novalidate>
	
		<div class="fitem"><label>部门:</label><input name="Department"  class="easyui-combotree" data-options="url:'/rest/right/departtree',valueField:'id',textField:'text',pannelHeight:'auto'"></div>
		
		<div class="fitem"><label>职位:</label><input name="PosId"  class="easyui-combotree" data-options="url:'/rest/right/positiontree',valueField:'id',textField:'text',pannelHeight:'auto'" ></div>
		
		<div class="fitem"><label>用户名称:</label><input name="UserName"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>性别:</label>
			<select class="easyui-combobox" name="Gender">{{ modules.StatusCodeModule(2) }}</select>
		</div>
		
		<div class="fitem"><label>用户帐号:</label><input name="UserAccount" required="true" class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>电话:</label><input name="Phone"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>区域ID:</label><input name="AreaZone"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>地址:</label><input name="Address"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>手机:</label><input name="Mobile"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>Email:</label><input name="Email"  class="easyui-validatebox" validType="email"></div>
		
		<div class="fitem"><label>邮编:</label><input name="PostCode"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>是否允许外网登录:</label>
			<select class="easyui-combobox" name="IsElogin">{{ modules.StatusCodeModule(1) }}</select>
		</div>
		
		<div class="fitem"><label>生日:</label><input name="Birth"  class="easyui-datetimebox"  ></div>
		
		<div class="fitem"><label>是否有效:</label>
			<select class="easyui-combobox" name="IsActive">{{ modules.StatusCodeModule(1) }}</select>
		</div>
		
		<div class="fitem"><label>备注:</label><textarea name="Note"  cols='18' rows='3' type= class="easyui-validatebox"></textarea></div>
		
		<input id='_method' name="_method" type="hidden" value=''/>
		{{ xsrf_form_html() }}
	</form>
</div>
<div id="dlg-buttons-User-{{handler.uuid}}">
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveEntity('User','right','{{handler.uuid}}')">保存</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgUser{{handler.uuid}}').dialog('close')">取消</a>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		$('input[name=UserAccount]').change(function(){
			$.ajax({
				url:'/right/ajax/checkaccount',
				data:{account:$(this).val()},
				type:'POST',
				success:function(data){
					if(data == 'true'){
						$.messager.alert('Error', '帐号已存在，请修改！', 'error');
					}
				}
			});
		});
		$('#dgUser{{handler.uuid}}').datagrid({
			url:'/rest/right/user',
			 columns:[[
			 
				 	{field:'DepartmentName',title:'部门',width:100},
				 
				 	{field:'PosName',title:'职位',width:100},
				 
				 	{field:'UserName',title:'用户名称',width:100},
				 
				 	{field:'GenderName',title:'性别',width:100},
				 
				 	{field:'UserAccount',title:'用户帐号',width:100},
				 
				 	{field:'Email',title:'Email',width:100},
				 	
				 	{field:'IsActives',title:'是否有效',width:100},
				 
				 	{field:'PostCode',title:'邮编',width:100},
				 
				 	{field:'Birth',title:'生日',width:100},
				 
				 	{field:'LastLogin',title:'最近登陆时间',width:100},
				 
				 	{field:'LastUpdatePwd',title:'最近修改密码时间',width:100},
				 
				 	{field:'Note',title:'备注',width:100},
				 
				 	{field:'CreateId',title:'创建人',width:100},
				 
				 	{field:'CreateTime',title:'创建时间',width:100},
				 
				 	{field:'UpdateId',title:'修改人',width:100},
				 
				 	{field:'UpdateTime',title:'修改时间',width:100},
				 
    		]]  
		});
		
	});
	function SearchUser(){
		$('#dgUser{{handler.uuid}}').datagrid('load',{username:$('#UserName').val()});
	}
</script>