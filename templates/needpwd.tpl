<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="{{ static_url("themes/bootstrap.min.css") }}">
		<link rel="stylesheet" type="text/css" href="{{ static_url("themes/bootstrap-responsive.min.css") }}">
		<script type="text/javascript" src="{{ static_url("js/jquery-1.8.0.min.js") }}"></script>
		<script type="text/javascript" src="{{ static_url("js/bootstrap.min.js") }}"></script>
		<script type="text/javascript" src="{{ static_url("js/prototype.js")}}"></script>
	</head>
<body>
	<div class="container">
		<div class="modal" id="password_modal">
		    <div class="modal-header">
		    	<div class="span6 offset1">
		    		<span class="alert alert-danger">{{ errorMsg }}</span>
		    	</div>
		    </div>
		    <div class="modal-body form-horizontal">
		        <div class="control-group">
		            <label for="current_password" class="control-label">当前密码</label>
		            <div class="controls">
		                <input type="password" name="current_password">
		            </div>
		        </div>
		        <div class="control-group">
		            <label for="new_password" class="control-label">新密码</label>
		            <div class="controls">
		                <input type="password" name="new_password">
		            </div>
		        </div>
		        <div class="control-group">
		            <label for="confirm_password" class="control-label">确认新密码</label>
		            <div class="controls">
		                <input type="password" name="confirm_password">
		            </div>
		        </div>      
		    </div>
		    <div class="modal-footer">
		    	<span class="alert alert-warning">必需输入原密码和新密码，并且新密码在120天内没有使用过！</span>
		        <button href="#" class="btn btn-primary" id="password_modal_save">保存</button>
		    </div>
		</div>
	</div>
	<script>
		$('#password_modal_save').click(function(){
			var oldPass= $('input[name=current_password]').val();
			var newPass= $('input[name=new_password]').val();
			var againPass= $('input[name=confirm_password]').val();
			
			if( oldPass.trim() =='' ){
				$('.alert-danger').html('原密码不能为空！');
				return false;
			}
			if (newPass.trim() == '')
			{
				$('.alert-danger').html('新密码不能为空！');
				return false;
			}
			if (againPass.trim() == '')
			{
				$('.alert-danger').html('确认密码不能为空！');
				return false;
			}
			if (againPass.trim() != newPass.trim())
			{
				$('.alert-danger').html('新密码与确认密码不一致！');
				return false;
			}
			var dataDict = {
					'current_password':oldPass,
					'new_password':newPass,
					'confirm_password':againPass,
					'_xsrf':'{{handler.xsrf_token}}'
			}
			$.ajax({
				 type: "POST",
				 url: "/rest/right/needchangepassword",
				 data: dataDict,
				 dataType: "json",
				 success:function(data){
					 if(data.error > 0){
						 $('.alert-danger').html(data.msg);
					 }
					 else{
						location.href='/';	 
					 }
				}
			});
		});
	</script>
</body>
</html>
