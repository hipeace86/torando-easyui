<table id="dgHistory-{{handler.uuid}}" title="修改历史" toolbar="#toolbar-for-History-{{handler.uuid}}" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true"></table>
<div id="toolbar-for-History-{{handler.uuid}}">
   	<label>创建人</label><input id="Createid" name="CreateId" class="easyui-combobox" data-options="url:'/rest/right/usertree',valueField:'id',textField:'text'">
   	<label>信息类型</label>
   		<select id="Module" name="Module" class="easyui-combobox">
   			<option value="">请选择</option>
   			<option value="Crm.Entity.Customer">客户信息</option>
   			<option value="Crm.Entity.Info">咨询信息</option>
   			<option value="Crm.Entity.Payment">收款单</option>
   			<option value="Crm.Entity.Linkman">联系人</option>
   		</select>
   	<label>唯一识别号</label><input id="Ident" name="Ident" class="easyui-validatebox">
          <a href="javascript:SearchHistory();" class="easyui-linkbutton" iconCls="icon-search">{{ _('Search') }}</a>
          <a href="javascript:ClearHistoryFilter();" class="easyui-linkbutton">清除过滤条件</a>
</div>


<script type="text/javascript">
    $(document).ready(function(){
        $('#dgHistory-{{handler.uuid}}').datagrid({
            url:'/rest/common/history',
             columns:[[

                    {field:'Module',title:'命令空间',width:80},

                    {field:'Ident',title:'唯一识别号',width:40},

                    {field:'Postion',title:'操作位置',width:200},

                    {field:'CreateId',title:'创建人',width:100},

                    {field:'CreateTime',title:'创建时间',width:100},

                    {field:'UpdateId',title:'修改人',width:100},

                    {field:'UpdateTime',title:'修改时间',width:100},

            ]],
            onDblClickRow:function(rowIndex, rowData){
            	 $('#tt').tabs('add', {
                     title : '修改详情',
                     href : '/common/history/detail/'+rowData.IncrId,
                     closable : true,
                  });
            }
        });
    });
    function SearchHistory(){
    	var cid = $('#toolbar-for-History-{{handler.uuid}}').children('#Createid').combotree('getValue');
    	var m = $('#toolbar-for-History-{{handler.uuid}}').children('#Module').combobox('getValue');
    	var ident = $('#toolbar-for-History-{{handler.uuid}}').children('#Ident').val();
    	$('#dgHistory-{{handler.uuid}}').datagrid('load',{
    		CreateId:cid,
    		Module:m,
    		Ident:ident
    	});
    }
    function ClearHistoryFilter(){
    	$('#dgHistory-{{handler.uuid}}').datagrid('load',{});
    	$('#toolbar-for-History-{{handler.uuid}}').find('input').val('');
    }
</script>
