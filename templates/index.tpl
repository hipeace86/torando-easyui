<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>{{ escape(handler.settings["AppTitle"]) }}</title>
    <link rel="stylesheet" type="text/css" href="{{ static_url("themes/bootstrap.min.css") }}">
    <link rel="stylesheet" type="text/css" href="{{ static_url("themes/bootstrap-responsive.min.css") }}">
    <link id="themeurl" rel="stylesheet" type="text/css" href="{{ static_url("themes/default/easyui.css") }}">
    <link rel="stylesheet" type="text/css" href="{{ static_url("themes/icon.css") }}">
    <link rel="stylesheet" href="{{ static_url("themes/main.css") }}" type="text/css" />
    <link rel="stylesheet" href="{{ static_url("themes/thumbFx.css") }}" type="text/css" />

    <script type="text/javascript" src="{{ static_url("js/jquery-1.8.0.min.js") }}"></script>
    <script type="text/javascript" src="{{ static_url("js/jquery.ui.widget.js") }}"></script>
    <script type="text/javascript" src="{{ static_url("js/jquery.easyui.min.js") }}"></script>
    <script type="text/javascript" src="{{ static_url("js/easyui.detailview.js") }}"></script>
    <script type="text/javascript" src="{{ static_url("js/easyui-lang-zh_CN.js") }}"></script>
    <script type="text/javascript" src="{{ static_url("js/mustache.js") }}"></script>

    <script type="text/javascript" src="{{ static_url("js/bootstrap.min.js") }}"></script>

    <script type="text/javascript" src="{{ static_url("js/jquery.fileupload.js") }}"></script>
    <script type="text/javascript" src="{{ static_url("js/highcharts.js")}}"></script>
    <script type="text/javascript" src="{{ static_url("js/data.js")}}"></script>
    <script type="text/javascript" src="{{ static_url("js/exporting.js")}}"></script>

    <script type="text/javascript" src="{{ static_url("js/jQuery.thumbFx.js")}}"></script>
    <script type="text/javascript" src="{{ static_url("js/prototype.js")}}"></script>
    <script type="text/javascript" src="{{ static_url("js/xsrf.js")}}"></script>
    <script type="text/javascript" src="{{ static_url("js/user.js")}}"></script>
    <script type="text/javascript" src="{{ static_url("js/jquery.rotate.1-1.js")}}"></script>

    <script type="text/javascript">
      var CurrentCustomerId=0;
      var PublicCustomerId=0;
      function open1(node) {
      if($('#tt').tabs('exists', node[0].innerText)) {
      $('#tt').tabs('select', node[0].innerText);
      } else {
      $('#tt').tabs('add', {
      title :  node[0].innerText,
      href :  node.attr('id'),
      closable : true,
      extractor : function(data) {
      return data;
      }
      });
      }
      }

      $(document).ready(function(){
      $('[data-lightbox]').live('click',function(e){
      e.preventDefault();
      $(this).lightbox();
      });

      $('#changeThemes').children('div').click(function(){
      $('#themeurl').attr('href','/static/themes/'+$(this).attr('value')+'/easyui.css');
      });
      $('div[c=true]').click(function(){
      if($(this).attr('id')){
      open1($(this));
      }
      });
      $('.drop > span > span').live('click',function(e){
      $(this).siblings('input').click();
      e.preventDefault();
      });
      Highcharts.setOptions({
      global: {
      useUTC: false
      },
      credits:{
      enabled:true,
      text:"",
      href:'',
      },
      exporting:{
      buttons:{
      contextButton:{
      menuItems:[{
      text:'打印',
      onclick:function(){
      this.print();
      }
      },{
      separator: true,
      },
      {
      text:'导出图片',
      onclick:function(){
      this.exportChart();
      }
      }]
      }
      }
      }
      });


      });
    </script>
  </head>
  <body class="easyui-layout">

    <div id="w" class="easyui-dialog" data-options="title:'密码修改',iconCls:'icon-edit',closed:true" style="width:380px;height:240px;padding:5px;">
      <form id="formUserPass" method="post" novalidate>
        <div class="fitem"><label>当前密码:</label><input name="oldpass" type="password"  class="easyui-validatebox" ></div>
        <div class="fitem"><label>新密码:</label><input id="password1" name="password1"  type="password"  class="easyui-validatebox" ></div>
        <div class="fitem"><label>新密码:</label><input id="password2" name="password2"  type="password"  class="easyui-validatebox" ></div>
        <input id='_method' name="_method" type="hidden" value='put'/>

        {{ xsrf_form_html() }}
      </form>
      <div id="dlg-buttons-UserPass-aee91498-3f77-4400-b062-948b5db8cc58">
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUserPass();">保存</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#w').dialog('close')">取消</a>
      </div>
    </div>

    <div id="dlgUserProfile" class="easyui-window" title="修改个人资料" data-options="modal:true,closed:true" style="width:400px;height:440px;padding:10px 20px" closed="true" buttons="#dlg-buttons-UserProfile-aee91498-3f77-4400-b062-948b5db8cc58">
      <div class="ftitle">
        用户
      </div>
      <form id="formUserProfile" method="post" novalidate>
        <div class="fitem"><label>用户名称:</label><input name="UserName"  class="easyui-validatebox" ></div>
        <div class="fitem"><label>性别:</label>
          <select class="easyui-combobox" name="GenderName">{{ modules.StatusCodeModule(2) }}</select>
        </div>
        <div class="fitem"><label>电话:</label><input name="Phone"  class="easyui-validatebox" ></div>
        <div class="fitem"><label>区域ID:</label><input name="AreaZone"  class="easyui-validatebox" ></div>
        <div class="fitem"><label>地址:</label><input name="Address"  class="easyui-validatebox" ></div>
        <div class="fitem"><label>手机:</label><input name="Mobile"  class="easyui-numberbox" ></div>
        <div class="fitem"><label>Email:</label><input name="Email" validType="email" class="easyui-validatebox" ></div>
        <div class="fitem"><label>邮编:</label><input name="PostCode"  class="easyui-numberbox"  validType="minLength[6]"></div>
        <div class="fitem"><label>生日:</label><input name="Birth"  class="easyui-datetimebox"  ></div>
        <input id='_method' name="_method" type="hidden" value='put'/>

        {{ xsrf_form_html() }}
      </form>
      <div id="dlg-buttons-UserProfile-aee91498-3f77-4400-b062-948b5db8cc58">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUserProfile();">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgUserProfile').dialog('close')">取消</a>
      </div>
    </div>

    <div id="HomePageCommonUserSelectWindow" class="easyui-window" title="选择用户" data-options="modal:true,closed:true" >
      <input id='HomePageCommonUserSelect' class="easyui-combobox" data-options="url:'/rest/right/usertree',valueField:'id',textField:'text'">
      <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-search">确定</a>
    </div>

    <div region="north" style="height:40px;">
      <div style="padding:5px;float:left;">
	{{menus}}
      </div>
      <div style="float:right;padding:5px;">
	<a href="#" class="easyui-menubutton" menu="#changeThemes" iconCls="icon-edit">换肤</a>
	<div id="changeThemes">
	  <div value="default">Default</div>
	  <div value="gray">Gray</div>
	  <div value="black">Black</div>
	  <div value="bootstrap">Bootstrap</div>
	  <div value="metro">Metro</div>
	</div>
      </div>
      <div style="float:right;padding:10px 100px 0 0;">
        <a href="javascript:void(0);" onclick="editUserPass();" class="easyui-linkbutton">修改密码</a>
        <a href="javascript:void(0);" onclick="editUserProfile({{UserId}});" class="easyui-linkbutton">修改个人资料</a>
        <a href="/logout" class="easyui-linkbutton">退出</a>
      </div>
    </div>
    <div region="center" border="false">
      <div id="tt" class="easyui-tabs" fit="true" border="false" plain="true">
        <div title="我的工作台">

        </div>
      </div>
    </div>
  </body>
</html>
