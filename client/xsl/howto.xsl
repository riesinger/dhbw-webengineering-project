<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
    <xsl:template match="howto">
        <div id="howto" class="card">
					<h1>How To: Kalender 42</h1>
					<h3>Events einfärben</h3>
					<p>Sie können einzelne Events mit vordefinierten Farben einfärben.
						Dazu müssen sie irgendwo in der Beschreibung des Events folgende Syntax verwenden:
						<i>farbe:grün</i>
					</p>
					<p>Folgende Farben sind möglich:
						<ul>
							<li>grün</li>
							<li>blau</li>
							<li>rot</li>
						</ul>
					</p>
					<h3>Icon angeben</h3>
					<p>
						Sie können statt automatisch zugewiesenen Icons auch von Hand ein Icon angeben. Das angegebene Icon überschreibt das automatisch zugewiesene.
						Dazu müssen sie irgendwo in der Beschreibung des Events folgende Syntax verwenden:
						<i>icon:einkaufen</i>
					</p>
					<p>Folgende Icons sind möglich:
						<ul>
							<li>einkaufen</li>
							<li>kino</li>
							<li>essen</li>
						</ul>
					</p>
				</div>
    </xsl:template>
</xsl:stylesheet>
