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
			<div class="calendar__event">
				<xsl:attribute name="style">
					<xsl:if test="$isMonthEvent = false()">top: <xsl:value-of
					select="(startdate/@hour * 4) + (startdate/@minute * 0.0666666)"/>rem; height: <xsl:value-of
					select="string(($evtLengthHour * 4) + ((($evtLengthMinutes * ($evtLengthMinutes >= 0) -
						$evtLengthMinutes * ($evtLengthMinutes &lt; 0))) * 0.0666666))"/>rem;</xsl:if>
					<xsl:if test="$isMonthEvent = true()">position:relative;</xsl:if>
					<xsl:choose>
					<xsl:when test="contains(description, 'farbe:grün')">background-color: #2CEAA3; color: #000;</xsl:when>
					<xsl:when test="contains(description, 'farbe:blau')">background-color: #7CFEF0; color: #000;</xsl:when>
					<xsl:when test="contains(description, 'farbe:rot')">background-color: #E83151; </xsl:when>
				</xsl:choose></xsl:attribute>
				<div class="calendar__event__title">
					<xsl:if test="contains(description, 'icon:')">
						<xsl:choose>
							<xsl:when test="contains(description, 'icon:einkaufen')">
								<img class="event-icon" src="/images/cart_white.svg" alt="Bild eines Einkaufswagens"/>
							</xsl:when>
							<xsl:when test="contains(description, 'icon:kino')">
								<img class="event-icon" src="/images/camera_white.svg" alt="Bild einer Filmkamera"/>
							</xsl:when>
							<xsl:when test="contains(description, 'icon:essen')">
								<img class="event-icon" src="/images/food_white.svg" alt="Bild von Essen"/>
							</xsl:when>
							<xsl:when test="contains(description, 'icon:geburtstag')">
								<img class="event-icon" src="/images/birthday_white.svg" alt="Bild eines Geburtstagskuchen"/>
							</xsl:when>
							<xsl:when test="contains(description, 'icon:schule')">
								<img class="event-icon" src="/images/school_white.svg" alt="Bild eines Stiftes"/>
							</xsl:when>
							<xsl:when test="contains(description, 'icon:universität')">
								<img class="event-icon" src="/images/school_white.svg" alt="Bild eines Stiftes"/>
							</xsl:when>
							<xsl:when test="contains(description, 'icon:dhbw')">
								<img class="event-icon" src="/images/school_white.svg" alt="Bild eines Stiftes"/>
							</xsl:when>
							<xsl:when test="contains(description, 'icon:vorlesung')">
								<img class="event-icon" src="/images/school_white.svg" alt="Bild eines Stiftes"/>
							</xsl:when>
							<xsl:when test="contains(description, 'icon:musik')">
								<img class="event-icon" src="/images/music_white.svg" alt="Bild von Kopfhörern"/>
							</xsl:when>
							<xsl:when test="contains(description, 'icon:film')">
								<img class="event-icon" src="/images/popcorn_inverted.svg" alt="Bild von Popcorn"/>
							</xsl:when>
							<xsl:when test="contains(description, 'icon:sport')">
								<img class="event-icon" src="/images/sport_white.svg" alt="Bild von einer Hantel"/>
							</xsl:when>
							<xsl:when test="contains(description, 'icon:friseur')">
								<img class="event-icon" src="/images/comb_white.svg" alt="Bild eines Kamms"/>
							</xsl:when>
							<xsl:when test="contains(description, 'icon:frisör')">
								<img class="event-icon" src="/images/comb_white.svg" alt="Bild eines Kamms"/>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:if test="contains(description, 'icon:') = false()">
						<xsl:choose>
							<xsl:when test="contains(name, 'Einkaufen') or contains(name, 'einkaufen')">
								<img class="event-icon" src="/images/cart_white.svg" alt="Bild eines Einkaufswagens"/>
							</xsl:when>
							<xsl:when test="contains(name, 'Kino') or contains(name, 'kino')">
								<img class="event-icon" src="/images/camera_white.svg" alt="Bild einer Filmkamera"/>
							</xsl:when>
							<xsl:when test="contains(name, 'Essen') or contains(name, 'essen')">
								<img class="event-icon" src="/images/food_white.svg" alt="Bild von Essen"/>
							</xsl:when>
							<xsl:when test="contains(name, 'Geburtstag') or contains(name, 'geburtstag')">
								<img class="event-icon" src="/images/birthday_white.svg" alt="Bild eines Geburtstagskuchen"/>
							</xsl:when>
							<xsl:when test="contains(name, 'Schule') or contains(name, 'schule')">
								<img class="event-icon" src="/images/school_white.svg" alt="Bild eines Stiftes"/>
							</xsl:when>
							<xsl:when test="contains(name, 'Universität') or contains(name, 'universität')">
								<img class="event-icon" src="/images/school_white.svg" alt="Bild eines Stiftes"/>
							</xsl:when>
							<xsl:when test="contains(name, 'DHBW') or contains(name, 'dhbw')">
								<img class="event-icon" src="/images/school_white.svg" alt="Bild eines Stiftes"/>
							</xsl:when>
							<xsl:when test="contains(name, 'Vorlesung') or contains(name, 'vorlesung')">
								<img class="event-icon" src="/images/school_white.svg" alt="Bild eines Stiftes"/>
							</xsl:when>
							<xsl:when test="contains(name, 'Musik') or contains(name, 'musik')">
								<img class="event-icon" src="/images/music_white.svg" alt="Bild von Kopfhörern"/>
							</xsl:when>
							<xsl:when test="contains(name, 'Film') or contains(name, 'film')">
								<img class="event-icon" src="/images/popcorn_white.svg" alt="Bild von Popcorn"/>
							</xsl:when>
							<xsl:when test="contains(name, 'Sport') or contains(name, 'sport')">
								<img class="event-icon" src="/images/sport_white.svg" alt="Bild von einer Hantel"/>
							</xsl:when>
							<xsl:when test="contains(name, 'Friseur') or contains(name, 'friseur')">
								<img class="event-icon" src="/images/comb_white.svg" alt="Bild eines Kamms"/>
							</xsl:when>
							<xsl:when test="contains(name, 'Frisör') or contains(name, 'frisör')">
								<img class="event-icon" src="/images/comb_white.svg" alt="Bild eines Kamms"/>
							</xsl:when>
						</xsl:choose>
						</xsl:choose>
						</xsl:choose>
						</xsl:choose>
					</xsl:if>
					<xsl:value-of select="name"/>
					<a>
						<xsl:attribute name="href">/deleteEvent?eventID=<xsl:value-of select="@ID"/>&amp;<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/></xsl:attribute>
						<img class="eventIcon" src="/images/trash_white.svg" alt="Ereignis löschen"/>
					</a>
				</div>
			</div>
		</a>
	</xsl:template>
</xsl:stylesheet>