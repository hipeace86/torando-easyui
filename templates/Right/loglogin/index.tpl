<table id="dgLogLogin" title="用户登陆日志" toolbar="#toolbar-for-LogLogin-4e669650-15f2-4430-8abb-be477e73932e" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true"></table>
<div id="toolbar-for-LogLogin-4e669650-15f2-4430-8abb-be477e73932e">
	<div>
		<div>
        	<a href="javascript:SearchLogLogin();" class="easyui-linkbutton" iconCls="icon-search">Search</a>  
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		$('#dgLogLogin').datagrid({
			url:'/rest/right/loglogin',
			 columns:[[
			 
				 	{field:'UserName',title:'用户名',width:100},
				 
				 	{field:'Ip',title:'登录IP',width:100},
				 
				 	{field:'Hostname',title:'登录主机名',width:100},
				 
				 	{field:'Hostuser',title:'登录主机用户',width:100},
				 
				 	{field:'Location',title:'登录位置',width:100},
				 
				 	{field:'LoginTime',title:'登陆时间',width:100},
				 
				 	{field:'ExitTime',title:'退出时间',width:100},
				 
    		]]  
		});
	});
	function SearchLogLogin(){
		
	}
</script>