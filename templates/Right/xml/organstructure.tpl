<?xml version="1.0" encoding="UTF-8"?>
<root>
    {% for company in companys%}
    <company>
        <id>{{company.ComId}}</id>
        <name>{{company.CompanyName}}</name>
        <parentid>{{company.ParentId}}</parentid>
    </company>{%end%}
    {% for depart in departs%}
    <department>
        <id>{{depart.DepartId}}</id>
        <name>{{depart.DepartName}}</name>
        <company>{{depart.Company}}</company>
        <parentid>{{depart.ParentId}}</parentid>
    </department>{%end%}
    {% for user in users %}
    <user>
        <id>{{user.UserId}}</id>
        <name>{{user.UserName}}</name>
        <depart>{{user.Department}}</depart>
    </user>{%end%}
</root>