<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
	<xsl:template match="showEvent">
		<div class="card">
			<h3 class="detailHeading">Details</h3>
			<table>
				<tr>
					<td>
						<b class="detailLabel">Name:</b>
					</td>
					<td>
						<xsl:value-of select="//events/event[./ID= //meta/showEvent/ID]/name"/>
					</td>
				</tr>
				<tr>
					<td>
						<b class="detailLabel">Beschreibung:</b>
					</td>
					<td>
						<xsl:value-of select="//events/event[./ID= //meta/showEvent/ID]/description"/>
					</td>
				</tr>
				<tr>
					<td>
						<b class="detailLabel">Lokation:</b>
					</td>
					<td>
						<xsl:value-of select="//events/event[./ID= //meta/showEvent/ID]/location"/>
					</td>
				</tr>
				<tr>
					<td>
						<b class="detailLabel">Startdatum:</b>
					</td>
					<td>
						<xsl:value-of select="//events/event[./ID= //meta/showEvent/ID]/startDate/@day"/>.<xsl:value-of select="//events/event[./ID= //meta/showEvent/ID]/startDate/@month"/>.<xsl:value-of select="//events/event[./ID= //meta/showEvent/ID]/startDateYear"/>
					</td>
				</tr>
				<tr>
					<td>
						<b class="detailLabel">Startzeit:</b>
					</td>
					<td>
						<xsl:value-of select="//events/event[./ID= //meta/showEvent/ID]/startDate/@hour"/>:<xsl:value-of select="//events/event[./ID= //meta/showEvent/ID]/startDate/@minute"/>
					</td>
				</tr>
				<tr>
					<td>
						<b class="detailLabel">Enddatum:</b>
					</td>
					<td>
						<xsl:value-of select="//events/event[./ID= //meta/showEvent/ID]/endDate/@day"/>.<xsl:value-of select="//events/event[./ID= //meta/showEvent/ID]/endDate/@month"/>.<xsl:value-of select="//events/event[./ID= //meta/showEvent/ID]/endDateYear"/>
					</td>
				</tr>
				<tr>
					<td>
						<b class="detailLabel">Endzeit:</b>
					</td>
					<td>
						<xsl:value-of select="//events/event[./ID= //meta/showEvent/ID]/endDate/@hour"/>:<xsl:value-of select="//events/event[./ID= //meta/showEvent/ID]/endDate/@minute"/>
					</td>
				</tr>
			</table>
			<a>
				<xsl:attribute name="href">/?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/></xsl:attribute>
				<button class="closePopupButton">x</button>
			</a>
		</div>
	</xsl:template>
</xsl:stylesheet>