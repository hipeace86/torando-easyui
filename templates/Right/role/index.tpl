<table id="dgRole{{handler.uuid}}" title="角色" toolbar="#toolbar-for-Role-{{handler.uuid}}" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true"></table>
<div id="toolbar-for-Role-{{handler.uuid}}">
    <div>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newEntity('Role','right','新建角色','{{handler.uuid}}')">新建角色</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editEntity('Role','right','修改角色','RoleId','{{handler.uuid}}')">修改角色</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyEntity('Role','right','RoleId','{{handler.uuid}}')">删除角色</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="assignRoleRight();">分配权限</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="assignRoleUser();">分配员工</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="assignRoleNode();">分配流程</a>
        <div>
            <a href="javascript:SearchRole();" class="easyui-linkbutton" iconCls="icon-search">Search</a>  
        </div>
    </div>
</div>

<div id="dlgRole{{handler.uuid}}" class="easyui-dialog" style="width:400px;height:440px;padding:10px 20px" closed="true" buttons="#dlg-buttons-Role-{{handler.uuid}}">
    <div class="ftitle">
        角色
    </div>
    <form id="formRole{{handler.uuid}}" method="post" novalidate>
    
        <div class="fitem"><label>角色名称:</label><input name="RoleName"  class="easyui-validatebox" ></div>
        
        <div class="fitem"><label>描述:</label><textarea name="RoleDesc" cols="20" rows-"3" type= class="easyui-validatabox"></textarea></div>
        
        <input id='_method' name="_method" type="hidden" value=''/>
        {{ xsrf_form_html() }}
    </form>
</div>
<div id="dlg-buttons-Role-{{handler.uuid}}">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveEntity('Role','right','{{handler.uuid}}')">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgRole{{handler.uuid}}').dialog('close')">取消</a>
</div>
<script type="text/javascript">
    $(document).ready(function(){
        $('#dgRole{{handler.uuid}}').datagrid({
            url:'/rest/right/role',
             columns:[[
             
                    {field:'RoleName',title:'角色名称',width:100},
                 
                    {field:'RoleDesc',title:'描述',width:100},
                 
                    {field:'CreateId',title:'创建人',width:100},
                 
                    {field:'CreateTime',title:'创建时间',width:100},
                 
                    {field:'UpdateId',title:'修改人',width:100},
                 
                    {field:'UpdateTime',title:'修改时间',width:100},
                 
            ]]  
        });
    });
    function SearchRole(){
        
    }
    function assignRoleRight(){
        var row = $('#dgRole{{handler.uuid}}').datagrid('getSelected');
        if (row){
            var title = "角色:" + row.RoleName + "----权限分配";
            if($('#tt').tabs('exists', title)) {
                    $('#tt').tabs('select', title);
                } else {
                    $('#tt').tabs('add', {
                        title : title,
                        href : '/right/assignroleright/'+row.RoleId,
                        closable : true
                    });
                }
        }
        else{
            $.messager.alert('Error', '请至少选择一条记录!', 'error');
        }
    }
    function assignRoleUser(){
        var row = $('#dgRole{{handler.uuid}}').datagrid('getSelected');
        if (row){
            var title = "角色:" + row.RoleName + "----分配员工";
            if($('#tt').tabs('exists', title)) {
                    $('#tt').tabs('select', title);
                } else {
                    $('#tt').tabs('add', {
                        title : title,
                        href : '/right/assignroleuser/'+row.RoleId,
                        closable : true,
                    });
                }
        }
        else{
            $.messager.alert('Error', '请至少选择一条记录!', 'error');
        }
    }
    function assignRoleNode(){
        var row = $('#dgRole{{handler.uuid}}').datagrid('getSelected');
        if (row){
            var title = "角色:" + row.RoleName + "----分配流程";
            if($('#tt').tabs('exists', title)) {
                    $('#tt').tabs('select', title);
                } else {
                    $('#tt').tabs('add', {
                        title : title,
                        href : '/right/assignrolenode/'+row.RoleId,
                        closable : true,
                    });
                }
        }
        else{
            $.messager.alert('Error', '请至少选择一条记录!', 'error');
        }
    }
</script>