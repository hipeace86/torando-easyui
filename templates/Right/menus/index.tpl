<div class="easyui-layout"  data-options="fit:true">
	<div data-options="region:'west',title:'菜单',split:true" style="width:300px;">
	 	{{menus}}
	 </div>
	<div data-options="region:'center',title:'详情'" style="padding:5px;background:#eee;">
		<div>
			<div class="ftitle">
				菜单
			</div>
			<form id="formMenus{{handler.uuid}}" method="post" novalidate>
				<div class="fitem"><label>菜单名称:</label><input name="MenuName"  class="easyui-validatebox" ></div>
				<div class="fitem"><label>URL:</label><input name="MenuUrl"  class="easyui-validatebox" ></div>
				<div class="fitem"><label>父菜单:</label><input name="ParentId"  class="easyui-combotree" data-options="url:'/rest/right/menujson'"></div>
				<div class="fitem"><label>序号:</label><input name="Order"  class="easyui-numberbox" ></div>
				<div class="fitem"><label>描述:</label><textarea name="Comments" cols="20" rows="3" type= class="easyui-validatabox"></textarea></div>
			    <div class="fitem"><label>是否显示:</label>
			    		<select class="easyui-combobox" name="Visiable">{{ modules.StatusCodeModule(1) }}</select>
			    </div>
				<input id='_method' name="_method" type="hidden" value='put'/>
				{{ xsrf_form_html() }}
			</form>
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveEntity('Menus','right','{{handler.uuid}}')">保存</a>
		</div>
		<input type="hidden" id="currentMenuId" />
		<table id="dgMenusFunction{{handler.uuid}}" title="菜单功能" toolbar="#toolbar-for-MenusFunction-{{handler.uuid}}" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true"></table>
		<div id="toolbar-for-MenusFunction-{{handler.uuid}}">
		    <div>
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newEntity('MenusFunction','right','新建菜单功能','{{handler.uuid}}');setMenuid();">新建菜单功能</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editEntity('MenusFunction','right','修改菜单功能','MenuFuncId','{{handler.uuid}}')">修改菜单功能</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyEntity('MenusFunction','right','MenuFuncId','{{handler.uuid}}')">删除菜单功能</a>
		    </div>
		</div>
	</div>
</div>

<div id="dlgMenusFunction{{handler.uuid}}" class="easyui-dialog" style="width:400px;height:440px;padding:10px 20px" closed="true" buttons="#dlg-buttons-MenusFunction-{{handler.uuid}}">
	<div class="ftitle">
		菜单功能
	</div>
	<form id="formMenusFunction{{handler.uuid}}" method="post" novalidate>
	
		<input name="MenuId" type="hidden" class="easyui-validatebox" >
		
		<div class="fitem"><label>菜单功能名称:</label><input name="MenuFuncName"  class="easyui-validatebox" ></div>
		
		<div class="fitem"><label>URL:</label><input name="MenuFuncUrl"  class="easyui-validatebox" ></div>
		
		<input id='_method' name="_method" type="hidden" value=''/>
		{{ xsrf_form_html() }}
	</form>
</div>
<div id="dlg-buttons-MenusFunction-{{handler.uuid}}">
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveEntity('MenusFunction','right','{{handler.uuid}}')">保存</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgMenusFunction{{handler.uuid}}').dialog('close')">取消</a>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		$('#dgMenusFunction{{handler.uuid}}').datagrid({
			 columns:[[
				 
				 	{field:'MenuFuncName',title:'菜单功能名称',width:100},
				 
				 	{field:'MenuFuncUrl',title:'URL',width:100},
				 
    		]]  
		});
		$('[id^=menumanagetree]').tree({onClick:function(node){
			if(node.id){
				$('#dgMenusFunction{{handler.uuid}}').datagrid({url:'/rest/right/menusfunctionformenu/'+node.id});
				$('#_method',$('#formMenus{{handler.uuid}}')).attr('url','/rest/right/menus/'+node.id);
				$('#currentMenuId').val(node.id);
				$.ajax({
					url:'/rest/right/menus/'+node.id,
					type:'get',
					dataType: "json",
					success: function(data){
						$('#formMenus{{handler.uuid}}').form('load',data);
					}
				});
			}
		}});
	});

	function setMenuid(){
		$('input[name=MenuId]',$('#formMenusFunction{{handler.uuid}}')).val($('#currentMenuId').val());
	}
</script>