<table id="dgCompany{{handler.uuid}}" title="公司" toolbar="#toolbar-for-Company-{{handler.uuid}}" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true"></table>
<div id="toolbar-for-Company-{{handler.uuid}}">
    <div>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newEntity('Company','right','新建公司','{{handler.uuid}}')">新建公司</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editEntity('Company','right','修改公司','ComId','{{handler.uuid}}')">修改公司</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyEntity('Company','right','ComId','{{handler.uuid}}')">删除公司</a>
        <div>
            <a href="javascript:SearchCompany();" class="easyui-linkbutton" iconCls="icon-search">Search</a>  
        </div>
    </div>
</div>

<div id="dlgCompany{{handler.uuid}}" class="easyui-dialog" style="width:400px;height:440px;padding:10px 20px" closed="true" buttons="#dlg-buttons-Company-{{handler.uuid}}">
	<div class="ftitle">
		公司
	</div>
	<form id="formCompany{{handler.uuid}}" method="post" novalidate>
	
		<div class="fitem"><label>上级公司:</label><input name="ParentId"  class="easyui-combotree"
			 data-options="  
	                    url:'/rest/right/companytree',  
	                    valueField:'id',  
	                    textField:'text',
	                    panelHeight:'auto',
	            
		" ></div>
		
		<div class="fitem"><label>公司名称:</label><input name="CompanyName"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>区域ID:</label><input name="AreaZone"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>地址:</label><input name="Address"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>行业ID:</label><input name="Trade"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>公司性质:</label><input name="KindCode"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>规模:</label><input name="Size"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>电话:</label><input name="Phone"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>传真:</label><input name="Fax"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>主页:</label><input name="Homepage"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>是否有效:</label>
			<select class="easyui-combobox" name="IsActive">{{ modules.StatusCodeModule(1) }}</select>
		</div>
		
		<div class="fitem"><label>备注:</label><textarea name="Comment"></textarea></div>
		
		<input id='_method' name="_method" type="hidden" value=''/>
		{{ xsrf_form_html() }}
	</form>
</div>
<div id="dlg-buttons-Company-{{handler.uuid}}">
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveEntity('Company','right',{{handler.uuid}})">保存</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgCompany{{handler.uuid}}').dialog('close')">取消</a>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		$('#dgCompany{{handler.uuid}}').datagrid({
			url:'/rest/right/company',
			 columns:[[
			 
				 	{field:'ParentName',title:'上级公司',width:100},
				 
				 	{field:'CompanyName',title:'公司名称',width:100},
				 
				 	{field:'AreaZone',title:'区域ID',width:100},
				 
				 	{field:'Address',title:'地址',width:100},
				 
				 	{field:'Trade',title:'行业ID',width:100},
				 
				 	{field:'KindCode',title:'公司性质',width:100},
				 
				 	{field:'Size',title:'规模',width:100},
				 
				 	{field:'Phone',title:'电话',width:100},
				 
				 	{field:'Fax',title:'传真',width:100},
				 
				 	{field:'Homepage',title:'主页',width:100},
				 
				 	{field:'IsActives',title:'是否有效',width:100},
				 
				 	{field:'Comment',title:'备注',width:100},
				 
				 	{field:'CreateId',title:'创建人',width:100},
				 
				 	{field:'CreateTime',title:'创建时间',width:100},
				 
				 	{field:'UpdateId',title:'修改人',width:100},
				 
				 	{field:'UpdateTime',title:'修改时间',width:100},
				 
    		]]  
		});
	});
	function SearchCompany(){
		
	}
</script>