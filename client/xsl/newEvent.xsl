<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
    <xsl:template match="newEventWindow">
        <div id="newEventWindowDiv" class="card">
            <h3 class="centeredText">Neuer Termin</h3>
            <div id="showEvent">
                <form id="newEventForm" name="newEventForm" method="post">
					<xsl:attribute name="action">/addEvent?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/></xsl:attribute>
                    <div class="newEventFormDiv">
                        Termin Name:<br/>
                        <input type="text" name="eventName" required="required"/> <br/>
                    </div>
                    <div class="newEventFormDiv">
                        <table>
                            <tr>
                                <td>Von</td>
                                <td><input type="date" name="eventStartDate" required="required">
                                    <xsl:attribute name="value"><xsl:value-of select="//week/currentDate/@year"/>-<xsl:if test="//week/currentDate/@month &gt; 9"><xsl:value-of select="//week/currentDate/@month"/></xsl:if><xsl:if test="//week/currentDate/@month &lt; 10">0<xsl:value-of select="//week/currentDate/@month"/></xsl:if>-<xsl:if test="//week/currentDate/@day &gt; 9"><xsl:value-of select="//week/currentDate/@day"/></xsl:if><xsl:if test="//week/currentDate/@day &lt; 10">0<xsl:value-of select="//week/currentDate/@day"/></xsl:if></xsl:attribute>
                                </input></td>
                                <td> um </td>
                                <td>
                                    <input type="time" name="eventStartTime" required="required">
                                        <xsl:attribute name="value"><xsl:if test="//week/currentDate/@hour &lt; 10">0<xsl:value-of
                                                select="//week/currentDate/@hour"/></xsl:if><xsl:if test="//week/currentDate/@hour &gt; 9"><xsl:value-of
                                                select="//week/currentDate/@hour"/></xsl:if>:<xsl:if test="//week/currentDate/@minute &lt; 10">0<xsl:value-of
                                                select="//week/currentDate/@minute"/></xsl:if><xsl:if test="//week/currentDate/@minute &gt; 9"><xsl:value-of
                                                select="//week/currentDate/@minute"/></xsl:if></xsl:attribute>
                                    </input>
                                </td>
                                <td>Uhr</td>
                            </tr>
                            <tr>
                                <td>Bis</td>
                                <td><input type="date" name="eventEndDate" required="required">
                                    <xsl:attribute name="value"><xsl:value-of select="//week/currentDate/@year"/>-<xsl:if test="//week/currentDate/@month &gt; 9"><xsl:value-of select="//week/currentDate/@month"/></xsl:if><xsl:if test="//week/currentDate/@month &lt; 10">0<xsl:value-of select="//week/currentDate/@month"/></xsl:if>-<xsl:if test="//week/currentDate/@day &gt; 9"><xsl:value-of select="//week/currentDate/@day"/></xsl:if><xsl:if test="//week/currentDate/@day &lt; 10">0<xsl:value-of select="//week/currentDate/@day"/></xsl:if></xsl:attribute>
                                </input></td>
                                <td> um </td>
                                <td>
                                    <input type="time" name="eventEndTime" required="required"/>
                                </td>
                                <td>Uhr</td>
                            </tr>
                        </table>
                    </div>
                    <hr/>
                    <div class="newEventFormDiv">
                        Ort:<br/>
                        <input type="text" name="eventLocation"/> <br/>
                        Details:<br/>
                        <textarea id="eventDescription" name="eventDescription" rows="5"/>
                        <br/>
                    </div>
                    <div class="newEventButtonsDiv">
                        <input type="submit" value="Zum Kalender hinzufügen"/>
                    </div>
                </form>
            </div>
            <a>
                <xsl:attribute name="href">/?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/></xsl:attribute>
                <button class="closePopupButton"><img src="/images/x_black.svg" alt="Schließen"/></button>
            </a>
        </div>
    </xsl:template>
</xsl:stylesheet>
