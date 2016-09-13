<div class="easyui-layout"  data-options="fit:true">
	 <div data-options="region:'west',title:'类型',split:true" style="width:200px;">
	 	<ul id="typetree" class="easyui-tree">
	 		{% for item in types%}
    		<li id="{{item.Typeid}}">
        		<span>{{item.TypenameDesc}}</span>  
    		</li>  
    		{%end%}
		</ul>  
	 </div>  
	  <div data-options="region:'center',title:'状态列表'" style="padding:5px;background:#eee;">
	  
	  	<table id="dgStatuscode{{handler.uuid}}" toolbar="#toolbar-for-Statuscode-{{handler.uuid}}" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true"></table>
<div id="toolbar-for-Statuscode-{{handler.uuid}}">
    <div>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newEntity('Statuscode','common','新建状态代码表','{{handler.uuid}}')">新建状态代码表</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editEntity('Statuscode','common','修改状态代码表','CsId','{{handler.uuid}}')">修改状态代码表</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyEntity('Statuscode','common','CsId','{{handler.uuid}}')">删除状态代码表</a>
    </div>
</div>

<div id="dlgStatuscode{{handler.uuid}}" data-options="onOpen:function(){BeforeStatusDialogOpen();}"  class="easyui-dialog" style="width:400px;height:440px;padding:10px 20px" closed="true" buttons="#dlg-buttons-Statuscode-{{handler.uuid}}">
    <div class="ftitle">
        状态代码表
    </div>
    <form id="formStatuscode{{handler.uuid}}" method="post" novalidate>
        
        <div class="fitem"><label>英文名称:</label><input name="CsName"  class="easyui-validatebox" ></div>
        
        <div class="fitem"><label>中文描述:</label><input name="CsNameDesc"  class="easyui-validatebox" ></div>
        
        <div class="fitem"><label>显示顺序:</label><input name="Order"  class="easyui-numberbox" ></div>
        
        <input id='_method' name="_method" type="hidden" value=''/>
        <input id="Typeid" name="Typeid" type="hidden" >
        {{ xsrf_form_html() }}
    </form>
</div>
<div id="dlg-buttons-Statuscode-{{handler.uuid}}">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveEntity('Statuscode','base','{{handler.uuid}}')">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgStatuscode{{handler.uuid}}').dialog('close')">取消</a>
</div>
	  
	  </div> 
</div>

<script type="text/javascript">
    $(document).ready(function(){
        $('#dgStatuscode{{handler.uuid}}').datagrid({
             columns:[[
                 
                    {field:'CsName',title:'英文名称. 自动生成枚举项',width:100},
                 
                    {field:'CsNameDesc',title:'描述. 显示在DropDownList中, 供选择',width:100},
                 
                    {field:'Order',title:'显示顺序',width:100},
            ]]  
        });
        $('#typetree').tree({
        	onClick:function(node){
        		$('#dgStatuscode{{handler.uuid}}').datagrid({url:'/rest/common/typestatus/'+node.id});
        		$('#Typeid',$('#formStatuscode{{handler.uuid}}')).attr('attr',node.id);
        	}
        })
    });
    function BeforeStatusDialogOpen(){
    	$('#Typeid',$('#formStatuscode{{handler.uuid}}')).val($('#Typeid',$('#formStatuscode{{handler.uuid}}')).attr('attr'));
    }
</script>