<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
    <xsl:template match="showEvent">
        <div id="newEventWindowDiv" class="card">
            <h3 class="centeredText">Termin</h3>
            <div>
                <form id="showEventForm" method="post">
                    <div class="newEventFormDiv">
                        Termin Name:<br/>
                        <input type="text" name="eventName" style="width: 80%; margin-left: 0px;" required="required" disabled="disabled">
                            <xsl:attribute name="value"><xsl:value-of select="//events/event[ @ID = //meta/showEvent/ID]/name"/></xsl:attribute>
                        </input><br/>
                    </div>
                    <div class="newEventFormDiv">
                        <table>
                            <tr>
                                <td>Von</td>
                                <td><input type="date" name="eventStartDate" required="required" disabled="disabled">
                                    <xsl:attribute name="value"><xsl:value-of select="//events/event[ @ID = //meta/showEvent/ID]/startdate/@year"/>-<xsl:if test="//events/event[ @ID= //meta/showEvent/ID]/startdate/@month &gt; 9"><xsl:value-of select="//events/event[ @ID= //meta/showEvent/ID]/startdate/@month"/></xsl:if><xsl:if test="//events/event[@ID= //meta/showEvent/ID]/startdate/@month &lt; 10">0<xsl:value-of select="//events/event[@ID= //meta/showEvent/ID]/startdate/@month"/></xsl:if>-<xsl:if test="//events/event[@ID= //meta/showEvent/ID]/startdate/@day &gt; 9"><xsl:value-of select="//events/event[@ID= //meta/showEvent/ID]/startdate/@day"/></xsl:if><xsl:if test="//events/event[@ID= //meta/showEvent/ID]/startdate/@day &lt; 10">0<xsl:value-of select="//events/event[@ID= //meta/showEvent/ID]/startdate/@day"/></xsl:if></xsl:attribute>
                                </input></td>
                                <td> um </td>
                                <td>
                                    <input type="time" name="eventStartTime" required="required" disabled="disabled">
                                        <xsl:attribute name="value"><xsl:if test="//events/event[ @ID = //meta/showEvent/ID]/startdate/@hour &lt; 10">0<xsl:value-of
                                                select="//events/event[ @ID= //meta/showEvent/ID]/startdate/@hour"/></xsl:if><xsl:if test="//events/event[@ID= //meta/showEvent/ID]/startdate/@hour &gt; 9"><xsl:value-of
                                                select="//events/event[ @ID= //meta/showEvent/ID]/startdate/@hour"/></xsl:if>:<xsl:if test="//events/event[@ID= //meta/showEvent/ID]/startdate/@minute &lt; 10">0<xsl:value-of
                                                select="//events/event[ @ID= //meta/showEvent/ID]/startdate/@minute"/></xsl:if><xsl:if test="//events/event[@ID= //meta/showEvent/ID]/startdate/@minute &gt; 9"><xsl:value-of
                                                select="//events/event[ @ID= //meta/showEvent/ID]/startdate/@minute"/></xsl:if></xsl:attribute>
                                    </input>
                                </td>
                                <td>Uhr</td>
                            </tr>
                            <tr>
                                <td>Bis</td>
                                <td><input type="date" name="eventEndDate" required="required" disabled="disabled">
                                    <xsl:attribute name="value"><xsl:value-of select="//events/event[@ID= //meta/showEvent/ID]/enddate/@year"/>-<xsl:if test="//events/event[@ID= //meta/showEvent/ID]/enddate/@month &gt; 9"><xsl:value-of select="//events/event[@ID= //meta/showEvent/ID]/enddate/@month"/></xsl:if><xsl:if test="//events/event[@ID= //meta/showEvent/ID]/enddate/@month &lt; 10">0<xsl:value-of select="//events/event[@ID= //meta/showEvent/ID]/enddate/@month"/></xsl:if>-<xsl:if test="//events/event[@ID= //meta/showEvent/ID]/enddate/@day &gt; 9"><xsl:value-of select="//events/event[@ID= //meta/showEvent/ID]/enddate/@day"/></xsl:if><xsl:if test="//events/event[@ID= //meta/showEvent/ID]/enddate/@day &lt; 10">0<xsl:value-of select="//events/event[@ID= //meta/showEvent/ID]/enddate/@day"/></xsl:if>
                                    </xsl:attribute>
                                </input></td>
                                <td> um </td>
                                <td>
                                    <input type="time" name="eventEndTime" required="required" disabled="disabled">
                                        <xsl:attribute name="value"><xsl:if test="//events/event[@ID= //meta/showEvent/ID]/enddate/@hour &lt; 10">0<xsl:value-of
                                                select="//events/event[@ID= //meta/showEvent/ID]/enddate/@hour"/></xsl:if><xsl:if test="//events/event[@ID= //meta/showEvent/ID]/enddate/@hour &gt; 9"><xsl:value-of
                                                select="//events/event[@ID= //meta/showEvent/ID]/enddate/@hour"/></xsl:if>:<xsl:if test="//events/event[@ID= //meta/showEvent/ID]/enddate/@minute &lt; 10">0<xsl:value-of
                                                select="//events/event[@ID= //meta/showEvent/ID]/enddate/@minute"/></xsl:if><xsl:if test="//events/event[@ID= //meta/showEvent/ID]/enddate/@minute &gt; 9"><xsl:value-of
                                                select="//events/event[@ID= //meta/showEvent/ID]/enddate/@minute"/></xsl:if></xsl:attribute>
                                    </input>
                                </td>
                                <td>Uhr</td>
                            </tr>
                        </table>
                    </div>
                    <hr style="width:90%; opacity:0.5;"/>
                    <div class="newEventFormDiv">
                            Ort:<br/>
                            <input type="text" name="eventLocation" style="width: 80%; margin-left: 0px;" disabled="disabled">
                                <xsl:attribute name="value"><xsl:value-of select="//events/event[@ID= //meta/showEvent/ID]/location"/></xsl:attribute>
                            </input> <br/>
                            Details:<br/>
                            <textarea form="showEventForm" style="margin-top: 5px; width: 80%; resize: none" name="eventDescription" rows="5" disabled="disabled">
                                <xsl:value-of select="//events/event[@ID= //meta/showEvent/ID]/description"/>
                            </textarea>
                        <br/>
                    </div>
					<div class="newEventButtonsDiv">
						<a>
                			<xsl:attribute name="href">/editEvent?eventID=<xsl:value-of select="//meta/showEvent/ID"/>&amp;<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/></xsl:attribute>
							<img src="/images/edit.svg" class="editIcon"/>
						</a>
					</div>
                </form>
            </div>
            <a>
                <xsl:attribute name="href">/?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/></xsl:attribute>
                <button class="closePopupButton">x</button>
            </a>
        </div>
    </xsl:template>
</xsl:stylesheet>
