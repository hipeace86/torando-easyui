<table id="dgMenusFunction" title="菜单功能" toolbar="#toolbar-for-MenusFunction-c9c094d3-7cc3-4405-bc45-b4ed1b30dcf1" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true"></table>
<div id="toolbar-for-MenusFunction-c9c094d3-7cc3-4405-bc45-b4ed1b30dcf1">
    <div>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newEntity('MenusFunction','right','新建菜单功能')">新建菜单功能</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editEntity('MenusFunction','right','修改菜单功能','MenuFuncId')">修改菜单功能</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyEntity('MenusFunction','right','MenuFuncId')">删除菜单功能</a>
        <div>
            <a href="javascript:SearchMenusFunction();" class="easyui-linkbutton" iconCls="icon-search">Search</a>  
        </div>
    </div>
</div>

<div id="dlgMenusFunction" class="easyui-dialog" style="width:400px;height:440px;padding:10px 20px" closed="true" buttons="#dlg-buttons-MenusFunction-c9c094d3-7cc3-4405-bc45-b4ed1b30dcf1">
	<div class="ftitle">
		菜单功能
	</div>
	<form id="formMenusFunction" method="post" novalidate>
	
		<div class="fitem"><label>菜单ID:</label><input name="MenuId"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>菜单功能名称:</label><input name="MenuFuncName"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>URL:</label><input name="MenuFuncUrl"  class="easyui-validatebox" ></div>
		
		<input id='_method' name="_method" type="hidden" value=''/>
		{{ xsrf_form_html() }}
	</form>
</div>
<div id="dlg-buttons-MenusFunction-c9c094d3-7cc3-4405-bc45-b4ed1b30dcf1">
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveEntity('MenusFunction','right')">保存</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgMenusFunction').dialog('close')">取消</a>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		$('#dgMenusFunction').datagrid({
			url:'/rest/right/menusfunction',
			 columns:[[
			 
				 	{field:'MenuId',title:'菜单ID',width:100},
				 
				 	{field:'MenuFuncName',title:'菜单功能名称',width:100},
				 
				 	{field:'MenuFuncUrl',title:'URL',width:100},
				 
				 	{field:'CreateId',title:'创建人ID',width:100},
				 
				 	{field:'CreateTime',title:'创建时间',width:100},
				 
				 	{field:'UpdateId',title:'修改人ID',width:100},
				 
				 	{field:'UpdateTime',title:'修改时间',width:100},
				 
    		]]  
		});
	});
	function SearchMenusFunction(){
		
	}
</script>