<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
	<xsl:template match="/" name="navButtons">
		<div class="buttons">
			<a title="Zurück">
				<xsl:attribute name="href">\?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset - 1"/></xsl:attribute>
				<div class="leftPageScrollingDiv">
					&lt;
				</div>
			</a>
			<a title="Weiter">
				<xsl:attribute name="href">\?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset + 1"/></xsl:attribute>
				<div class="rightPageScrollingDiv">
						&gt;
				</div>
			</a>
		</div>
	</xsl:template>
</xsl:stylesheet>