<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" method="html"/>
	<xsl:template match="/">
		<div class="easyui-panel" title="操作">
			<a href="javascript:save();" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>  
		</div>
	    <div id="menufront" class="easyui-panel" title="流程分配">
		<xsl:for-each select="/root/workflowtmpl">
			<div class="easyui-panel" style="width:150px;" data-options="collapsible:true,"> 
				<xsl:attribute name="title">
					<xsl:value-of select="wfname"/>
				</xsl:attribute>
				<ul class="easyui-tree" data-options="animate:true,checkbox:true">
					<xsl:for-each select="/root/node[wfid = current()/wfid]">
						<li>
							<xsl:attribute name="id">
								<xsl:value-of select="id"/>
							</xsl:attribute>
							<span>
								<xsl:value-of select="name"/>
							</span>
						</li>
					</xsl:for-each>
				</ul>
			</div>
		</xsl:for-each>
		</div>
	</xsl:template>
</xsl:stylesheet>