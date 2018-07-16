<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
    <xsl:template match="newEvent">
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
                        <input type="checkbox" id="allDayEvent" name="allDayEvent"/>Ganztägiges Event
                    </div>
                    <div class="newEventFormDiv">
                        <table>
                            <tr>
                                <td>Am</td>
                                <td><input type="date" name="eventStartDate" required="required">
                                    <xsl:attribute name="value"><xsl:value-of select="//*/currentDate/@year"/>-<xsl:if test="//*/currentDate/@month &gt; 9"><xsl:value-of select="//*/currentDate/@month"/></xsl:if><xsl:if test="//*/currentDate/@month &lt; 10">0<xsl:value-of select="//*/currentDate/@month"/></xsl:if>-<xsl:if test="//*/currentDate/@day &gt; 9"><xsl:value-of select="//*/currentDate/@day"/></xsl:if><xsl:if test="//*/currentDate/@day &lt; 10">0<xsl:value-of select="//*/currentDate/@day"/></xsl:if></xsl:attribute>
                                </input></td>
                                <td>von</td>
                                <td>
                                    <input type="time" name="eventStartTime">
                                        <xsl:attribute name="value"><xsl:if test="//*/currentDate/@hour &lt; 10">0<xsl:value-of
                                                select="//*/currentDate/@hour"/></xsl:if><xsl:if test="//*/currentDate/@hour &gt; 9"><xsl:value-of
                                                select="//*/currentDate/@hour"/></xsl:if>:<xsl:if test="//*/currentDate/@minute &lt; 10">0<xsl:value-of
                                                select="//*/currentDate/@minute"/></xsl:if><xsl:if test="//*/currentDate/@minute &gt; 9"><xsl:value-of
                                                select="//*/currentDate/@minute"/></xsl:if></xsl:attribute>
                                    </input>
                                </td>
                                <td>Uhr</td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>bis</td>
                                <td>
                                    <input type="time" name="eventEndTime"/>
                                </td>
                                <td>Uhr</td>
                            </tr>
                        </table>
                        <br/>
                        <table>
                            <tr>
                                <td>Wiederhole</td>
                                <td><input type="number" name="reoccuringTimes" value="0"></input></td>
                                <td><select name="reoccuringType">
                                    <option value="day">Tage</option>
                                    <option value="week">Wochen</option>
                                </select></td>
                            </tr>
                        </table>
                    </div>
                    <hr/>
                    <div class="newEventFormDiv">
                        Ort:<br/>
                        <input type="text" name="eventLocation"/> <br/>
                        Details:<br/>
                        <textarea id="eventDescription" name="eventDescription"/>
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
