<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
    <xsl:template match="event" mode="showEvent">
        <div class="eventDetails">
            <h3 class="detailHeading">Details</h3>
            <table>
                <tr>
                    <td>
                        <b class="detailLabel">Name:</b>
                    </td>
                    <td>
                        <xsl:value-of select="name"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b class="detailLabel">Beschreibung:</b>
                    </td>
                    <td>
                        <xsl:value-of select="description"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b class="detailLabel">Lokation:</b>
                    </td>
                    <td>
                        <xsl:value-of select="location"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b class="detailLabel">Startdatum:</b>
                    </td>
                    <td>
                        <xsl:value-of select="startDateDay"/>.<xsl:value-of select="startDateMonth"/>.<xsl:value-of select="startDateYear"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b class="detailLabel">Startzeit:</b>
                    </td>
                    <td>
                        <xsl:value-of select="startTimeHour"/>:<xsl:value-of select="startTimeMinute"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b class="detailLabel">Enddatum:</b>
                    </td>
                    <td>
                        <xsl:value-of select="endDateDay"/>.<xsl:value-of select="endDateMonth"/>.<xsl:value-of select="endDateYear"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b class="detailLabel">Endzeit:</b>
                    </td>
                    <td>
                        <xsl:value-of select="endTimeHour"/>:<xsl:value-of select="endTimeMinute"/>
                    </td>
                </tr>
            </table>
        </div>
    </xsl:template>
</xsl:stylesheet>