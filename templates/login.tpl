<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{{ escape(handler.settings["AppTitle"]) }} Login</title>
<link href="{{ static_url("themes/l/bootstrap.min.css")}}" rel="stylesheet" type="text/css" media="screen" charset="utf-8"/>
<link href="{{ static_url("themes/l/site.css")}}" rel="stylesheet" type="text/css" media="screen" charset="utf-8"/>

</head>
<!--[if IE 7 ]>    <body class="ie7"> <![endif]-->
<!--[if IE 8 ]>    <body class="ie8"> <![endif]-->
<!--[if IE 9 ]>    <body class="ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<body>
<!--<![endif]-->
<div class="container">
<div class="login">
        <div class="login-screen">
          <div class="login-icon">
            <img src="{{ static_url("themes/l/icon.png")}}" alt="Welcome to Mail App">
            <h4>Welcome to <small>{{ escape(handler.settings["AppTitle"]) }}</small></h4>
          </div>

          <div class="login-form">
           <form method="post" action="/login" id='loginForm'>
            <div class="control-group">
              <input type="text" class="login-field" value="" name='login-name' placeholder="Enter your name" id="login-name">
              <label class="login-field-icon fui-man-16" for="login-name"></label>
            </div>

            <div class="control-group">
              <input type="password" class="login-field" value="" name='login-pass' placeholder="Password" id="login-pass">
              <label class="login-field-icon fui-lock-16" for="login-pass"></label>
            </div>
            <a class="btn btn-primary btn-large btn-block" href="javascript:SubmitForm();">Login</a>
            <a class="login-link" href="#">Lost your password?</a>
             {{ xsrf_form_html() }}
      	</form>
          </div>
          {% if msg%}
          <div class="alert alert-danger">{{msg}}</div>
          {% end if %}
        </div>
      </div>
  </div>
<script type="text/javascript" src="{{ static_url("js/jquery-1.8.0.min.js")}}"></script>
<script type="text/javascript" src="{{ static_url("js/xsrf.js")}}"></script>
<script>
$(document).ready(function(){
	$('#login-pass').keyup(function(e){
		if (e.keyCode == 13){
			SubmitForm();
		}
	});
});
function SubmitForm(){
	$('#loginForm').submit();
}
</script>
</body>
</html>