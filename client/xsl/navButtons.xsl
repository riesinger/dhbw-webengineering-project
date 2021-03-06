<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
	<xsl:template match="/" name="navButtons">
		<div class="buttons">
			<xsl:element name="a">
				<xsl:if test="//meta/dispForm = 'day'">
					<xsl:attribute name="class">dispButton selected</xsl:attribute>
				</xsl:if>
				<xsl:if test="not(//meta/dispForm = 'day')">
					<xsl:attribute name="class">dispButton</xsl:attribute>
				</xsl:if>
				<xsl:attribute name="href">/?day=0</xsl:attribute>
				Tag
			</xsl:element>
			<xsl:element name="a">
				<xsl:if test="//meta/dispForm = 'week'">
					<xsl:attribute name="class">dispButton selected</xsl:attribute>
				</xsl:if>
				<xsl:if test="not(//meta/dispForm = 'week')">
					<xsl:attribute name="class">dispButton</xsl:attribute>
				</xsl:if>
				<xsl:attribute name="href">/?week=0</xsl:attribute>
				Woche
			</xsl:element>
			<xsl:element name="a">
				<xsl:if test="//meta/dispForm = 'month'">
					<xsl:attribute name="class">dispButton selected</xsl:attribute>
				</xsl:if>
				<xsl:if test="not(//meta/dispForm = 'month')">
					<xsl:attribute name="class">dispButton</xsl:attribute>
				</xsl:if>
				<xsl:attribute name="href">/?month=0</xsl:attribute>
				Monat
			</xsl:element>
			<a title="Zurück" class="navArrow">
				<xsl:attribute name="href">\?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset - 1"/></xsl:attribute>
				<img src="/images/arrow_left_white.svg" alt="Zurück blättern"/>
			</a>
			<a title="Weiter" class="navArrow"	>
				<xsl:attribute name="href">\?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset + 1"/></xsl:attribute>
				<img src="/images/arrow_right_white.svg" alt="Vorwärts blättern"/>
			</a>
			<a title="HowTo" href="/howto" class="howtoButton">
				<img src="/images/question_white.svg" alt="HowTo"/>
			</a>
			<a title="Ausloggen" href="/logout" class="logoutButton">
				<img src="/images/logout_white.svg" alt="Ausloggen"/>
			</a>
		</div>
	</xsl:template>
</xsl:stylesheet>