{{html}}
<script>
    function save(){
        var rts = new Array();
        var nodeid = '';
        $(".tree-checkbox1").each(function(){
            nodeid = $(this).parent('div').attr('node-id');
            if(typeof(nodeid) != "undefined"){
                rts.push(nodeid);
            }
        });
        
        $.ajax({
            type:'POST',
            url:'/right/assignrolenode/{{roleid}}',
            data:{'nodes':rts.join(','),'_method':'post'},
            dataType:'json',
            success:function(result){
                if(result.errorMsg) {
                    $.messager.alert('Error', result.errorMsg, 'error');
                } else {
                    if(result.successMsg) {
                        $.messager.show({
                            title : 'Info',
                            msg : result.successMsg
                        });
                        var tab = $('#tt').tabs('getSelected');  
                         if (tab){  
                             var index = $('#tt').tabs('getTabIndex', tab);  
                             $('#tt').tabs('close', index);  
                         }
                    }
                }
            }
        });
    }
    function assignOld(){
        var rts = [{{ nids }}];
        $.each(rts,function(index,value){
            $("div .tree-node[node-id='"+value+"']").children('span.tree-checkbox').addClass('tree-checkbox1');
        });
    }
    setTimeout(assignOld,500);
</script>