<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
	<xsl:template match="event" mode="calendar__event">
		<xsl:param name="isMonthEvent" select="false()"/>
		<xsl:variable name="evtLengthMinutes" select="number(startdate/@minute) - number(enddate/@minute)"/>
		<xsl:variable name="evtLengthHour" select="number(enddate/@hour) - number(startdate/@hour)"/>
		<a>
			<xsl:attribute name="href">/showEvent?eventID=<xsl:value-of select="@ID"/>&amp;<xsl:value-of
			select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/></xsl:attribute>
			<span class="calendar__event">
				<xsl:attribute name="style">
					<xsl:if test="$isMonthEvent = false()">top: <xsl:value-of
					select="(startdate/@hour * 4) + (startdate/@minute * 0.0666666)"/>rem; height: <xsl:value-of
					select="string(($evtLengthHour * 4) + ((($evtLengthMinutes * ($evtLengthMinutes >= 0) -
						$evtLengthMinutes * ($evtLengthMinutes &lt; 0))) * 0.0666666))"/>rem;</xsl:if>
					<xsl:if test="$isMonthEvent = true()">position:relative;</xsl:if>
					<xsl:choose>
						<xsl:when test="contains(description, 'farbe:grün')">background-color: #2CEAA3; color: #000;</xsl:when>
						<xsl:when test="contains(description, 'farbe:blau')">background-color: #7CFEF0; color: #000;</xsl:when>
						<xsl:when test="contains(description, 'farbe:rot')">background-color: #E83151; color: #fff;</xsl:when>
						<xsl:when test="contains(description, 'farbe:gelb')">background-color: #ffe74c; color: #000;</xsl:when>
						<xsl:when test="contains(description, 'farbe:pink')">background-color: #f62dae; color: #fff;</xsl:when>
						<xsl:when test="contains(description, 'farbe:grau')">background-color: #3d405b; color: #fff;</xsl:when>
				</xsl:choose></xsl:attribute>
				<span class="calendar__event__title">
					<xsl:if test="contains(description, 'icon:')">
						<xsl:choose>
							<xsl:when test="contains(description, 'icon:einkaufen')">
								<img class="event-icon" src="/images/cart_white.svg" alt="Bild eines Einkaufswagens"/>
							</xsl:when>
							<xsl:when test="contains(description, 'icon:kino')">
								<img class="event-icon" src="/images/popcorn_inverted.svg" alt="Bild eines Popcorneimers"/>
							</xsl:when>
							<xsl:when test="contains(description, 'icon:essen')">
								<img class="event-icon" src="/images/food_white.svg" alt="Bild von Essen"/>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:if test="contains(description, 'icon:') = false()">
						<xsl:choose>
							<xsl:when test="contains(name, 'Einkaufen') or contains(name, 'einkaufen')">
								<img class="event-icon" src="/images/cart_white.svg" alt="Bild eines Einkaufswagens"/>
							</xsl:when>
							<xsl:when test="contains(name, 'Kino') or contains(name, 'kino')">
								<img class="event-icon" src="/images/popcorn_inverted.svg" alt="Bild eines Popcorneimers"/>
							</xsl:when>
							<xsl:when test="contains(name, 'Essen') or contains(name, 'essen')">
								<img class="event-icon" src="/images/food_white.svg" alt="Bild von Essen"/>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:value-of select="name"/>
					<a>
						<xsl:attribute name="href">/deleteEvent?eventID=<xsl:value-of select="@ID"/>&amp;<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/></xsl:attribute>
						<img class="eventIcon" src="/images/trash_white.svg" alt="Ereignis löschen"/>
					</a>
				</span>
			</span>
		</a>
	</xsl:template>
</xsl:stylesheet>