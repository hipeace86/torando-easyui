<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" method="html"/>
	<xsl:param name="on"/>
	<xsl:template match="/">
		<xsl:for-each select="root/menu[parentid ='' or parentid='0' or not(parentid)]">
			<xsl:sort select="Order" data-type="number" case-order="lower-first"/>
				<ul class="easyui-tree">
					<xsl:attribute name="id"><xsl:value-of select="concat('menumanagetree',id)"/></xsl:attribute>
				<li><span><xsl:value-of select="text"/></span>
				<ul>
				<xsl:for-each select="/root/menu[parentid = current()/id]">
					<li>
						<xsl:choose>
							<xsl:when test="count(/root/menu[parentid=current()/id])=0">
								<xsl:attribute name="id"><xsl:value-of select="id"/></xsl:attribute>
								<span>
									<xsl:value-of select="text"/>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<span>
									<xsl:value-of select="text"/>
								</span>
								<xsl:call-template name="sub">
									<xsl:with-param name="pid" select="current()/id"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</li>
				</xsl:for-each>
				</ul>
				</li>
				</ul>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="/root/menu" name="sub">
		<xsl:param name="pid"/>
		<ul>
			<xsl:for-each select="/root/menu[parentid = $pid]">
				<li>
					<xsl:choose>
						<xsl:when test="count(/root/menu[parentid=current()/id]) = 0">
							<xsl:attribute name="id"><xsl:value-of select="id"/></xsl:attribute>
							<span>
								<xsl:value-of select="text"/>
							</span>
						</xsl:when>
						<xsl:otherwise>
							<span>
								<xsl:value-of select="text"/>
							</span>
							<xsl:call-template name="sub">
								<xsl:with-param name="pid" select="current()/id"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
</xsl:stylesheet>