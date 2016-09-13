function editUserProfile(uid){
        $.ajax({
        url : '/rest/right/userprofile',
        type : 'get',
        dataType : 'json',
        success : function(data) {
            $('#dlgUserProfile').window('open');
            $('#formUserProfile').form('load', data);
            $('#_method', $('#formUserProfile')).attr('url','/rest/right/userprofile')
        }
    });
}
function saveUserProfile() {
    $('#formUserProfile').form('submit', {
        url : $('#_method', $('#formUserProfile')).attr('url'),
        onSubmit : function() {
            return $(this).form('validate');
        },
        success : function(result) {
            var result = eval('(' + result + ')');
            if(result.errorMsg) {
                $.messager.alert('Error', result.errorMsg, 'error');
            } else {
                if(result.successMsg) {
                    $.messager.show({
                        title : 'Info',
                        msg : result.successMsg
                    });
                }
                $('#dlgUserProfile').dialog('close');
            }
        }
    });
}


function editUserPass(){
	 $('#w').window('open');
	 
}

function saveUserPass(){
	
	var pas1 = $('#password1').val();
	var pas2 = $('#password2').val();
	
	if(pas1 === pas2){
		$('#formUserPass').form('submit', {
		        url : '/rest/right/editpassword',
		        onSubmit : function() {
		            return $(this).form('validate');
		        },
		        success : function(result) {
		            var result = eval('(' + result + ')');
		            if(result.errorMsg) {
		                $.messager.alert('Error', result.errorMsg, 'error');
		            } else {
		                if(result.successMsg) {
		                    $.messager.show({
		                        title : 'Info',
		                        msg : result.successMsg
		                    });
		                }
		                $('#w').dialog('close');
		                
		            }
		        }
	    });
	}else{
		
		$.messager.alert('Error','密码不一致','error');
	}

	
}
