<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml">

	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN"
	            doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>

	<xsl:template match="event" mode="calendar__event">
		<div>
			<xsl:attribute name="class">calendar__event starts_<xsl:value-of select="startTimeHour"/>_<xsl:value-of
				select="startTimeMinute"/> length_<xsl:value-of select="endTimeHour - startTimeHour "/>_<xsl:if
				test="endTimeMinute > startTimeMinute"><xsl:value-of select="endTimeMinute - startTimeMinute"/></xsl:if><xsl:if
				test="startTimeMinute > endTimeMinute"><xsl:value-of select="startTimeMinute - endTimeMinute"/></xsl:if>
			</xsl:attribute>
			<xsl:value-of select="name"/>
		</div>
	</xsl:template>

	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="/css/main.css"/>
				<link rel="stylesheet" type="text/css" href="/css/calendar.css"/>
                <link rel="stylesheet" type="text/css" href="/css/eventDetail.css"/>
				<link href="https://fonts.googleapis.com/css?family=Roboto:400,500" rel="stylesheet"/>
				<link rel="shortcut icon" type="image/png" href="/images/icon.png"/>
				<title>Kalender vom <xsl:value-of select="//week/firstDateDay"/>.<xsl:value-of select="//week/firstDateMonth"/>.
					bis <xsl:value-of select="//week/lastDateDay"/>.<xsl:value-of
						select="//week/lastDateMonth"/>.
				</title>
			</head>
			<body>
				<header class="fixed">
					<h1>Mein Kalender</h1>
					<h2>- Diese Woche</h2>
				</header>
				
				<div class="calendar">
					<div class="calendar__header">
						<div class="calendar__header__legend__padding"/>
						<h3>Montag <xsl:value-of select="//week/firstDateDay"/>.
						</h3>
						<h3>Dienstag <xsl:value-of select="//week/firstDateDay + 1"/>.
						</h3>
						<h3>Mittwoch <xsl:value-of select="//week/firstDateDay + 2"/>.
						</h3>
						<h3>Donnerstag <xsl:value-of select="//week/firstDateDay + 3"/>.
						</h3>
						<h3>Freitag <xsl:value-of select="//week/firstDateDay + 4"/>.
						</h3>
						<h3>Samstag <xsl:value-of select="//week/firstDateDay + 5"/>.
						</h3>
						<h3>Sonntag <xsl:value-of select="//week/firstDateDay + 6"/>.
						</h3>
					</div>
					<div class="calendar__body">
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
							<xsl:for-each select="//week/events/event/startDateDay[ . = //week/firstDateDay]">
								<xsl:apply-templates mode="calendar__event" select=".."/>
							</xsl:for-each>
						</div>
						<div class="calendar__day">
							<xsl:for-each select="//week/events/event/startDateDay[ . = //week/firstDateDay + 1]">
								<xsl:apply-templates mode="calendar__event" select=".."/>
							</xsl:for-each>
						</div>
						<div class="calendar__day">
							<xsl:for-each select="//week/events/event/startDateDay[ . = //week/firstDateDay + 2]">
								<xsl:apply-templates mode="calendar__event" select=".."/>
							</xsl:for-each>
						</div>
						<div class="calendar__day">
							<xsl:for-each select="//week/events/event/startDateDay[ . = //week/firstDateDay + 3]">
								<xsl:apply-templates mode="calendar__event" select=".."/>
							</xsl:for-each>
						</div>
						<div class="calendar__day">
							<xsl:for-each select="//week/events/event/startDateDay[ . = //week/firstDateDay + 4]">
								<xsl:apply-templates mode="calendar__event" select=".."/>
							</xsl:for-each>
						</div>
						<div class="calendar__day">
							<xsl:for-each select="//week/events/event/startDateDay[ . = //week/firstDateDay + 5]">
								<xsl:apply-templates mode="calendar__event" select=".."/>
							</xsl:for-each>
						</div>
						<div class="calendar__day">
							<xsl:for-each select="//week/events/event/startDateDay[ . = //week/firstDateDay + 6]">
								<xsl:apply-templates mode="calendar__event" select=".."/>
							</xsl:for-each>
						</div>
					</div>
				</div>
				<div>
				 <button type="button" class="addButton">+</button> 
				</div>
				<div id="addNewEventView" class="newEventDiv">
					<h3 class="centeredText">Neuer Termin</h3>
					<div>
						<form id="newEventForm" action="/addEvent" method="post">
							 <div class="newEventFormDiv">
                                 Termin Name: <input type="text" name="eventName"/> <br/>
                                 <textarea form="newEventForm" style="margin-top: 5px; width: 80%; resize: none" name="eventDescription" rows="4">Beschreibung</textarea> <br/>
                             </div>
                            <hr style="width:90%; opacity:0.5;"/>
                            <div class="newEventFormDiv">
                                Von <input type="date" name="eventStartDate"/> <input type="time" name="eventStartTime"/> Uhr<br/>
                                Bis <input type="date" name="eventEndDate"/> <input type="time" name="eventEndTime"/> Uhr<br/>
                            </div>
                            <hr style="width:90%; opacity:0.5;"/>
                            <div class="newEventFormDiv">
                                Ort: <input type="text" name="eventLocation"/>
                            </div>
							 <div class="newEventButtonsDiv">
							 	<input type="reset" value="Zurücksetzen"/> 
								<input type="submit" value="Zum Kalender hinzufügen"/>
							 </div>
						</form> 
					</div>
				</div>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
