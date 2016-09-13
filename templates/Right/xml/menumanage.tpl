<root>
{% for menu in menus %}
    <menu>
        <id>{{menu.MenuId}}</id>
        <text>{{menu.MenuName}}</text>
        <parentid>{{menu.ParentId}}</parentid>
        <Order>{{menu.Order}}</Order>
    </menu>
{% end %}
</root>