<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
    <xsl:template match="newEventWindow">
        <div id="newEventWindowDiv" class="card">
            <h3 class="centeredText">Neuer Termin</h3>
            <div>
                <form id="newEventForm" action="/addEvent" method="post">
                    <div class="newEventFormDiv">
                        Termin Name:<br/>
                        <input type="text" name="eventName" style="width: 80%; margin-left: 0px;" required="required"/> <br/>
                    </div>
                    <div class="newEventFormDiv">
                        <table>
                            <tr>
                                <td>Von</td>
                                <td><input type="date" name="eventStartDate" required="required">
                                    <xsl:attribute name="value"><xsl:value-of select="//week/currentDateYear"/>-<xsl:if test="//week/currentDateMonth &gt; 9"><xsl:value-of select="//week/currentDateMonth"/></xsl:if><xsl:if test="//week/currentDateMonth &lt; 10">0<xsl:value-of select="//week/currentDateMonth"/></xsl:if>-<xsl:if test="//week/currentDateDay &gt; 9"><xsl:value-of select="//week/currentDateDay"/></xsl:if><xsl:if test="//week/currentDateDay &lt; 10">0<xsl:value-of select="//week/currentDateDay"/></xsl:if></xsl:attribute>
                                </input></td>
                                <td> um </td>
                                <td>
                                    <input type="time" name="eventStartTime" required="required">
                                        <xsl:attribute name="value"><xsl:if test="//week/currentDateHour &lt; 10">0<xsl:value-of
                                                select="//week/currentDateHour"/></xsl:if><xsl:if test="//week/currentDateHour &gt; 9"><xsl:value-of
                                                select="//week/currentDateHour"/></xsl:if>:<xsl:if test="//week/currentDateMinute &lt; 10">0<xsl:value-of
                                                select="//week/currentDateMinute"/></xsl:if><xsl:if test="//week/currentDateMinute &gt; 9"><xsl:value-of
                                                select="//week/currentDateMinute"/></xsl:if></xsl:attribute>
                                    </input>
                                </td>
                                <td>Uhr</td>
                            </tr>
                            <tr>
                                <td>Bis</td>
                                <td><input type="date" name="eventEndDate" required="required">
                                    <xsl:attribute name="value"><xsl:value-of select="//week/currentDateYear"/>-<xsl:if test="//week/currentDateMonth &gt; 9"><xsl:value-of select="//week/currentDateMonth"/></xsl:if><xsl:if test="//week/currentDateMonth &lt; 10">0<xsl:value-of select="//week/currentDateMonth"/></xsl:if>-<xsl:if test="//week/currentDateDay &gt; 9"><xsl:value-of select="//week/currentDateDay"/></xsl:if><xsl:if test="//week/currentDateDay &lt; 10">0<xsl:value-of select="//week/currentDateDay"/></xsl:if></xsl:attribute>
                                </input></td>
                                <td> um </td>
                                <td>
                                    <input type="time" name="eventEndTime" required="required"/>
                                </td>
                                <td>Uhr</td>
                            </tr>
                        </table>
                    </div>
                    <hr style="width:90%; opacity:0.5;"/>
                    <div class="newEventFormDiv">
                        Ort:<br/>
                        <input type="text" name="eventLocation" style="width: 80%; margin-left: 0px;"/> <br/>
                        Details:<br/>
                        <textarea form="newEventForm" style="margin-top: 5px; width: 80%; resize: none" name="eventDescription" rows="5"/>
                        <br/>
                    </div>
                    <div class="newEventButtonsDiv">
                        <input type="submit" value="Zum Kalender hinzufügen"/>
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
