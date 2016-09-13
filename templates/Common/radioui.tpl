{%for item in items%}
	<input name='{{item.Typename}}' type='radio' value={{item.CsId}} style="width:30px" {%if events %}onclick="{{item.Typename}}1(this)"{%end%} {%if item.CsId == selects %}checked="checked"{%end%}>{{item.CsNameDesc}}
{%end%}