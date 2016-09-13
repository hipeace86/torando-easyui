<table id="dgUserRole" title="用户角色" toolbar="#toolbar-for-UserRole-60236148-3527-47f7-b324-c1159cbb46bf" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true"></table>
<div id="toolbar-for-UserRole-60236148-3527-47f7-b324-c1159cbb46bf">
    <div>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newEntity('UserRole','right','新建用户角色')">新建用户角色</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editEntity('UserRole','right','修改用户角色','UrId')">修改用户角色</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyEntity('UserRole','right','UrId')">删除用户角色</a>
        <div>
            <a href="javascript:SearchUserRole();" class="easyui-linkbutton" iconCls="icon-search">Search</a>  
        </div>
    </div>
</div>

<div id="dlgUserRole" class="easyui-dialog" style="width:400px;height:440px;padding:10px 20px" closed="true" buttons="#dlg-buttons-UserRole-60236148-3527-47f7-b324-c1159cbb46bf">
	<div class="ftitle">
		用户角色
	</div>
	<form id="formUserRole" method="post" novalidate>
	
		<div class="fitem"><label>用户ID:</label><input name="UserId"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>角色ID:</label><input name="RoleId"  class="easyui-validatebox" ></div>
		
		<input id='_method' name="_method" type="hidden" value=''/>
		{{ xsrf_form_html() }}
	</form>
</div>
<div id="dlg-buttons-UserRole-60236148-3527-47f7-b324-c1159cbb46bf">
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveEntity('UserRole','right')">保存</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgUserRole').dialog('close')">取消</a>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		$('#dgUserRole').datagrid({
			url:'/rest/right/userrole',
			 columns:[[
			 
				 	{field:'UserId',title:'用户ID',width:100},
				 
				 	{field:'RoleId',title:'角色ID',width:100},
				 
				 	{field:'CreateId',title:'创建人ID',width:100},
				 
				 	{field:'CreateTime',title:'创建时间',width:100},
				 
				 	{field:'UpdateId',title:'修改人ID',width:100},
				 
				 	{field:'UpdateTime',title:'修改时间',width:100},
				 
    		]]  
		});
	});
	function SearchUserRole(){
		
	}
</script>