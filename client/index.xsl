<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
								xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
								xmlns="http://www.w3.org/1999/xhtml">

	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN"
							doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>

	<xsl:include href="newEvent.xsl"/>
	<xsl:include href="details.xsl"/>

	<xsl:template match="event" mode="calendar__event">
		<a>
			<xsl:attribute name="href">/showEvent?eventID=<xsl:value-of select="ID"/>&amp;week=<xsl:value-of select="//meta/weekSelected"/></xsl:attribute>
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
						<xsl:attribute name="href">/deleteEvent?eventID=<xsl:value-of select="ID"/>
						</xsl:attribute>
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
				<title>Kalender vom <xsl:value-of select="//week/firstDateDay"/>.<xsl:value-of select="//week/firstDateMonth"/>.
					bis <xsl:value-of select="//week/lastDateDay"/>.<xsl:value-of
						select="//week/lastDateMonth"/>.
				</title>

			</head>
			<body>
				<div class="header fixed">
					<h1>Mein Kalender</h1>
					<h2>- Diese Woche</h2>
					<div class="buttons">
						<div class="leftPageScrollingDiv">
							<a title="Zurück">
								<xsl:attribute name="href">\?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset - 1"/></xsl:attribute>
								 &lt;
							</a>
						</div>
						<div class="rightPageScrollingDiv">
							<a title="Weiter">
								<xsl:attribute name="href">\?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset + 1"/></xsl:attribute>
								 &gt;
							</a>
						</div>
					</div>
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
						<div>
							<xsl:attribute name="class">current_time_line time_<xsl:value-of select="//week/currentDateHour"/>_<xsl:value-of
								select="//week/currentDateMinute"/></xsl:attribute>
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
				<div>
					<a>
						<xsl:attribute name="href">\newEvent?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/></xsl:attribute>
						<button type="button" class="addButton">+</button>
					</a>
				</div>

				<xsl:apply-templates select="//meta/*"/>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
