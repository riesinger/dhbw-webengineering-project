<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN"
	            doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
	<xsl:strip-space elements="*"/>

	<xsl:variable name="evt" select="//events/event[ @ID = //meta/showEvent/ID or @ID = //meta/editEvent/ID ]"/>

	<!-- dateInput ist ein Template, welches ein Eingabefeld für ein Datum erstellt.
		Es präfixt das Eingabedatum automatisch mit führenden Nullen.
		-->
	<xsl:template name="dateInput">
		<xsl:param name="date"/>
		<xsl:param name="disabled" select="false()"/>
		<xsl:param name="inputName"/>
		<input type="date" name="eventStartDate" required="required">
			<xsl:attribute name="name">
				<xsl:value-of select="$inputName"/>
			</xsl:attribute>
			<xsl:if test="$disabled = true()">
				<xsl:attribute name="disabled">disabled</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="value">
				<xsl:value-of select="$date/@year"/>
				<xsl:text>-</xsl:text>
				<xsl:if test="$date/@month &gt; 9">
					<xsl:value-of select="$date/@month"/>
				</xsl:if>
				<xsl:if test="$date/@month &lt; 10">
					<xsl:text>0</xsl:text>
					<xsl:value-of select="$date/@month"/>
				</xsl:if>
				<xsl:text>-</xsl:text>
				<xsl:if test="$date/@day &gt; 9">
					<xsl:value-of select="$date/@day"/>
				</xsl:if>
				<xsl:if test="$date/@day &lt; 10">
					<xsl:text>0</xsl:text>
					<xsl:value-of select="$date/@day"/>
				</xsl:if>
			</xsl:attribute>
		</input>

	</xsl:template>

	<!-- timeInput ist ein Template, welches ein Eingabefeld für eine Uhrzeit erstellt.
		Es präfixt die Eingabeuhrzeit automatisch mit führenden Nullen.
		-->
	<xsl:template name="timeInput">
		<xsl:param name="date"/>
		<xsl:param name="disabled" select="false()"/>
		<xsl:param name="inputName"/>
		<input type="time" name="eventStartTime" required="required">
			<xsl:attribute name="name">
				<xsl:value-of select="$inputName"/>
			</xsl:attribute>
			<xsl:if test="$disabled">
				<xsl:attribute name="disabled">disabled</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="value">
				<xsl:if test="$date/@hour &lt; 10">
					<xsl:text>0</xsl:text>
					<xsl:value-of select="$date/@hour"/>
				</xsl:if>
				<xsl:if test="$date/@hour &gt; 9">
					<xsl:value-of select="$date/@hour"/>
				</xsl:if>
				<xsl:text>:</xsl:text>
				<xsl:if test="$date/@minute &lt; 10">
					<xsl:text>0</xsl:text>
					<xsl:value-of select="$date/@minute"/>
				</xsl:if>
				<xsl:if test="$date/@minute &gt; 9">
					<xsl:value-of
						select="$date/@minute"/>
				</xsl:if>
			</xsl:attribute>
		</input>
	</xsl:template>

	<xsl:template match="showEvent|editEvent">
		<div id="newEventWindowDiv" class="card">
			<h3 class="centeredText">
				<xsl:if test="//meta/showEvent">Termin</xsl:if>
				<xsl:if test="//meta/editEvent">Termin bearbeiten</xsl:if>
			</h3>
			<div id="showEvent">

				<form id="showEventForm" method="post">
					<xsl:if test="//meta/editEvent">
						<xsl:attribute name="action">
							<xsl:text>/editEvent?eventID=</xsl:text>
							<xsl:value-of select="//meta/editEvent/ID"/>
							<xsl:text>&amp;</xsl:text>
							<xsl:value-of select="//meta/dispForm"/>
							<xsl:text>=</xsl:text>
							<xsl:value-of select="//meta/dateOffset"/>
						</xsl:attribute>
					</xsl:if>
					<div class="newEventFormDiv">
						Name:
						<br/>
						<div style="display: flex; align-items: center;">
							<xsl:if test="contains($evt/description, 'icon:')">
								<xsl:choose>
									<xsl:when test="contains($evt/description, 'icon:einkaufen')">
										<img class="event-icon" src="/images/cart_black.svg" alt="Bild eines Einkaufswagens"/>
									</xsl:when>
									<xsl:when test="contains($evt/description, 'icon:kino')">
										<img class="event-icon" src="/images/camera_black.svg" alt="Bild einer Filmkamera"/>
									</xsl:when>
									<xsl:when test="contains($evt/description, 'icon:essen')">
										<img class="event-icon" src="/images/food_black.svg" alt="Bild von Essen"/>
									</xsl:when>
									<xsl:when test="contains($evt/description, 'icon:geburtstag')">
										<img class="event-icon" src="/images/birthday_black.svg" alt="Bild eines Geburtstagskuchen"/>
									</xsl:when>
									<xsl:when test="contains($evt/description, 'icon:schule')">
										<img class="event-icon" src="/images/school_black.svg" alt="Bild eines Stiftes"/>
									</xsl:when>
									<xsl:when test="contains($evt/description, 'icon:universität')">
										<img class="event-icon" src="/images/school_black.svg" alt="Bild eines Stiftes"/>
									</xsl:when>
									<xsl:when test="contains($evt/description, 'icon:dhbw')">
										<img class="event-icon" src="/images/school_black.svg" alt="Bild eines Stiftes"/>
									</xsl:when>
									<xsl:when test="contains($evt/description, 'icon:vorlesung')">
										<img class="event-icon" src="/images/school_black.svg" alt="Bild eines Stiftes"/>
									</xsl:when>
									<xsl:when test="contains($evt/description, 'icon:musik')">
										<img class="event-icon" src="/images/music_black.svg" alt="Bild von Kopfhörern"/>
									</xsl:when>
									<xsl:when test="contains($evt/description, 'icon:film')">
										<img class="event-icon" src="/images/popcorn_inverted.svg" alt="Bild von Popcorn"/>
									</xsl:when>
									<xsl:when test="contains($evt/description, 'icon:sport')">
										<img class="event-icon" src="/images/sport_black.svg" alt="Bild von einer Hantel"/>
									</xsl:when>
									<xsl:when test="contains($evt/description, 'icon:friseur')">
										<img class="event-icon" src="/images/comb_black.svg" alt="Bild eines Kamms"/>
									</xsl:when>
									<xsl:when test="contains($evt/description, 'icon:frisör')">
										<img class="event-icon" src="/images/comb_black.svg" alt="Bild eines Kamms"/>
									</xsl:when>
									<xsl:when test="contains($evt/description, 'icon:programmieren')">
										<img class="event-icon" src="/images/laptop_black.svg" alt="Bild eines Laptops"/>
									</xsl:when>
									<xsl:when test="contains($evt/description, 'icon:schlafen')">
										<img class="event-icon" src="/images/sleep_black.svg" alt="Bild eines Bettes"/>
									</xsl:when>
								</xsl:choose>
							</xsl:if>
							<xsl:if test="contains($evt/description, 'icon:') = false()">
								<xsl:choose>
									<xsl:when test="contains($evt/name, 'Einkaufen') or contains($evt/name, 'einkaufen')">
										<img class="event-icon" src="/images/cart_black.svg" alt="Bild eines Einkaufswagens"/>
									</xsl:when>
									<xsl:when test="contains($evt/name, 'Kino') or contains($evt/name, 'kino')">
										<img class="event-icon" src="/images/camera_black.svg" alt="Bild einer Filmkamera"/>
									</xsl:when>
									<xsl:when test="contains($evt/name, 'Essen') or contains($evt/name, 'essen')">
										<img class="event-icon" src="/images/food_black.svg" alt="Bild von Essen"/>
									</xsl:when>
									<xsl:when test="contains($evt/name, 'Geburtstag') or contains($evt/name, 'geburtstag')">
										<img class="event-icon" src="/images/birthday_black.svg" alt="Bild eines Geburtstagskuchen"/>
									</xsl:when>
									<xsl:when test="contains($evt/name, 'Schule') or contains($evt/name, 'schule')">
										<img class="event-icon" src="/images/school_black.svg" alt="Bild eines Stiftes"/>
									</xsl:when>
									<xsl:when test="contains($evt/name, 'Universität') or contains($evt/name, 'universität')">
										<img class="event-icon" src="/images/school_black.svg" alt="Bild eines Stiftes"/>
									</xsl:when>
									<xsl:when test="contains($evt/name, 'DHBW') or contains($evt/name, 'dhbw')">
										<img class="event-icon" src="/images/school_black.svg" alt="Bild eines Stiftes"/>
									</xsl:when>
									<xsl:when test="contains($evt/name, 'Vorlesung') or contains($evt/name, 'vorlesung')">
										<img class="event-icon" src="/images/school_black.svg" alt="Bild eines Stiftes"/>
									</xsl:when>
									<xsl:when test="contains($evt/name, 'Musik') or contains($evt/name, 'musik')">
										<img class="event-icon" src="/images/music_black.svg" alt="Bild von Kopfhörern"/>
									</xsl:when>
									<xsl:when test="contains($evt/name, 'Film') or contains($evt/name, 'film')">
										<img class="event-icon" src="/images/popcorn_inverted.svg" alt="Bild von Popcorn"/>
									</xsl:when>
									<xsl:when test="contains($evt/name, 'Sport') or contains($evt/name, 'sport')">
										<img class="event-icon" src="/images/sport_black.svg" alt="Bild von einer Hantel"/>
									</xsl:when>
									<xsl:when test="contains($evt/name, 'Friseur') or contains($evt/name, 'friseur')">
										<img class="event-icon" src="/images/comb_black.svg" alt="Bild eines Kamms"/>
									</xsl:when>
									<xsl:when test="contains($evt/name, 'Frisör') or contains($evt/name, 'frisör')">
										<img class="event-icon" src="/images/comb_black.svg" alt="Bild eines Kamms"/>
									</xsl:when>
									<xsl:when test="contains($evt/name, 'Programmieren') or contains($evt/name, 'programmieren')">
										<img class="event-icon" src="/images/laptop_black.svg" alt="Bild eines Laptops"/>
									</xsl:when>
									<xsl:when test="contains($evt/name, 'Schlafen') or contains($evt/name, 'schlafen')">
										<img class="event-icon" src="/images/sleep_black.svg" alt="Bild eines Bettes"/>
									</xsl:when>
								</xsl:choose>
							</xsl:if>

							<input type="text" name="eventName" required="required">
								<xsl:if test="//meta/showEvent">
									<xsl:attribute name="disabled">disabled</xsl:attribute>
								</xsl:if>
								<xsl:attribute name="value">
									<xsl:value-of select="//events/event[ @ID = //meta/showEvent/ID or @ID = //meta/editEvent/ID ]/name"/>
								</xsl:attribute>
							</input>

						</div>

						<br/>
					</div>
					<div class="newEventFormDiv" style="display: flex;">
						<table style="max-width: 90%; margin-right: 24px;">
							<tr>
								<td>Am</td>
								<td>
									<xsl:call-template name="dateInput">
										<xsl:with-param name="inputName">
											<xsl:text>eventStartDate</xsl:text>
										</xsl:with-param>
										<xsl:with-param name="date" select="//events/event[ @ID = //meta/*/ID]/startdate"/>
										<xsl:with-param name="disabled" select="//meta/showEvent"/>
									</xsl:call-template>
								</td>
								<td>von</td>
								<td>
									<xsl:call-template name="timeInput">
										<xsl:with-param name="inputName">
											<xsl:text>eventStartTime</xsl:text>
										</xsl:with-param>
										<xsl:with-param name="date" select="//events/event[ @ID = //meta/*/ID]/startdate"/>
										<xsl:with-param name="disabled" select="//meta/showEvent"/>
									</xsl:call-template>
								</td>
								<td>Uhr</td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td>bis</td>
								<td>
									<xsl:call-template name="timeInput">
										<xsl:with-param name="inputName">
											<xsl:text>eventEndTime</xsl:text>
										</xsl:with-param>
										<xsl:with-param name="date" select="//events/event[ @ID = //meta/*/ID]/enddate"/>
										<xsl:with-param name="disabled" select="//meta/showEvent"/>
									</xsl:call-template>
								</td>
								<td>Uhr</td>
							</tr>
						</table>


					</div>
					<hr/>
					<div class="newEventFormDiv">
						Ort:
						<br/>
						<input type="text" name="eventLocation">
							<xsl:if test="//meta/showEvent">
								<xsl:attribute name="disabled">disabled</xsl:attribute>
							</xsl:if>
							<xsl:attribute name="value">
								<xsl:value-of select="//events/event[@ID= //meta/showEvent/ID or @ID = //meta/editEvent/ID]/location"/>
							</xsl:attribute>
						</input>
						<br/>
						Details:
						<br/>
						<textarea name="eventDescription">
							<xsl:if test="//meta/showEvent">
								<xsl:attribute name="disabled">disabled</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="//events/event[@ID= //meta/showEvent/ID or @ID = //meta/editEvent/ID]/description"/>
						</textarea>
						<br/>
					</div>
					<div class="newEventButtonsDiv">
						<xsl:if test="//meta/showEvent">
							<a>
								<xsl:attribute name="href">/editEvent?eventID=<xsl:value-of
									select="//meta/showEvent/ID"/>&amp;<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of
									select="//meta/dateOffset"/>
								</xsl:attribute>
								<img src="/images/edit_black.svg" class="editIcon" alt="Ereignis bearbeiten"/>
							</a>
						</xsl:if>
						<xsl:if test="//meta/editEvent">
							<input type="submit" value="Termin ändern"/>
						</xsl:if>

					</div>
				</form>
			</div>
			<a>
				<xsl:attribute name="href">/?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/>
				</xsl:attribute>
				<button class="closePopupButton">
					<img src="/images/x_black.svg" alt="Schließen"/>
				</button>
			</a>
		</div>
	</xsl:template>
</xsl:stylesheet>
