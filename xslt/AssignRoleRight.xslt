<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" method="html"/>
	<xsl:param name="on"/>
	<xsl:template match="/">
		<div class="easyui-panel" title="操作">
			<a href="javascript:save();" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>  
		</div>
		<div id="menufront" class="easyui-panel" title="前端菜单">
		<xsl:for-each select="root/menu[(visiable='1') and (parentid ='' or parentid='0' or not(parentid))]">
			<xsl:sort select="Order" data-type="number" case-order="lower-first"/>
			<div class="easyui-panel" style="width:150px;" data-options="collapsible:true,"> 
					<xsl:attribute name="title">
						<xsl:value-of select="text"/>
					</xsl:attribute>
				<ul class="easyui-tree" data-options="animate:true,checkbox:true">
					<xsl:for-each select="/root/menu[parentid = current()/id]">
						<li>
							<span>
								<xsl:value-of select="text"/>
							</span>
							<xsl:choose>
								<xsl:when test="count(/root/menu[parentid=current()/id])=0">
									<xsl:call-template name="funcs">
										<xsl:with-param name="mid" select="current()/id"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="sub">
										<xsl:with-param name="pid" select="current()/id"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</li>
					</xsl:for-each>
				</ul>
			</div>
		</xsl:for-each>
		</div>
		<div id="menufront" class="easyui-panel" title="后端功能">
			<xsl:for-each select="root/menu[(visiable='2') and (parentid ='' or parentid='0' or not(parentid))]">
			<xsl:sort select="Order" data-type="number" case-order="lower-first"/>
			<div class="easyui-panel" style="width:150px;" data-options="collapsible:true,collapse:true"> 
					<xsl:attribute name="title">
						<xsl:value-of select="text"/>
					</xsl:attribute>
				<ul class="easyui-tree" data-options="animate:true,checkbox:true">
					<xsl:for-each select="/root/menu[parentid = current()/id]">
						<li>
							<span>
								<xsl:value-of select="text"/>
							</span>
							<xsl:choose>
								<xsl:when test="count(/root/menu[parentid=current()/id])=0">
									<xsl:call-template name="funcs">
										<xsl:with-param name="mid" select="current()/id"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="sub">
										<xsl:with-param name="pid" select="current()/id"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</li>
					</xsl:for-each>
				</ul>
			</div>
		</xsl:for-each>
		</div>
	</xsl:template>
	<xsl:template match="/root/menu" name="sub">
		<xsl:param name="pid"/>
			<ul>
				<xsl:for-each select="/root/menu[parentid =$pid]">
				<xsl:sort select="Order" data-type="number" case-order="lower-first"/>
					<li>
						<span>
							<xsl:value-of select="text"/>
						</span>
						<xsl:choose>
							<xsl:when test="count(/root/menu[parentid=current()/id]) = 0">
								<xsl:call-template name="funcs">
									<xsl:with-param name="mid" select="current()/id"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:when test="count(/root/menu[parentid=current()/id]) &gt; 0">
								<xsl:call-template name="sub">
									<xsl:with-param name="pid" select="current()/id"/>
								</xsl:call-template>
							</xsl:when>
						</xsl:choose>
					</li>
				</xsl:for-each>
			</ul>
	</xsl:template>
	<xsl:template match="/root/funcs" name="funcs">
		<xsl:param name="mid"/>
		<ul>
			<xsl:for-each select="/root/funcs[menuid=$mid]">
				<li>
					<xsl:attribute name="id">
						<xsl:value-of select="id"/>
					</xsl:attribute>
					<xsl:value-of select="text"/>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
</xsl:stylesheet>
