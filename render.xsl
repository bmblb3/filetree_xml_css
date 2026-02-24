<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:strip-space elements="dir"/>
	<xsl:template match="/">
		<html>
			<head>
				<meta charset="UTF-8"/>
				<title>autofoam render</title>
				<link rel="stylesheet" href="https://bmblb3.github.io/filetree_xml_css/style.css"/>
			</head>
			<body>
				<xsl:apply-templates select="/dir"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="dir">
		<details>
			<xsl:if test="@name='.'">
				<xsl:attribute name="open">open</xsl:attribute>
			</xsl:if>
			<summary>
				<xsl:value-of select="@name"/>
			</summary>
			<xsl:apply-templates select="dir|file|link"/>
		</details>
	</xsl:template>
	<xsl:template match="file">
		<div class="file">
			<div class="file-name">
				<xsl:value-of select="@name"/>
			</div>
			<pre class="file-content">
				<xsl:for-each select="text()[normalize-space(.) != '']">
					<xsl:value-of select="normalize-space(.)"/>
					<xsl:text>&#10;</xsl:text>
				</xsl:for-each>
			</pre>
		</div>
	</xsl:template>
	<xsl:template match="link">
		<div class="link">
			<xsl:value-of select="@name"/>
			<xsl:text> → </xsl:text>
			<xsl:value-of select="@target"/>
		</div>
	</xsl:template>
</xsl:stylesheet>
