$.ajaxSetup({
    beforeSend : function(jqXHR, settings) {
        type = settings.type
        if(type != 'GET' && type != 'HEAD' && type != 'OPTIONS') {
            var pattern = /(.+; *)?_xsrf *= *([^;" ]+)/;
            var xsrf = pattern.exec(document.cookie);
            if(xsrf) {
                jqXHR.setRequestHeader('X-Xsrftoken', xsrf[2]);
            }
        }
    }
});

function newEntity(strEntity, module, title,uuid) {
	$('#dlg-buttons-'+strEntity+uuid).children('a[iconCls="icon-ok"]').linkbutton('enable');
	$('#form' + strEntity+uuid).form('clear');
    $('#_method', $('#form' + strEntity+uuid)).val('post');
    $('#_method', $('#form' + strEntity+uuid)).attr('url','/rest/' + module.toLowerCase() + '/' + strEntity.toLowerCase());
    $('#dlg' + strEntity+uuid).dialog('open').dialog('setTitle', title);
}

function editEntity(strEntity, module, title, pk,uuid) {
	$('#dlg-buttons-'+strEntity+uuid).children('a[iconCls="icon-ok"]').linkbutton('enable');
    var row = $('#dg' + strEntity+uuid).datagrid('getSelected');
    if(row) {
        var url = '/rest/' + module.toLowerCase() + '/' + strEntity.toLowerCase() + '/' + row[pk];
        $('#form' + strEntity+uuid).form('load', row);
        $('#_method', $('#form' + strEntity+uuid)).val('put');
        $('#_method', $('#form' + strEntity+uuid)).attr('url',url);
        $('#dlg' + strEntity+uuid).dialog('open').dialog('setTitle', title);
    }
    else{
        $.messager.alert('Error', '请至少选择一条记录!', 'error');
    }
}

function saveEntity(strEntity, module,uuid,callback) {
    $('#form' + strEntity+uuid).form('submit', {
        url : $('#_method', $('#form' + strEntity+uuid)).attr('url'),
        onSubmit : function() {
        	if($(this).form('validate')){
        		$('#dlg-buttons-'+strEntity+uuid).children('a[iconCls="icon-ok"]').linkbutton('disable');
        		return true;
        	}else{
        		return false;
        	}
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
                
                $('#dlg-buttons-'+strEntity+uuid).children('a[iconCls="icon-ok"]').linkbutton('enable');
                try{
                	$('#dlg' + strEntity+uuid).dialog('close');
                }catch(err){
                	console.log(err);
                }
                try{
                	$('#dg' + strEntity+uuid).datagrid('reload');
                }catch(err){
                	console.log(err);
                }
                (callback && typeof(callback) === "function") && callback();
            }
        }
    });
}

function destroyEntity(strEntity, module, pkid,uuid) {
    var row = $('#dg' + strEntity+uuid).datagrid('getSelected');
    if(row) {
        $.messager.confirm('Confirm', '确认要删除?', function(r) {
            if(r) {
                $.ajax({
                    url : '/rest/' + module.toLowerCase() + '/' + strEntity.toLowerCase() + '/' + row[pkid],
                    type : 'post',
                    data : '_method=delete',
                    dataType : 'json',
                    success : function(result) {
                        if(result.success) {
                            $.messager.show({
                                title : 'Info',
                                msg : '删除成功！'
                            });
                            $('#dg' + strEntity+uuid).datagrid('reload');
                        } else {
                            $.messager.alert('Error', result.errorMsg, 'error');
                        }
                    }
                });
            }
        });
    }
}
/*
 * 功能：将货币数字（阿拉伯数字）(小写)转化成中文(大写）
 * 参数：num为字符型, 小数点之后保留两位, 例：Num2Chinese("1234.06")
 * 说明：不支持负数
 */
function Num2Chinese(num)
{
    for(i = num.length - 1; i >= 0; i -- )
    {
        num = num.replace(",", "");// 替换tomoney()中的“, ”
        num = num.replace(" ", "");// 替换tomoney()中的空格
    }
 
    num = num.replace("￥", "");// 替换可能出现的￥字符
    if(isNaN(num))  
    {
        alert("请检查小写金额是否正确");
        return;
    }
    var part = String(num).split(".");
    var rank = 0;
    var trans = new Array("零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖");
    var unit = new Array("拾", "佰", "仟", "万", "拾", "佰", "仟", "亿");
    var digit = new Array("角", "分");
    str = trans[parseInt(part[0].charAt(part[0].length - 1), 10)] + "圆";
    index = 0;
    for(i = part[0].length - 2; i >= 0; i -- )
    {
        str = trans[parseInt(part[0].charAt(i), 10)] + unit[index % 8] + str;
        index = index + 1;
    }
 
    if(part.length == 2 && part[1].substring(0, 2) != "00")
    {
        str = str + trans[parseInt(part[1].charAt(0))] + digit[0];
        if(part[1].length >= 2)
        {
            str = str + trans[parseInt(part[1].charAt(1))] + digit[1];
        }
    }
    while(str.search("零仟") != - 1)
    {
        str = str.replace("零仟", "零");
    }
    while(str.search("零佰") != - 1)
    {
        str = str.replace("零佰", "零");
    }
    while(str.search("零拾") != - 1)
    {
        str = str.replace("零拾", "零");
    }
    str = str.replace("零角", "零");
    while(str.search("零零") != - 1)
    {
        str = str.replace("零零", "零");
    }
    str = str.replace("零亿", "亿");
    str = str.replace("亿万", "亿");
    str = str.replace("零万", "万");
    str = str.replace("零仟", "零");
    str = str.replace("零佰", "零");
    str = str.replace("零拾", "零");
    if (str.substring(0,2) != "零圆"){
    		str = str.replace("零圆", "圆");
    }
    str = str.replace("零角", "零");
    str = str.replace("零分", "");
 
    if(str.charAt(str.length - 1) == "圆" || str.charAt(str.length - 1) == "角")
    {
        str = str + "整";
    }
    if(str.charAt(0) == "圆")
    {
        str = "零" + str;
    }
    return str;
}

/*
 * 功能：将阿拉伯数字(小写)转化成中文(大写）
 * 参数：num为字符型, 小数点之后保留两位, 例：Num2Traditional("1234.06")
 * 说明：不支持负数
 */
function Num2Traditional(num)
{
    for(i = num.length - 1; i >= 0; i -- )
    {
        num = num.replace(",", "");// 替换tomoney()中的“, ”
        num = num.replace(" ", "");// 替换tomoney()中的空格
    }
 
    if(isNaN(num)) 
    {
        alert("请检查数字是否正确！");
        return;
    }
    var part = String(num).split(".");
    var rank = 0;
    var trans = new Array("零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖");
    var unit = new Array("拾", "佰", "仟", "万", "拾", "佰", "仟", "亿");
    var digit = new Array("", "");
    var str = trans[parseInt(part[0].charAt(part[0].length - 1), 10)] + "点";
    var index = 0;
    for(i = part[0].length - 2; i >= 0; i -- )
    {
        str = trans[parseInt(part[0].charAt(i), 10)] + unit[index % 8] + str;
        index = index + 1;
    }
 
    if(part.length == 2 && part[1].substring(0, 2) != "00")
    {
        str = str + trans[parseInt(part[1].charAt(0))] + digit[0];
        if(part[1].length >= 2)
        {
            str = str + trans[parseInt(part[1].charAt(1))] + digit[1];
        }
    }
    while(str.search("零仟") != - 1)
    {
        str = str.replace("零仟", "零");
    }
    while(str.search("零佰") != - 1)
    {
        str = str.replace("零佰", "零");
    }
    while(str.search("零拾") != - 1)
    {
        str = str.replace("零拾", "零");
    }
    while(str.search("零零") != - 1)
    {
        str = str.replace("零零", "零");
    }
    str = str.replace("零亿", "亿");
    str = str.replace("亿万", "亿");
    str = str.replace("零万", "万");
    str = str.replace("零仟", "零");
    str = str.replace("零佰", "零");
    str = str.replace("零拾", "零");
    if (str.substring(0,2)!="零点"){
    	str = str.replace("零点", "点");
    }
 
    if(str.charAt(str.length - 1) == "点")
    {
        str = str.substring(0, str.length-1);
    }
    return str;
}
