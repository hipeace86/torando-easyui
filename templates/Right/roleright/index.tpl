<table id="dgRoleRight" title="角色权限" toolbar="#toolbar-for-RoleRight-fb0922ed-b916-4166-8c55-51191da245bf" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true"></table>
<div id="toolbar-for-RoleRight-fb0922ed-b916-4166-8c55-51191da245bf">
    <div>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newEntity('RoleRight','right','新建角色权限')">新建角色权限</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editEntity('RoleRight','right','修改角色权限','RightId')">修改角色权限</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyEntity('RoleRight','right','RightId')">删除角色权限</a>
        <div>
            <a href="javascript:SearchRoleRight();" class="easyui-linkbutton" iconCls="icon-search">Search</a>  
        </div>
    </div>
</div>

<div id="dlgRoleRight" class="easyui-dialog" style="width:400px;height:440px;padding:10px 20px" closed="true" buttons="#dlg-buttons-RoleRight-fb0922ed-b916-4166-8c55-51191da245bf">
	<div class="ftitle">
		角色权限
	</div>
	<form id="formRoleRight" method="post" novalidate>
	
		<div class="fitem"><label>角色ID:</label><input name="RoleId"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>菜单功能ID:</label><input name="MenuFuncId"  class="easyui-validatebox" ></div>
		
		<input id='_method' name="_method" type="hidden" value=''/>
		{{ xsrf_form_html() }}
	</form>
</div>
<div id="dlg-buttons-RoleRight-fb0922ed-b916-4166-8c55-51191da245bf">
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveEntity('RoleRight','right')">保存</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgRoleRight').dialog('close')">取消</a>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		$('#dgRoleRight').datagrid({
			url:'/rest/right/roleright',
			 columns:[[
			 
				 	{field:'RoleId',title:'角色ID',width:100},
				 
				 	{field:'MenuFuncId',title:'菜单功能ID',width:100},
				 
				 	{field:'CreateId',title:'创建人ID',width:100},
				 
				 	{field:'CreateTime',title:'创建时间',width:100},
				 
				 	{field:'UpdateId',title:'修改人ID',width:100},
				 
				 	{field:'UpdateTime',title:'修改时间',width:100},
				 
    		]]  
		});
	});
	function SearchRoleRight(){
		
	}
</script>