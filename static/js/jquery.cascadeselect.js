function Hash(){
	for( var i=0; i < arguments.length; i++ )
		for( n in arguments[i] )
			if( arguments[i].hasOwnProperty(n) )
				this[n] = arguments[i][n];
}

Hash.version = 1.04;
Hash.prototype = new Object();
Hash.prototype.keys = function(){
	var rv = [];
	for( var n in this )
		if( this.hasOwnProperty(n) )
			rv.push(n);
	return rv;
}

Hash.prototype.length = function(){
	return this.keys().length();
}

Hash.prototype.values = function(){
	var rv = [];
	for( var n in this )
		if( this.hasOwnProperty(n) )
			rv.push(this[n]);
	return rv;
}

Hash.prototype.slice = function(){
	var rv = [];
	for( var i = 0; i < arguments.length; i++ )
		rv.push(
			( this.hasOwnProperty( arguments[i] ) )
				? this[arguments[i]]
				: undefined
		);
	return rv;
}

Hash.prototype.concat = function(){
	for( var i = 0; i < arguments.length; i++ )
		for( var n in arguments[i] )
			if( arguments[i].hasOwnProperty(n) )
				this[n] = arguments[i][n];
	return this;
}
Hash.prototype.push = function(key,value){
	this[key] = value;
	return this;
}
var __thisWidget = null;
window.Widgets = {};
$.widget("ui.cascadeselect", {  
  options:{
		valueField:'id',
		textField:'text',
		parentField:'pid',
		value:0,
		filter:0,
		data:[],
		required:''
  },
  kvPare:new Hash(),
  setValue:function(value){
	    this.options.value = value;
	    __thisWidget = this;
	  	var pid = this.kvPare[value];
	  	this.options.filter = pid;
		var selected = new Array();
		selected.push(value);
		while (pid > 0)
		{
			selected.push(pid);
			pid = this.kvPare[pid]
		}
		this.options.filter = this.options.value;
		switch(selected.length){
			case 1:
				this._select1.combobox('setValue',this.options.value);
				this._select2.combobox({data:this.options.data.filter(this._filterCallback)});
				break;
			case 2:
				pid = selected.pop();
				this._select1.combobox('setValue',pid);
				this.options.filter = pid;
				this._select2.combobox({data:this.options.data.filter(this._filterCallback)});
				this._select2.combobox('setValue',this.options.value);
				this.options.filter = this.options.value;
				this._select3.combobox({data:this.options.data.filter(this._filterCallback)});
				break;
			case 3:
				this.options.filter = selected.pop();
				this._select1.combobox('setValue',this.options.filter);
				this._select2.combobox({data:this.options.data.filter(this._filterCallback)});
				this.options.filter = selected.pop();
				this._select2.combobox('setValue',this.options.filter);
				this._select3.combobox({data:this.options.data.filter(this._filterCallback)});
				this.options.filter = selected.pop();
				this._select3.combobox('setValue',this.options.filter);
				break;
		}
  },
  _init:function(options){
	    this.options = $.extend({},this.options,options);
	    var _this = this;
	    __thisWidget = this
	    window.Widgets[this.element.attr('id')] = this;
	    var k = this.options.valueField;
	    var p = this.options.parentField;
		$.each(this.options.data,function(index,value){
			_this.kvPare.push(value[k] ,value[p]);
		});
		var $continer,$thisid;
		var $this = this.element;
		$thisid = $this.attr('id');
		$this.hide().wrap('<span></span>');
		$continer = $this.parent('span');
		this._select1 = $('<input class="easyui-combobox" id="1_'+$thisid+'" src="'+$thisid+'"/>').attr('next','#2_'+$thisid);
		this._select2 = $('<input class="easyui-combobox" id="2_'+$thisid+'" src="'+$thisid+'"/>').attr('next','#3_'+$thisid);
		this._select3 = $('<input class="easyui-combobox" id="3_'+$thisid+'" src="'+$thisid+'"/>');
		$continer.append(this._select1).append(this._select2).append(this._select3);
		this._select1.combobox({data:this.options.data.filter(this._filterCallback),valueField:this.options['valueField'],textField:this.options['textField'],onSelect:this._select});
		this._select2.combobox({data:[],valueField:this.options['valueField'],textField:this.options['textField'],onSelect:this._select});
		this._select3.combobox({data:[],valueField:this.options['valueField'],textField:this.options['textField'],onSelect:this._select});
		if(this.options.required){
			$('#'+this.options.required+'_'+$thisid).combobox({required:true});
		}
		if(this.options.value){
			this.setValue(this.options.value);
		}
  },
  _filterCallback:function(item){
	  if(item[__thisWidget.options.parentField] == __thisWidget.options.filter){
			return true;
		}
		return false;
  },
  _select:function(row){
	  __thisWidget = window.Widgets[$(this).attr('src')];
	  __thisWidget.element.val(row[__thisWidget.options['valueField']]);
	  __thisWidget.options.filter = row[__thisWidget.options['valueField']];
	  __thisWidget._clearSiblings(this);
		if ($(this).attr('next')){
			var next = $($(this).attr('next'));
			__thisWidget._setSiblingsData(next);
		}
  },
  _clearSiblings:function(src){
	  if ($(src).attr('next')){
			var next = $($(src).attr('next'));
			$(next).combobox({data:[]});
			__thisWidget._clearSiblings($(next));
		}
  },
  _setSiblingsData:function(next){
	  $(next).combobox({data:__thisWidget.options.data.filter(__thisWidget._filterCallback)})
  }
});