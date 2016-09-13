<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" method="html"/>
	<xsl:param name="on"/>
	<xsl:variable name="wf_menuid" select="'101'"/>
	<xsl:template match="/">
		<xsl:for-each select="root/menu[parentid ='' or parentid='0' or not(parentid)]">
			<xsl:sort select="Order" data-type="number" case-order="lower-first"/>
			 <a href="#" class="easyui-menubutton">
				 <xsl:attribute name="menu">
					 <xsl:value-of select="concat('#menus',id)"/>
				 </xsl:attribute>
				<xsl:value-of select="text"/>
			 </a>
				<xsl:choose>
					<xsl:when test="id != $wf_menuid">
						<div>
							<xsl:attribute name="id">
								<xsl:value-of select="concat('menus',id)"/>
							</xsl:attribute>
							<xsl:for-each select="/root/menu[parentid = current()/id]">
								<xsl:sort select="Order" data-type="number" case-order="lower-first"/>
								<div>
									<xsl:choose>
										<xsl:when test="count(/root/menu[parentid=current()/id])=0">
											<xsl:attribute name="id"><xsl:value-of select="url"/></xsl:attribute>
											<xsl:attribute name="c"><xsl:value-of select="'true'"/></xsl:attribute>
												<xsl:value-of select="text"/>
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
								</div>
							</xsl:for-each>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="workflow">
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="/root/menu" name="sub">
		<xsl:param name="pid"/>
		<div>
			<xsl:for-each select="/root/menu[parentid = $pid]">
				<div>
					<xsl:choose>
						<xsl:when test="count(/root/menu[parentid=current()/id]) = 0">
							<xsl:attribute name="id"><xsl:value-of select="url"/></xsl:attribute>
							<xsl:attribute name="c"><xsl:value-of select="'true'"/></xsl:attribute>
								<xsl:value-of select="text"/>
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
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
	<xsl:template match="/root/flowtmpl" name="workflow">
		<div id="menus101">
			<xsl:for-each select="/root/flowtmpl">
				<div>
						<span>
							<xsl:value-of select="text"/>
						</span>
						<div>
							<xsl:for-each select="/root/node[wftid=current()/id]">
								<xsl:sort select="order" data-type="number" case-order="lower-first"/>
								<div>
									<xsl:attribute name="id">
										<xsl:value-of select="'/workflow/list/'"/>
										<xsl:value-of select="id"/>
									</xsl:attribute>
									<xsl:attribute name="c"><xsl:value-of select="'true'"/></xsl:attribute>
										<xsl:value-of select="name"/>
								</div>
							</xsl:for-each>
						</div>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
</xsl:stylesheet>