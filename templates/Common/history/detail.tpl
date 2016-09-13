<div class="container">
	<div class="row">&nbsp;</div>
	<div class="row">
		<div class="span12">
			<table class="table table-striped table-bordered table-condensed">
				<tr>
					<td>属性</td>
					<td>修改前</td>
					<td>修改后</td>
					<td>是否修改</td>
				</tr>
				{% for k in oldObj %}
				<tr>
					<td>{{k}}</td>
					<td>{{oldObj.get(k,'')}}</td>
					<td>{{newObj.get(k,'')}}</td>
					<td> {% if str(oldObj.get(k,'')) == str(newObj.get(k,'')) %} 
						<span class="label label-success">否</span>
						{% else %}
						<span class="badge badge-important">是</span>
						{% end %}
					</td>
				</tr>
				{% end %}
			</table>
		</div>
	</div>
	<div class="row">
	  <div class="span12">
	  	<ul class="inline">
			<li>修改模块：<span class="label label-info">{{history.get('Module')}}</span></li>
			<li>修改位置：<span class="label label-info">{{history.get('Postion')}}</span></li>
			<li>创建人：<span class="label label-info">{{history.get('CreateId')}}</span></li>
			<li>创建时间：<span class="label label-info">{{history.get('CreateTime')}}</span></li>
			<li>修改人：<span class="label label-info">{{history.get('UpdateId')}}</span></li>
			<li>修改时间：<span class="label label-info">{{history.get('UpdateTime')}}</span></li>
		</ul>
	  </div>
	</div>
</div>