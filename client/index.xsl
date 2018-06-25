<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
								xmlns="http://www.w3.org/1999/xhtml">

	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>

	<xsl:template match="event" mode="calendar__event">
		<div>
			<xsl:attribute name="class">calendar__event starts_<xsl:value-of select="startTimeHour"/>_<xsl:value-of select="startTimeMinute"/> length_<xsl:value-of select="endTimeHour - startTimeHour "/>_<xsl:value-of select="endTimeMinute - startTimeMinute "/>
			</xsl:attribute>
			<xsl:value-of select="name"/>
		</div>
	</xsl:template>

	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="/css/main.css"/>
				<link rel="stylesheet" type="text/css" href="/css/calendar.css"/>
			</head>
			<body>
				<header>
					<h1>Mein Kalender</h1>
					<h2> - Diese Woche</h2>
				</header>
				<div class="calendar">
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
					<div class="calendar__days">
						<div class="calendar__day">
							<h3>Montag</h3>
							<div class="calendar__events">
								<xsl:for-each select="//week/events/event/startDateDay[//week/firstDateDay]">
									<xsl:apply-templates mode="calendar__event" select=".."/>
								</xsl:for-each>
							</div>
						</div>
						<div class="calendar__day">
							<h3>Dienstag</h3>
							<div class="calendar__events">
								<xsl:for-each select="//week/events/event/startDateDay[//week/firstDateDay + 1]">
									<xsl:apply-templates mode="calendar__event" select=".."/>
								</xsl:for-each>
							</div>
						</div>
						<div class="calendar__day">
							<h3>Mittwoch</h3>
							<div class="calendar__events">
								<xsl:for-each select="//week/events/event/startDateDay[//week/firstDateDay + 2]">
									<xsl:apply-templates mode="calendar__event" select=".."/>
								</xsl:for-each>
							</div>
						</div>
						<div class="calendar__day">
							<h3>Donnerstag</h3>
							<div class="calendar__events">
								<xsl:for-each select="//week/events/event/startDateDay[//week/firstDateDay + 3]">
									<xsl:apply-templates mode="calendar__event" select=".."/>
								</xsl:for-each>
							</div>
						</div>
						<div class="calendar__day">
							<h3>Freitag</h3>
							<div class="calendar__events">
								<xsl:for-each select="//week/events/event/startDateDay[//week/firstDateDay + 4]">
									<xsl:apply-templates mode="calendar__event" select=".."/>
								</xsl:for-each>
							</div>
						</div>
						<div class="calendar__day">
							<h3>Samstag</h3>
							<div class="calendar__events">
								<xsl:for-each select="//week/events/event/startDateDay[//week/firstDateDay + 5]">
									<xsl:apply-templates mode="calendar__event" select=".."/>
								</xsl:for-each>
							</div>
						</div>
						<div class="calendar__day">
							<h3>Sonntag</h3>
							<div class="calendar__events">
								<xsl:for-each select="//week/events/event/startDateDay[//week/firstDateDay + 6]">
									<xsl:apply-templates mode="calendar__event" select=".."/>
								</xsl:for-each>
							</div>
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
