{%if ismust==0 %}
<option value="">请选择</option>
{%end%}
{%for item in items%}
	<option value="{{item.CsId}}" {%if item.CsId == select%}selected{%end%}>{{item.CsNameDesc}}</option>
{%end%}