<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.1//EN"
	            doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>

	<xsl:template match="month">
		<div class="month-container">
			<div class="header fixed">
				<h1>Kalender 42</h1>
				<h2>- <xsl:value-of select="firstDate/@day"/>.<xsl:value-of select="firstDate/@month"/>.
					bis <xsl:value-of select="lastDate/@day"/>.<xsl:value-of
						select="lastDate/@month"/>.
				</h2>
				<xsl:call-template name="navButtons"/>
			</div>
			<div class="calendar__header__legend__padding"/>
			<div class="calendar__header" style="padding-left: 10px; padding-right: 10px;">
				<h3>Montag</h3>
				<h3>Dienstag</h3>
				<h3>Mittwoch</h3>
				<h3>Donnerstag</h3>
				<h3>Freitag</h3>
				<h3>Samstag</h3>
				<h3>Sonntag</h3>
			</div>
			<div class="calendar__body month">

				<div class="grid-container">
					<xsl:call-template name="loop_placeholders">
						<xsl:with-param name="start" select="0"/>
						<xsl:with-param name="stop" select="(firstDate/@dow)-1"/>
					</xsl:call-template>
					<xsl:call-template name="loop_div_days">
						<xsl:with-param name="start" select="firstDate/@day"/>
						<xsl:with-param name="stop" select="lastDate/@day"/>
					</xsl:call-template>
				</div>

			</div>
		</div>
	</xsl:template>

	<xsl:template name="loop_placeholders">
		<xsl:param name="start"/>
		<xsl:param name="stop"/>
		<xsl:if test="$start!=$stop">
			<div class="placeholder"/>
			<xsl:if test="($start+1)&lt;($stop+1)">
				<xsl:call-template name="loop_placeholders">
					<xsl:with-param name="start" select="$start+1"/>
					<xsl:with-param name="stop" select="$stop"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template name="loop_div_days">
		<xsl:param name="start"/>
		<xsl:param name="stop"/>
		<div class="grid-item">
			<xsl:if test="$start=currentDate/@day and firstDate/@month=currentDate/@month">
				<xsl:attribute name="class">
					grid-item-today
				</xsl:attribute>
			</xsl:if>
			<div class="month-date">
				<xsl:value-of select="$start"/>.<xsl:value-of select="firstDate/@month"/>.
			</div>
			<xsl:for-each select="events/event[startdate/@day=$start]">
				<a class="month-anchor">
					<xsl:attribute name="href">/showEvent?eventID=<xsl:value-of select="@ID"/>&amp;<xsl:value-of
						select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/>
					</xsl:attribute>
					<div class="month-event">
						<xsl:value-of select="name"/>
						<a>
							<xsl:attribute name="href">/deleteEvent?eventID=<xsl:value-of select="@ID"/>&amp;<xsl:value-of
								select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/>
							</xsl:attribute>
							<img class="event-icon-month" src="/images/trash_white.svg" alt="Ereignis löschen"/>
						</a>
					</div>
				</a>
			</xsl:for-each>
		</div>
		<xsl:if test="($start+1)&lt;($stop+1)">
			<xsl:call-template name="loop_div_days">
				<xsl:with-param name="start" select="$start+1"/>
				<xsl:with-param name="stop" select="$stop"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>