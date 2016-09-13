<root>
	{% for menu in menus %}
		{% if menu['fi_visiable'] == 1%}
		    <menu>
		        <id>{{menu['fi_menu_id']}}</id>
		        <text>{{menu['fs_menu_name']}}</text>
		        <parentid>{{menu['fi_parent_id']}}</parentid>
		        <url>{{menu['fs_menu_url']}}</url>
		        <Order>{{menu['fi_order']}}</Order>
		    </menu>
		{% end %}
	{% end %}
    {% for tmpl in workflowtmpl %}
	    <flowtmpl>
	    	<id>{{tmpl.WftId}}</id>
	    	<text>{{tmpl.WftName}}</text>
	    </flowtmpl>
    {%end%}
    {% for node in workflownodes%}
	    <node>
	    	<id>{{node.WfnId}}</id>
	    	<name>{{node.WfnName}}</name>
	    	<wftid>{{node.WftId}}</wftid>
	    	<order>{{node.WfnOrder}}</order>
	    </node>
    {% end %}
</root>