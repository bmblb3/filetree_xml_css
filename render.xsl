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
                <style>
body {
  font-family: ui-monospace, SFMono-Regular, Menlo, Consolas, monospace;
  font-size: 13px;
  line-height: 1.5;
  padding: 16px;
}

details { margin-left: 1.25rem; }
summary { cursor: pointer; font-weight: 600; }

.file { margin-left: 1.25rem; }
.file-name { font-weight: 600; }
.file-content {
  background: #f4f4f4;
  border-left: 3px solid #ddd;
  padding: 6px 10px;
  white-space: pre-wrap;
}

.link { margin-left: 1.25rem; color: #1e90ff; }

summary::before { content: "📁 "; }
.file-name::before { content: "📄 "; }
.link::before { content: "🔗 "; }
                </style>
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
