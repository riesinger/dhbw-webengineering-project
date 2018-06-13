<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
  <body>
  <h5><xsl:value-of select="week/curDateDay"/></h5>
  <h5><xsl:value-of select="week/curDateMonth"/></h5>
  <table>
    <tr>
      <th>Name</th>
      <th>Description</th>
      <th>Location</th>
      <th>startDateDay</th>
      <th>startDateMonth</th>
      <th>startDateYear</th>
      <th>startTimeHour</th>
      <th>startTimeMinute</th>
      <th>endDateDay</th>
      <th>endDateMonth</th>
      <th>endDateYear</th>
      <th>endTimeHour</th>
      <th>endTimeMinute</th>
    </tr>
    <xsl:for-each select="week/events/event">
    <tr>
      <td><xsl:value-of select="name"/></td>
      <td><xsl:value-of select="description"/></td>
      <td><xsl:value-of select="location"/></td>
      <td><xsl:value-of select="startDateDay"/></td>
      <td><xsl:value-of select="startDateMonth"/></td>
      <td><xsl:value-of select="startDateYear"/></td>
      <td><xsl:value-of select="startTimeHour"/></td>
      <td><xsl:value-of select="startTimeMinute"/></td>
      <td><xsl:value-of select="endDateDay"/></td>
      <td><xsl:value-of select="endDateMonth"/></td>
      <td><xsl:value-of select="endDateYear"/></td>
      <td><xsl:value-of select="endTimeHour"/></td>
      <td><xsl:value-of select="endTimeMinute"/></td>
    </tr>
    </xsl:for-each>
  </table>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>
