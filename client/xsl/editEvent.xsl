<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN"
	            doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
	<xsl:template match="editEvent">
		<div id="newEventWindowDiv" class="card">
			<h3 class="centeredText">Termin bearbeiten</h3>
			<div>
				<form id="editEventForm" method="post">
					<xsl:attribute name="action">/editEvent?eventID=<xsl:value-of select="//meta/editEvent/ID"/>&amp;<xsl:value-of
						select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/>
					</xsl:attribute>
					<div class="newEventFormDiv">
						Termin Name:
						<br/>
						<input type="text" name="eventName" style="width: 80%; margin-left: 0px;" required="required">
							<xsl:attribute name="value">
								<xsl:value-of select="//events/event[ @ID = //meta/editEvent/ID]/name"/>
							</xsl:attribute>
						</input>
						<br/>
					</div>
					<div class="newEventFormDiv">
						<table>
							<tr>
								<td>Von</td>
								<td>
									<input type="date" name="eventStartDate" required="required">
										<xsl:attribute name="value"><xsl:value-of
											select="//events/event[ @ID = //meta/editEvent/ID]/startdate/@year"/>-
											<xsl:if test="//events/event[ @ID= //meta/editEvent/ID]/startdate/@month &gt; 9">
												<xsl:value-of select="//events/event[ @ID= //meta/editEvent/ID]/startdate/@month"/>
											</xsl:if>
											<xsl:if test="//events/event[@ID= //meta/editEvent/ID]/startdate/@month &lt; 10">0<xsl:value-of
												select="//events/event[@ID= //meta/editEvent/ID]/startdate/@month"/>
											</xsl:if>
											-
											<xsl:if test="//events/event[@ID= //meta/editEvent/ID]/startdate/@day &gt; 9">
												<xsl:value-of select="//events/event[@ID= //meta/editEvent/ID]/startdate/@day"/>
											</xsl:if>
											<xsl:if test="//events/event[@ID= //meta/editEvent/ID]/startdate/@day &lt; 10">0<xsl:value-of
												select="//events/event[@ID= //meta/editEvent/ID]/startdate/@day"/>
											</xsl:if>
										</xsl:attribute>
									</input>
								</td>
								<td>um</td>
								<td>
									<input type="time" name="eventStartTime" required="required">
										<xsl:attribute name="value">
											<xsl:if test="//events/event[ @ID = //meta/editEvent/ID]/startdate/@hour &lt; 10">0<xsl:value-of
												select="//events/event[ @ID= //meta/editEvent/ID]/startdate/@hour"/>
											</xsl:if>
											<xsl:if test="//events/event[@ID= //meta/editEvent/ID]/startdate/@hour &gt; 9">
												<xsl:value-of
													select="//events/event[ @ID= //meta/editEvent/ID]/startdate/@hour"/>
											</xsl:if>
											:
											<xsl:if test="//events/event[@ID= //meta/editEvent/ID]/startdate/@minute &lt; 10">0<xsl:value-of
												select="//events/event[ @ID= //meta/editEvent/ID]/startdate/@minute"/>
											</xsl:if>
											<xsl:if test="//events/event[@ID= //meta/editEvent/ID]/startdate/@minute &gt; 9">
												<xsl:value-of
													select="//events/event[ @ID= //meta/editEvent/ID]/startdate/@minute"/>
											</xsl:if>
										</xsl:attribute>
									</input>
								</td>
								<td>Uhr</td>
							</tr>
							<tr>
								<td>Bis</td>
								<td>
									<input type="date" name="eventEndDate" required="required" value="">
										<xsl:attribute name="value"><xsl:value-of
											select="//events/event[@ID= //meta/editEvent/ID]/enddate/@year"/>-
											<xsl:if test="//events/event[@ID= //meta/editEvent/ID]/enddate/@month &gt; 9">
												<xsl:value-of select="//events/event[@ID= //meta/editEvent/ID]/enddate/@month"/>
											</xsl:if>
											<xsl:if test="//events/event[@ID= //meta/editEvent/ID]/enddate/@month &lt; 10">0<xsl:value-of
												select="//events/event[@ID= //meta/editEvent/ID]/enddate/@month"/>
											</xsl:if>
											-
											<xsl:if test="//events/event[@ID= //meta/editEvent/ID]/enddate/@day &gt; 9">
												<xsl:value-of select="//events/event[@ID= //meta/editEvent/ID]/enddate/@day"/>
											</xsl:if>
											<xsl:if test="//events/event[@ID= //meta/editEvent/ID]/enddate/@day &lt; 10">0<xsl:value-of
												select="//events/event[@ID= //meta/editEvent/ID]/enddate/@day"/>
											</xsl:if>
										</xsl:attribute>
									</input>
								</td>
								<td>um</td>
								<td>
									<input type="time" name="eventEndTime" required="required">
										<xsl:attribute name="value">
											<xsl:if test="//events/event[@ID= //meta/editEvent/ID]/enddate/@hour &lt; 10">0<xsl:value-of
												select="//events/event[@ID= //meta/editEvent/ID]/enddate/@hour"/>
											</xsl:if>
											<xsl:if test="//events/event[@ID= //meta/editEvent/ID]/enddate/@hour &gt; 9">
												<xsl:value-of
													select="//events/event[@ID= //meta/editEvent/ID]/enddate/@hour"/>
											</xsl:if>
											:
											<xsl:if test="//events/event[@ID= //meta/editEvent/ID]/enddate/@minute &lt; 10">0<xsl:value-of
												select="//events/event[@ID= //meta/editEvent/ID]/enddate/@minute"/>
											</xsl:if>
											<xsl:if test="//events/event[@ID= //meta/editEvent/ID]/enddate/@minute &gt; 9">
												<xsl:value-of
													select="//events/event[@ID= //meta/editEvent/ID]/enddate/@minute"/>
											</xsl:if>
										</xsl:attribute>
									</input>
								</td>
								<td>Uhr</td>
							</tr>
						</table>
					</div>
					<hr style="width:90%; opacity:0.5;"/>
					<div class="newEventFormDiv">
						Ort:
						<br/>
						<input type="text" name="eventLocation" style="width: 80%; margin-left: 0px;">
							<xsl:attribute name="value">
								<xsl:value-of select="//events/event[@ID= //meta/editEvent/ID]/location"/>
							</xsl:attribute>
						</input>
						<br/>
						Details:
						<br/>
						<textarea form="editEventForm" style="margin-top: 5px; width: 80%; resize: none" name="eventDescription"
						          rows="5">
							<xsl:value-of select="//events/event[@ID= //meta/editEvent/ID]/description"/>
						</textarea>
						<br/>
					</div>
					<div class="newEventButtonsDiv">
						<input type="submit" value="Termin ändern"/>
					</div>
				</form>
			</div>
			<a>
				<xsl:attribute name="href">/?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/>
				</xsl:attribute>
				<button class="closePopupButton">x</button>
			</a>
		</div>
	</xsl:template>
</xsl:stylesheet>

