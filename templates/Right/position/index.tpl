<table id="dgPosition{{handler.uuid}}" title="职位" toolbar="#toolbar-for-Position-{{handler.uuid}}" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true"></table>
<div id="toolbar-for-Position-{{handler.uuid}}">
    <div>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newEntity('Position','right','新建职位','{{handler.uuid}}')">新建职位</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editEntity('Position','right','修改职位','PosId','{{handler.uuid}}')">修改职位</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyEntity('Position','right','PosId','{{handler.uuid}}')">删除职位</a>
        <div>
            <a href="javascript:SearchPosition();" class="easyui-linkbutton" iconCls="icon-search">Search</a>  
        </div>
    </div>
</div>

<div id="dlgPosition{{handler.uuid}}" class="easyui-dialog" style="width:400px;height:440px;padding:10px 20px" closed="true" buttons="#dlg-buttons-Position-{{handler.uuid}}">
    <div class="ftitle">
        职位
    </div>
    <form id="formPosition{{handler.uuid}}" method="post" novalidate>
    
        <div class="fitem"><label>职位名称:</label><input name="PosName"  class="easyui-validatebox" ></div>
        
        <div class="fitem"><label>描述:</label><input name="Comments"  class="easyui-validatebox" ></div>
        
        <div class="fitem"><label>直属上级:</label>
                <input class="easyui-combotree"   
                name="ParentId"  
                data-options="  
                        url:'/rest/right/positiontree',  
                        valueField:'id',  
                        textField:'text',
                        panelHeight:'auto',
                ">
        </div>
        <div class="fitem"><label>是否管理职位:</label>
			<select class="easyui-combobox" name="IsManage">{{ modules.StatusCodeModule(1) }}</select>
		</div>
        <input id='_method' name="_method" type="hidden" value=''/>
        {{ xsrf_form_html() }}
    </form>
</div>
<div id="dlg-buttons-Position-{{handler.uuid}}">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveEntity('Position','right','{{handler.uuid}}')">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgPosition{{handler.uuid}}').dialog('close')">取消</a>
</div>
<script type="text/javascript">
    $(document).ready(function(){
        $('#dgPosition{{handler.uuid}}').datagrid({
            url:'/rest/right/position',
             columns:[[
             
                    {field:'PosName',title:'职位名称',width:100},
                 
                    {field:'Comments',title:'描述',width:100},
                 
                    {field:'ParentName',title:'直属上级',width:100},
                 
                    {field:'CreateId',title:'创建人',width:100},
                 
                    {field:'CreateTime',title:'创建时间',width:100},
                 
                    {field:'UpdateId',title:'修改人',width:100},
                 
                    {field:'UpdateTime',title:'修改时间',width:100},
                 
            ]]  
        });
        
        
        
        
                
    });
    function SearchPosition(){
        
    }
</script>