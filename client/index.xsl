<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
								xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
								xmlns="http://www.w3.org/1999/xhtml">

	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN"
							doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>

	<xsl:include href="newEvent.xsl"/>
	<xsl:include href="details.xsl"/>
	<xsl:include href="week.xsl"/>
	<xsl:include href="day.xsl"/>

	<xsl:template match="event" mode="calendar__event">
		<a>
			<xsl:attribute name="href">/showEvent?eventID=<xsl:value-of select="ID"/>&amp;<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/></xsl:attribute>
			<div>
				<xsl:attribute name="class">calendar__event starts_<xsl:value-of select="startTimeHour"/>_<xsl:value-of
					select="startTimeMinute"/> length_<xsl:value-of select="number(endTimeHour) - number(startTimeHour) "/>_<xsl:if
						test="endTimeMinute > startTimeMinute"><xsl:value-of
						select="number(endTimeMinute) - number(startTimeMinute)"/>
					</xsl:if><xsl:if test="startTimeMinute > endTimeMinute"><xsl:value-of
						select="number(startTimeMinute) - number(endTimeMinute)"/></xsl:if><xsl:if
						test="startTimeMinute = endTimeMinute">0</xsl:if>
				</xsl:attribute>
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
						<xsl:attribute name="href">/deleteEvent?eventID=<xsl:value-of select="ID"/>&amp;<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/></xsl:attribute>
						<img class="eventTrash" src="/images/trash_white.svg"/>
					</a>
				</div>
			</div>
		</a>
	</xsl:template>

	<xsl:template match="/">
		<html lang="de" xml:lang="de" xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<link rel="stylesheet" type="text/css" href="/css/main.css"/>
				<link rel="stylesheet" type="text/css" href="/css/calendar.css"/>
				<link rel="stylesheet" type="text/css" href="/css/eventDetail.css"/>
				<link rel="stylesheet" type="text/css" href="/css/addRemote.css"/>
				<link rel="stylesheet" type="text/css" href="/css/event.css"/>
				<link href="https://fonts.googleapis.com/css?family=Roboto:400,500" rel="stylesheet"/>
				<link rel="shortcut icon" type="image/png" href="/images/icon.png"/>
				<title>Kalender vom <xsl:value-of select="//firstDateDay"/>.<xsl:value-of select="//firstDateMonth"/>.
					bis <xsl:value-of select="//lastDateDay"/>.<xsl:value-of
						select="//lastDateMonth"/>.
				</title>

			</head>
			<body>
				
				<xsl:apply-templates select="/calendar"/>

				<div>
					<a>
						<xsl:attribute name="href">\newEvent?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/></xsl:attribute>
						<button type="button" class="addButton">+</button>
					</a>
				</div>
				<div class="leftPageScrollingDiv">
					<a>
						<xsl:attribute name="href">\?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset - 1"/></xsl:attribute>
						<button type="button" class="pageScrollButton"> &lt; </button>
					</a>
				</div>
				<div class="rightPageScrollingDiv">
					<a>
						<xsl:attribute name="href">\?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset + 1"/></xsl:attribute>
						<button type="button" class="pageScrollButton"> &gt; </button>
					</a>
				</div>

				<xsl:apply-templates select="//meta/*"/>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
