<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" method="text"/>
	<xsl:param name="on"/>
	<xsl:template match="/">
	[
		<xsl:for-each select="root/menu[parentid ='' or parentid='0' or not(parentid)]">
			<xsl:sort select="Order" data-type="number" case-order="lower-first"/>
				{
					"id":<xsl:value-of select="id"/>,
					"text":"<xsl:value-of select="text"/>",
						<xsl:choose>
							<xsl:when test="count(/root/menu[parentid=current()/id])&gt;0">
							"children":[
								<xsl:call-template name="sub">
									<xsl:with-param name="pid" select="current()/id"/>
								</xsl:call-template>
							]
							</xsl:when>
						</xsl:choose>
				},
		</xsl:for-each>
	]
	</xsl:template>
	<xsl:template match="/root/menu" name="sub">
		<xsl:param name="pid"/>
			<xsl:for-each select="/root/menu[parentid = $pid]">
				{
					<xsl:choose>
						<xsl:when test="count(/root/menu[parentid=current()/id]) = 0">
							"id":<xsl:value-of select="id"/>,
							"text":"<xsl:value-of select="text"/>"
						</xsl:when>
						<xsl:otherwise>
							"id":<xsl:value-of select="id"/>,
							"text":"<xsl:value-of select="text"/>",
							"children":[
								<xsl:call-template name="sub">
									<xsl:with-param name="pid" select="current()/id"/>
								</xsl:call-template>
							]
						</xsl:otherwise>
					</xsl:choose>
				},
			</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>