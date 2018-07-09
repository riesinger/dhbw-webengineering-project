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
					<h3 class="current-day">
						<xsl:choose>
							<xsl:when test="currentDate/@dow = 1">Montag</xsl:when>
							<xsl:when test="currentDate/@dow = 2">Dienstag</xsl:when>
							<xsl:when test="currentDate/@dow = 3">Mittwoch</xsl:when>
							<xsl:when test="currentDate/@dow = 4">Donnerstag</xsl:when>
							<xsl:when test="currentDate/@dow = 5">Freitag</xsl:when>
							<xsl:when test="currentDate/@dow = 6">Samstag</xsl:when>
							<xsl:when test="currentDate/@dow = 7">Sonntag</xsl:when>
						</xsl:choose>
						-
						<xsl:value-of select="currentDate/@day"/>.<xsl:value-of select="currentDate/@month"/>.</h3>
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
						<xsl:for-each select="events/event">
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