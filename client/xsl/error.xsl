<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
	<xsl:template match="errorWindow">
		<div class="smallCard">
			<div>
				<h3 class="centeredText">Fehler</h3>
				<div class="centeredText">
					<xsl:value-of select="err"/>
				</div>
			</div>
			<a>
				<xsl:attribute name="href">/?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/>
				</xsl:attribute>
				<button class="closePopupButton"><img src="/images/x_black.svg" alt="Schließen"/></button>
			</a>
		</div>
	</xsl:template>
</xsl:stylesheet>