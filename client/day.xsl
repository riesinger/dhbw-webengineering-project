<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
	<xsl:template match="day">
		<div>
			<div class="header fixed">
				<h1>Mein Kalender</h1>
				<h2>- <xsl:value-of select="firstDate/@day"/>.<xsl:value-of select="firstDate/@month"/>.
				bis <xsl:value-of select="lastDate/@day"/>.<xsl:value-of
					select="lastDate/@month"/>.</h2>
				<xsl:call-template name="navButtons"/>
			</div>
			<div class="calendar">
				<div class="calendar__header">
					<div class="calendar__header__legend__padding"/>
					<h1><xsl:value-of select="firstDate/@day"/>.<xsl:value-of select="firstDate/@month"/>.</h1>
				</div>
				<div class="calendar__body">
					<div class="calendar__legend">
						<div>00:00</div>
						<div>01:00</div>
						<div>02:00</div>
						<div>03:00</div>
						<div>04:00</div>
						<div>05:00</div>
						<div>06:00</div>
						<div>07:00</div>
						<div>08:00</div>
						<div>09:00</div>
						<div>10:00</div>
						<div>11:00</div>
						<div>12:00</div>
						<div>13:00</div>
						<div>14:00</div>
						<div>15:00</div>
						<div>16:00</div>
						<div>17:00</div>
						<div>18:00</div>
						<div>19:00</div>
						<div>20:00</div>
						<div>21:00</div>
						<div>22:00</div>
						<div>23:00</div>
					</div>

					<div class="calendar__day">
						<xsl:for-each select="events/event">
							<xsl:apply-templates mode="calendar__event" select="."/>
						</xsl:for-each>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>