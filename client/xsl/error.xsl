<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
	<xsl:template match="error">
		<div class="smallCard">
			<div>
				<h3 class="Fehler">Termin</h3>
				<div>
					Ein Fehler ist aufgetreten!
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