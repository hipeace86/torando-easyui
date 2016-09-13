<table id="dgLogPassword" title="密码修改日志" toolbar="#toolbar-for-LogPassword-3fc2631f-ee08-4904-9980-bcba916fb185" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true"></table>
<div id="toolbar-for-LogPassword-3fc2631f-ee08-4904-9980-bcba916fb185">
	<div>
		<div>
        	<a href="javascript:SearchLogPassword();" class="easyui-linkbutton" iconCls="icon-search">Search</a>  
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		$('#dgLogPassword').datagrid({
			url:'/rest/right/logpassword',
			 columns:[[
			 
				 	{field:'UserName',title:'用户名',width:100},
				 
				 	{field:'OldPassword',title:'原密码',width:100},
				 
				 	{field:'CreateId',title:'创建人',width:100},
				 
				 	{field:'CreateTime',title:'创建时间',width:100},
				 
				 	{field:'UpdateId',title:'修改人',width:100},
				 
				 	{field:'UpdateTime',title:'修改时间',width:100},
				 
    		]]  
		});
	});
	function SearchLogPassword(){
		
	}
</script>