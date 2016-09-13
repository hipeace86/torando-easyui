<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:param name="on"/>
	<xsl:template match="/">
		[
		<xsl:for-each select="/root/company">
		{
			"id":"<xsl:value-of select="concat('c',id)"/>",
			"text":"<xsl:value-of select="name"/>",
			<xsl:choose>
				<xsl:when test="count(/root/department[company=current()/id]) &gt; 0">
					"children":[
						<xsl:call-template name="depart">
							<xsl:with-param name="cid" select="current()/id"/>
							<xsl:with-param name="pid" select="0"/>
						</xsl:call-template>
					]
				</xsl:when>
			</xsl:choose>
		},
		</xsl:for-each>
		]
	</xsl:template>
	<xsl:template match="/root/department" name="depart">
		<xsl:param name="cid"/>
		<xsl:param name="pid"/>
		<xsl:for-each select="/root/department[company=$cid  and parentid =$pid]">
				{
					"id":"<xsl:value-of select="concat('d',id)"/>",
					"text":"<xsl:value-of select="name"/>",
					"children":[
						<xsl:choose>
							<xsl:when test="count(/root/department[parentid=current()/id]) &gt; 0">
								<xsl:call-template name="depart">
									<xsl:with-param name="cid" select="$cid"/>
									<xsl:with-param name="pid" select="current()/id"/>
								</xsl:call-template>
							</xsl:when>
						</xsl:choose>
						<xsl:for-each select="/root/user[depart=current()/id]">
							{
								"id":"<xsl:value-of select="id"/>",
								"text":"<xsl:value-of select="name"/>"
							},
						</xsl:for-each>
					]
				},
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>