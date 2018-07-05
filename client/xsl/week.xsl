<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
	<xsl:template match="week">
		<xsl:variable name="day1" select="//week/firstDate/@day"/>
		<xsl:variable name="day2">
			<xsl:if test="//week/firstDate/@day > number(//week/lastDate/@day) and //week/lastDate/@day > 5">1</xsl:if>
			<xsl:if test="not(//week/firstDate/@day > number(//week/lastDate/@day)) or not(//week/lastDate/@day > 5)">
				<xsl:value-of select="$day1 + 1"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="day3">
			<xsl:if test="$day2 > number(//week/lastDate/@day) and //week/lastDate/@day > 4">1</xsl:if>
			<xsl:if test="not($day2 > number(//week/lastDate/@day) and //week/lastDate/@day > 4)">
				<xsl:value-of select="$day2 + 1"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="day4">
			<xsl:if test="$day3 > number(//week/lastDate/@day) and //week/lastDate/@day > 3">1</xsl:if>
			<xsl:if test="not($day3 > number(//week/lastDate/@day) and //week/lastDate/@day > 3)">
				<xsl:value-of select="$day3 + 1"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="day5">
			<xsl:if test="$day4 > number(//week/lastDate/@day) and //week/lastDate/@day > 2">1</xsl:if>
			<xsl:if test="not($day4 > number(//week/lastDate/@day) and //week/lastDate/@day > 2)">
				<xsl:value-of select="$day4 + 1"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="day6">
			<xsl:if test="$day5 > number(//week/lastDate/@day) and //week/lastDate/@day > 1">1</xsl:if>
			<xsl:if test="not($day5 > number(//week/lastDate/@day) and //week/lastDate/@day > 1)">
				<xsl:value-of select="$day5 + 1"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="day7" select="//week/lastDate/@day"/>
		<div>
			<div class="header fixed">
				<h1>Mein Kalender</h1>
				<h2>- <xsl:value-of select="//week/firstDate/@day"/>.<xsl:value-of select="//week/firstDate/@month"/>.
				bis <xsl:value-of select="//week/lastDate/@day"/>.<xsl:value-of
					select="//week/lastDate/@month"/>.</h2>
				<xsl:call-template name="navButtons"/>
			</div>
			<div class="calendar">
				<div class="calendar__header">
					<div class="calendar__header__legend__padding"/>
					<h3>
						<xsl:attribute name="class"><xsl:if test="$day1 = number(//week/currentDate/@day)">current-day</xsl:if></xsl:attribute>
						Montag <xsl:value-of select="$day1"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="$day2 = number(//week/currentDate/@day)">current-day</xsl:if></xsl:attribute>
						Dienstag <xsl:value-of select="$day2"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="$day3 = number(//week/currentDate/@day)">current-day</xsl:if></xsl:attribute>
						Mittwoch <xsl:value-of select="$day3"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="$day4 = number(//week/currentDate/@day)">current-day</xsl:if></xsl:attribute>
						Donnerstag <xsl:value-of select="$day4"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="$day5 = number(//week/currentDate/@day)">current-day</xsl:if></xsl:attribute>
						Freitag <xsl:value-of select="$day5"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="$day6 = number(//week/currentDate/@day)">current-day</xsl:if></xsl:attribute>
						Samstag <xsl:value-of select="$day6"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="$day7 = number(//week/currentDate/@day)">current-day</xsl:if></xsl:attribute>
						Sonntag <xsl:value-of select="$day7"/>.
					</h3>
				</div>
				<div class="calendar__body">
					<xsl:if test="//meta/dateOffset = 0">
						<div class="current_time_line">
							<xsl:attribute name="style">top: <xsl:value-of select="(//week/currentDate/@hour * 4) + (//week/currentDate/@minute * 0.0666666)"/>rem;</xsl:attribute>
						</div>
					</xsl:if>
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
						<xsl:attribute name="class">calendar__day <xsl:if test="$day1= //week/currentDate/@day">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="//week/events/event[ startdate/@day =$day1]">
							<xsl:apply-templates mode="calendar__event" select="."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="$day2= number(//week/currentDate/@day)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="//week/events/event[ startdate/@day =$day2]">
							<xsl:apply-templates mode="calendar__event" select="."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="$day3= number(//week/currentDate/@day)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="//week/events/event[ startdate/@day =$day3]">
							<xsl:apply-templates mode="calendar__event" select="."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="$day4= number(//week/currentDate/@day)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="//week/events/event[ startdate/@day =$day4]">
							<xsl:apply-templates mode="calendar__event" select="."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="$day5= number(//week/currentDate/@day)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="//week/events/event[ startdate/@day =$day5]">
							<xsl:apply-templates mode="calendar__event" select="."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="$day6= number(//week/currentDate/@day)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="//week/events/event[ startdate/@day =$day6]">
							<xsl:apply-templates mode="calendar__event" select="."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="$day7= number(//week/currentDate/@day)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="//week/events/event[ startdate/@day =$day7]">
							<xsl:apply-templates mode="calendar__event" select="."/>
						</xsl:for-each>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>