<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
    <xsl:template match="event" mode="event_details">
        <div class="event_details">
            <h3 class="detail_heading">Details</h3>
            <b>ID: </b><xsl:value-of select="ID"/><br/>
            <b>Name: </b><xsl:value-of select="name"/><br/>
            <b>Beschreibung: </b><xsl:value-of select="description"/><br/>
            <b>Lokation: </b><xsl:value-of select="location"/><br/>
            <b>Startdatum: </b><xsl:value-of select="startDateDay"/>.<xsl:value-of select="startDateMonth"/>.<xsl:value-of select="startDateYear"/><br/>
            <b>Startzeit: </b><xsl:value-of select="startTimeHour"/>:<xsl:value-of select="startTimeMinute"/><br/>
            <b>Enddatum: </b><xsl:value-of select="endDateDay"/>.<xsl:value-of select="endDateMonth"/>.<xsl:value-of select="endDateYear"/><br/>
            <b>Endzeit: </b><xsl:value-of select="endTimeHour"/>:<xsl:value-of select="endTimeMinute"/><br/>
        </div>
    </xsl:template>
</xsl:stylesheet>