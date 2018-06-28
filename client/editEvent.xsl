<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
    <xsl:template match="editEventWindow">
        <div id="newEventWindowDiv" class="card">
            <h3 class="centeredText">Termin bearbeiten</h3>
            <div>
                <form id="editEventForm" method="post">
                    <xsl:attribute name="action">/editEvent?eventID=<xsl:value-of select="//meta/editEventWindow/ID"/></xsl:attribute>
                    <div class="newEventFormDiv">
                        Termin Name:<br/>
                        <input type="text" name="eventName" style="width: 80%; margin-left: 0px;" required="required">
                            <xsl:attribute name="value"><xsl:value-of select="//week/events/event[./ID= //meta/editEventWindow/ID]/name"/></xsl:attribute>
                        </input><br/>
                    </div>
                    <div class="newEventFormDiv">
                        <table>
                            <tr>
                                <td>Von</td>
                                <td><input type="date" name="eventStartDate" required="required">
                                    <xsl:attribute name="value"><xsl:value-of select="//week/events/event[./ID= //meta/editEventWindow/ID]/startDateYear"/>-<xsl:if test="//week/events/event[./ID= //meta/editEventWindow/ID]/startDateMonth &gt; 9"><xsl:value-of select="//week/events/event[./ID= //meta/editEventWindow/ID]/startDateMonth"/></xsl:if><xsl:if test="//week/events/event[./ID= //meta/editEventWindow/ID]/startDateMonth &lt; 10">0<xsl:value-of select="//week/events/event[./ID= //meta/editEventWindow/ID]/startDateMonth"/></xsl:if>-<xsl:if test="//week/events/event[./ID= //meta/editEventWindow/ID]/startDateDay &gt; 9"><xsl:value-of select="//week/events/event[./ID= //meta/editEventWindow/ID]/startDateDay"/></xsl:if><xsl:if test="//week/events/event[./ID= //meta/editEventWindow/ID]/startDateDay &lt; 10">0<xsl:value-of select="//week/events/event[./ID= //meta/editEventWindow/ID]/startDateDay"/></xsl:if></xsl:attribute>
                                </input></td>
                                <td> um </td>
                                <td>
                                    <input type="time" name="eventStartTime" required="required">
                                        <xsl:attribute name="value"><xsl:if test="//week/events/event[./ID= //meta/editEventWindow/ID]/startTimeHour &lt; 10">0<xsl:value-of
                                                select="//week/events/event[./ID= //meta/editEventWindow/ID]/startTimeHour"/></xsl:if><xsl:if test="//week/events/event[./ID= //meta/editEventWindow/ID]/startTimeHour &gt; 9"><xsl:value-of
                                                select="//week/events/event[./ID= //meta/editEventWindow/ID]/startTimeHour"/></xsl:if>:<xsl:if test="//week/events/event[./ID= //meta/editEventWindow/ID]/startTimeMinute &lt; 10">0<xsl:value-of
                                                select="//week/events/event[./ID= //meta/editEventWindow/ID]/startTimeMinute"/></xsl:if><xsl:if test="//week/events/event[./ID= //meta/editEventWindow/ID]/startTimeMinute &gt; 9"><xsl:value-of
                                                select="//week/events/event[./ID= //meta/editEventWindow/ID]/startTimeMinute"/></xsl:if></xsl:attribute>
                                    </input>
                                </td>
                                <td>Uhr</td>
                            </tr>
                            <tr>
                                <td>Bis</td>
                                <td><input type="date" name="eventEndDate" required="required" value="">
                                    <xsl:attribute name="value"><xsl:value-of select="//week/events/event[./ID= //meta/editEventWindow/ID]/endDateYear"/>-<xsl:if test="//week/events/event[./ID= //meta/editEventWindow/ID]/endDateMonth &gt; 9"><xsl:value-of select="//week/events/event[./ID= //meta/editEventWindow/ID]/endDateMonth"/></xsl:if><xsl:if test="//week/events/event[./ID= //meta/editEventWindow/ID]/endDateMonth &lt; 10">0<xsl:value-of select="//week/events/event[./ID= //meta/editEventWindow/ID]/endDateMonth"/></xsl:if>-<xsl:if test="//week/events/event[./ID= //meta/editEventWindow/ID]/endDateDay &gt; 9"><xsl:value-of select="//week/events/event[./ID= //meta/editEventWindow/ID]/endDateDay"/></xsl:if><xsl:if test="//week/events/event[./ID= //meta/editEventWindow/ID]/endDateDay &lt; 10">0<xsl:value-of select="//week/events/event[./ID= //meta/editEventWindow/ID]/endDateDay"/></xsl:if>
                                    </xsl:attribute>
                                </input></td>
                                <td> um </td>
                                <td>
                                    <input type="time" name="eventEndTime" required="required">
                                        <xsl:attribute name="value"><xsl:if test="//week/events/event[./ID= //meta/editEventWindow/ID]/endTimeHour &lt; 10">0<xsl:value-of
                                                select="//week/events/event[./ID= //meta/editEventWindow/ID]/endTimeHour"/></xsl:if><xsl:if test="//week/events/event[./ID= //meta/editEventWindow/ID]/endTimeHour &gt; 9"><xsl:value-of
                                                select="//week/events/event[./ID= //meta/editEventWindow/ID]/endTimeHour"/></xsl:if>:<xsl:if test="//week/events/event[./ID= //meta/editEventWindow/ID]/endTimeMinute &lt; 10">0<xsl:value-of
                                                select="//week/events/event[./ID= //meta/editEventWindow/ID]/endTimeMinute"/></xsl:if><xsl:if test="//week/events/event[./ID= //meta/editEventWindow/ID]/endTimeMinute &gt; 9"><xsl:value-of
                                                select="//week/events/event[./ID= //meta/editEventWindow/ID]/endTimeMinute"/></xsl:if></xsl:attribute>
                                    </input>
                                </td>
                                <td>Uhr</td>
                            </tr>
                        </table>
                    </div>
                    <hr style="width:90%; opacity:0.5;"/>
                    <div class="newEventFormDiv">
                            Ort:<br/>
                            <input type="text" name="eventLocation" style="width: 80%; margin-left: 0px;">
                                <xsl:attribute name="value"><xsl:value-of select="//week/events/event[./ID= //meta/editEventWindow/ID]/location"/></xsl:attribute>
                            </input> <br/>
                            Details:<br/>
                            <textarea form="editEventForm" style="margin-top: 5px; width: 80%; resize: none" name="eventDescription" rows="5">
                                <xsl:value-of select="//week/events/event[./ID= //meta/editEventWindow/ID]/description"/>
                            </textarea>
                        <br/>
                    </div>
                    <div class="newEventButtonsDiv">
                        <input type="submit" value="Termin ändern"/>
                    </div>
                </form>
            </div>
            <a>
                <xsl:attribute name="href">/?week=<xsl:value-of select="//meta/weekSelected"/></xsl:attribute>
                <button class="closePopupButton">x</button>
            </a>
        </div>
    </xsl:template>
</xsl:stylesheet>
