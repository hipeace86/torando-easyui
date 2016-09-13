<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" method="html"/>
	<xsl:param name="on"/>
	<xsl:template match="/">
		<div class="easyui-panel" title="操作">
			<a href="javascript:save();" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
		</div>
		<xsl:for-each select="/root/company">
			<div id="menufront" class="easyui-panel">
				<xsl:attribute name="title"><xsl:value-of select="name"/></xsl:attribute>
				<xsl:for-each select="/root/department[(parentid ='' or parentid='0' or not(parentid)) and (company=current()/id)]">
					<div class="easyui-panel" style="width:150px;" data-options="collapsible:true,">
						<xsl:attribute name="title"><xsl:value-of select="name"/></xsl:attribute>
						<ul class="easyui-tree" data-options="animate:true,checkbox:true">
							<xsl:choose>
								<xsl:when test="count(/root/department[parentid=current()/id]) &gt; 0">
									<xsl:call-template name="subdepart">
										<xsl:with-param name="pid" select="current()/id"/>
									</xsl:call-template>
								</xsl:when>
							</xsl:choose>
							<xsl:call-template name="users">
								<xsl:with-param name="did" select="current()/id"/>
							</xsl:call-template>
						</ul>
					</div>
				</xsl:for-each>
			</div>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="/root/department" name="subdepart">
		<xsl:param name="pid"/>
		<xsl:for-each select="/root/department[parentid=$pid]">
			<li>
				<span>
					<xsl:value-of select="name"/>
				</span>
				<ul>
					<xsl:choose>
						<xsl:when test="count(/root/department[parentid=current()/id]) &gt; 0">
							<xsl:call-template name="subdepart">
								<xsl:with-param name="pid" select="current()/id"/>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					<xsl:call-template name="users">
						<xsl:with-param name="did" select="current()/id"/>
					</xsl:call-template>
				</ul>
			</li>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="/root/user" name="users">
		<xsl:param name="did"/>
		<xsl:for-each select="/root/user[depart=$did]">
			<li>
				<xsl:attribute name="id"><xsl:value-of select="id"/></xsl:attribute>
				<span>
					<xsl:value-of select="name"/>
				</span>
			</li>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>