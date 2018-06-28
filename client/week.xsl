<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
	<xsl:template match="week">
		<div>
			<div class="header fixed">
				<h1>Mein Kalender</h1>
				<h2>- <xsl:value-of select="//week/firstDateDay"/>.<xsl:value-of select="//week/firstDateMonth"/>.
				bis <xsl:value-of select="//week/lastDateDay"/>.<xsl:value-of
					select="//week/lastDateMonth"/>.</h2>
				<xsl:call-template name="navButtons"/>
			</div>
			<div class="calendar">
				<div class="calendar__header">
					<div class="calendar__header__legend__padding"/>
					<h3>
						<xsl:attribute name="class"><xsl:if test="number(//week/firstDateDay) = number(//week/currentDateDay)">current-day</xsl:if></xsl:attribute>
						Montag <xsl:value-of select="//week/firstDateDay"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="(//week/firstDateDay + 1) = number(//week/currentDateDay)">current-day</xsl:if></xsl:attribute>
						Dienstag <xsl:value-of select="//week/firstDateDay + 1"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="(//week/firstDateDay + 2) = number(//week/currentDateDay)">current-day</xsl:if></xsl:attribute>
						Mittwoch <xsl:value-of select="//week/firstDateDay + 2"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="(//week/firstDateDay + 3) = number(//week/currentDateDay)">current-day</xsl:if></xsl:attribute>
						Donnerstag <xsl:value-of select="//week/firstDateDay + 3"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="(//week/firstDateDay + 4) = number(//week/currentDateDay)">current-day</xsl:if></xsl:attribute>
						Freitag <xsl:value-of select="//week/firstDateDay + 4"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="(//week/firstDateDay + 5) = number(//week/currentDateDay)">current-day</xsl:if></xsl:attribute>
						Samstag <xsl:value-of select="//week/firstDateDay + 5"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="(//week/firstDateDay + 6) = number(//week/currentDateDay)">current-day</xsl:if></xsl:attribute>
						Sonntag <xsl:value-of select="//week/firstDateDay + 6"/>.
					</h3>
				</div>
				<div class="calendar__body">
					<div class="current_time_line">
						<xsl:attribute name="style">top: <xsl:value-of select="(//week/currentDateHour * 4) + (//week/currentDateMinute * 0.0666666)"/>rem;</xsl:attribute>
					</div>
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
						<xsl:attribute name="class">calendar__day <xsl:if test="//week/firstDateDay = //week/currentDateDay">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="//week/events/event/startDateDay[ . = //week/firstDateDay]">
							<xsl:apply-templates mode="calendar__event" select=".."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="//week/firstDateDay + 1= number(//week/currentDateDay)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="//week/events/event/startDateDay[ . = //week/firstDateDay + 1]">
							<xsl:apply-templates mode="calendar__event" select=".."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="//week/firstDateDay + 2 = number(//week/currentDateDay)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="//week/events/event/startDateDay[ . = //week/firstDateDay + 2]">
							<xsl:apply-templates mode="calendar__event" select=".."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="//week/firstDateDay + 3= number(//week/currentDateDay)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="//week/events/event/startDateDay[ . = //week/firstDateDay + 3]">
							<xsl:apply-templates mode="calendar__event" select=".."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="//week/firstDateDay + 4= number(//week/currentDateDay)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="//week/events/event/startDateDay[ . = //week/firstDateDay + 4]">
							<xsl:apply-templates mode="calendar__event" select=".."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="//week/firstDateDay + 5 = number(//week/currentDateDay)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="//week/events/event/startDateDay[ . = //week/firstDateDay + 5]">
							<xsl:apply-templates mode="calendar__event" select=".."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="//week/firstDateDay + 6 = number(//week/currentDateDay)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="//week/events/event/startDateDay[ . = //week/firstDateDay + 6]">
							<xsl:apply-templates mode="calendar__event" select=".."/>
						</xsl:for-each>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>