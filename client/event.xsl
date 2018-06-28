<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
	<xsl:template match="event" mode="calendar__event">
		<xsl:variable name="evtLengthMinutes" select="number(startdate/@minute) - number(enddate/@minute)"/>
		<xsl:variable name="evtLengthHour" select="number(enddate/@hour) - number(startdate/@hour)"/>
		<a>
			<xsl:attribute name="href">/showEvent?eventID=<xsl:value-of select="@ID"/>&amp;<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/></xsl:attribute>
			<div class="calendar__event">
				<xsl:attribute name="style">top: <xsl:value-of select="(startdate/@hour * 4) + (startdate/@minute * 0.0666666)"/>rem; height: <xsl:value-of
					select="string(($evtLengthHour * 4) + (($evtLengthMinutes * ($evtLengthMinutes >= 0) - $evtLengthMinutes * ($evtLengthMinutes &lt; 0))) * 0.0666666)"/>rem;</xsl:attribute>
				<div class="calendar__event__title">
					<xsl:choose>
						<xsl:when test="contains(name, 'Einkaufen') or contains(name, 'einkaufen')">
							<img class="event-icon" src="/images/cart_white.svg"/>
						</xsl:when>
						<xsl:when test="contains(name, 'Kino') or contains(name, 'kino')">
							<img class="event-icon" src="/images/popcorn_inverted.svg"/>
						</xsl:when>
					</xsl:choose>
					<xsl:value-of select="name"/>
					<a>
						<xsl:attribute name="href">/deleteEvent?eventID=<xsl:value-of select="@ID"/>&amp;<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/></xsl:attribute>
						<img class="eventIcon" src="/images/trash_white.svg"/>
					</a>
					<a>
						<xsl:attribute name="href">/editEvent?eventID=<xsl:value-of select="@ID"/>&amp;week=<xsl:value-of select="//meta/dateOffset"/></xsl:attribute>
						<img class="eventIcon" src="/images/edit.svg"/>
					</a>
				</div>
			</div>
		</a>
	</xsl:template>
</xsl:stylesheet>