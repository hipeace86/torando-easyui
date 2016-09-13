<root>{% for menu in menus %}
    <menu>
        <id>{{menu.MenuId}}</id>
        <text>{{menu.MenuName}}</text>
        <parentid>{{menu.ParentId}}</parentid>
        <visiable>{{menu.Visiable}}</visiable>
        <Order>{{menu.Order}}</Order>
    </menu>{% end %}
    {% for func in funcs%}<funcs>
        <id>{{func.MenuFuncId}}</id>
        <text>{{func.MenuFuncName}}</text>
        <menuid>{{func.MenuId}}</menuid>
    </funcs>{% end %}
</root>