<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
	<xsl:template match="week">
		<xsl:variable name="day1" select="firstDate/@day"/>
		<xsl:variable name="day2">
			<xsl:if test="firstDate/@day > number(lastDate/@day) and lastDate/@day > 5">1</xsl:if>
			<xsl:if test="not(firstDate/@day > number(lastDate/@day)) or not(lastDate/@day > 5)">
				<xsl:value-of select="$day1 + 1"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="day3">
			<xsl:if test="$day2 > number(lastDate/@day) and lastDate/@day > 4">1</xsl:if>
			<xsl:if test="not($day2 > number(lastDate/@day) and lastDate/@day > 4)">
				<xsl:value-of select="$day2 + 1"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="day4">
			<xsl:if test="$day3 > number(lastDate/@day) and lastDate/@day > 3">1</xsl:if>
			<xsl:if test="not($day3 > number(lastDate/@day) and lastDate/@day > 3)">
				<xsl:value-of select="$day3 + 1"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="day5">
			<xsl:if test="$day4 > number(lastDate/@day) and lastDate/@day > 2">1</xsl:if>
			<xsl:if test="not($day4 > number(lastDate/@day) and lastDate/@day > 2)">
				<xsl:value-of select="$day4 + 1"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="day6">
			<xsl:if test="$day5 > number(lastDate/@day) and lastDate/@day > 1">1</xsl:if>
			<xsl:if test="not($day5 > number(lastDate/@day) and lastDate/@day > 1)">
				<xsl:value-of select="$day5 + 1"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="day7" select="lastDate/@day"/>
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
					<h3>
						<xsl:attribute name="class"><xsl:if test="$day1 = number(currentDate/@day)">current-day</xsl:if></xsl:attribute>
						Montag <xsl:value-of select="$day1"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="$day2 = number(currentDate/@day)">current-day</xsl:if></xsl:attribute>
						Dienstag <xsl:value-of select="$day2"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="$day3 = number(currentDate/@day)">current-day</xsl:if></xsl:attribute>
						Mittwoch <xsl:value-of select="$day3"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="$day4 = number(currentDate/@day)">current-day</xsl:if></xsl:attribute>
						Donnerstag <xsl:value-of select="$day4"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="$day5 = number(currentDate/@day)">current-day</xsl:if></xsl:attribute>
						Freitag <xsl:value-of select="$day5"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="$day6 = number(currentDate/@day)">current-day</xsl:if></xsl:attribute>
						Samstag <xsl:value-of select="$day6"/>.
					</h3>
					<h3>
						<xsl:attribute name="class"><xsl:if test="$day7 = number(currentDate/@day)">current-day</xsl:if></xsl:attribute>
						Sonntag <xsl:value-of select="$day7"/>.
					</h3>
				</div>
				<div class="calendar__body">
					<xsl:if test="//meta/dateOffset = 0">
						<div class="current_time_line">
							<xsl:attribute name="style">top: <xsl:value-of select="(currentDate/@hour * 4) + (currentDate/@minute * 0.0666666)"/>rem;</xsl:attribute>
						</div>
					</xsl:if>
					<div class="calendar__legend">
						<div id="h0">00:00</div>
						<div id="h1">01:00</div>
						<div id="h2">02:00</div>
						<div id="h3">03:00</div>
						<div id="h4">04:00</div>
						<div id="h5">05:00</div>
						<div id="h6">06:00</div>
						<div id="h7">07:00</div>
						<div id="h8">08:00</div>
						<div id="h9">09:00</div>
						<div id="h10">10:00</div>
						<div id="h11">11:00</div>
						<div id="h12">12:00</div>
						<div id="h13">13:00</div>
						<div id="h14">14:00</div>
						<div id="h15">15:00</div>
						<div id="h16">16:00</div>
						<div id="h17">17:00</div>
						<div id="h18">18:00</div>
						<div id="h19">19:00</div>
						<div id="h20">20:00</div>
						<div id="h21">21:00</div>
						<div id="h22">22:00</div>
						<div id="h23">23:00</div>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="$day1= currentDate/@day">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="events/event[ startdate/@day =$day1]">
							<xsl:apply-templates mode="calendar__event" select="."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="$day2= number(currentDate/@day)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="events/event[ startdate/@day =$day2]">
							<xsl:apply-templates mode="calendar__event" select="."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="$day3= number(currentDate/@day)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="events/event[ startdate/@day =$day3]">
							<xsl:apply-templates mode="calendar__event" select="."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="$day4= number(currentDate/@day)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="events/event[ startdate/@day =$day4]">
							<xsl:apply-templates mode="calendar__event" select="."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="$day5= number(currentDate/@day)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="events/event[ startdate/@day =$day5]">
							<xsl:apply-templates mode="calendar__event" select="."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="$day6= number(currentDate/@day)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="events/event[ startdate/@day =$day6]">
							<xsl:apply-templates mode="calendar__event" select="."/>
						</xsl:for-each>
					</div>
					<div class="calendar__day">
						<xsl:attribute name="class">calendar__day <xsl:if test="$day7= number(currentDate/@day)">current-day</xsl:if> </xsl:attribute>
						<xsl:for-each select="events/event[ startdate/@day =$day7]">
							<xsl:apply-templates mode="calendar__event" select="."/>
						</xsl:for-each>
					</div>
				</div>
			</div>

			<script type="text/javascript">
					window.onload = function () { window.location.hash = "h<xsl:value-of select="currentDate/@hour - 4"/>"; };
			</script>
		</div>
	</xsl:template>
</xsl:stylesheet>