<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" />
    
    <xsl:template match="month">
        <div>
            <div class="header fixed">
				<h1>Mein Kalender</h1>
				<h2>- <xsl:value-of select="firstDate/@day"/>.<xsl:value-of select="firstDate/@month"/>.
				bis <xsl:value-of select="lastDate/@day"/>.<xsl:value-of
					select="lastDate/@month"/>.</h2>
				<xsl:call-template name="navButtons"/>
			</div>
            <div class="calendar__header__legend__padding"/>
            <div class="grid-container">
                <xsl:call-template name="loop_div_days">
                    <xsl:with-param name="start" select="firstDate/@day"/>
                    <xsl:with-param name="stop" select="lastDate/@day"/>
                </xsl:call-template>
            </div>
            <xsl:for-each select="events/event">
                <xsl:apply-templates select="." mode="month"/>
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template name="loop_div_days">
        <xsl:param name="start"/>
        <xsl:param name="stop"/>
        <div class="grid-item">
            <div class="month-date">
                <xsl:value-of select="$start"/>.<xsl:value-of select="currentDate/@month"/>.
            </div>
        </div>
        <xsl:if test="($start+1)&lt;($stop+1)">
            <xsl:call-template name="loop_div_days">
                <xsl:with-param name="start" select="$start+1"/>
                <xsl:with-param name="stop" select="$stop"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>