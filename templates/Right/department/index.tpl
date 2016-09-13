<table id="dgDepartment{{handler.uuid}}" title="部门" toolbar="#toolbar-for-Department-{{handler.uuid}}" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true"></table>
<div id="toolbar-for-Department-{{handler.uuid}}">
    <div>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newEntity('Department','right','新建部门','{{handler.uuid}}')">新建部门</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editEntity('Department','right','修改部门','DepartId','{{handler.uuid}}')">修改部门</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyEntity('Department','right','DepartId','{{handler.uuid}}')">删除部门</a>
        <div>
            <a href="javascript:SearchDepartment();" class="easyui-linkbutton" iconCls="icon-search">Search</a>  
        </div>
    </div>
</div>

<div id="dlgDepartment{{handler.uuid}}" class="easyui-dialog" style="width:400px;height:440px;padding:10px 20px" closed="true" buttons="#dlg-buttons-Department-{{handler.uuid}}">
	<div class="ftitle">
		部门
	</div>
	<form id="formDepartment{{handler.uuid}}" method="post" novalidate>
	
		<div class="fitem"><label>公司名称:</label><input name="Company"  class="easyui-combotree" data-options="url:'/rest/right/companytree',valueField:'id',textField:'text',pannelHeight:'auto'" ></div>
		
		<div class="fitem"><label>上级部门:</label><input name="ParentId"   class="easyui-combotree" data-options="url:'/rest/right/departtree',valueField:'id',textField:'text',pannelHeight:'auto'"></div>
		
		<div class="fitem"><label>部门名称:</label><input name="DepartName"  class="easyui-validatebox"></div>
		<div class="fitem"><label>是否管理部门:</label>
			<select class="easyui-combobox" name="IsCharge">{{ modules.StatusCodeModule(1) }}</select>
		</div>
		<div class="fitem"><label>描述:</label><textarea name="Comments"></textarea></div>
		
		<input id='_method' name="_method" type="hidden" value=''/>
		{{ xsrf_form_html() }}
	</form>
</div>
<div id="dlg-buttons-Department-{{handler.uuid}}">
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveEntity('Department','right','{{handler.uuid}}')">保存</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgDepartment{{handler.uuid}}').dialog('close')">取消</a>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		$('#dgDepartment{{handler.uuid}}').datagrid({
			url:'/rest/right/department',
			 columns:[[
			 
				 	{field:'CompanyName',title:'所属公司',width:100},
				 
				 	{field:'ParentName',title:'上级部门',width:100},
				 
				 	{field:'DepartName',title:'部门名称',width:100},
				 
				 	{field:'Comments',title:'描述',width:100},
				 
				 	{field:'CreateId',title:'创建人',width:100},
				 
				 	{field:'CreateTime',title:'创建时间',width:100},
				 
				 	{field:'UpdateId',title:'修改人',width:100},
				 
				 	{field:'UpdateTime',title:'修改时间',width:100},
				 
    		]]  
		});
	});
	function SearchDepartment(){
		
	}
</script>