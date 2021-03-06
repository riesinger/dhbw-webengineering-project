<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml">

	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN"
	            doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
	<xsl:strip-space elements="*"/>

	<xsl:include href="newEvent.xsl"/>
	<xsl:include href="details_edit.xsl"/>
	<xsl:include href="month.xsl"/>
	<xsl:include href="week.xsl"/>
	<xsl:include href="day.xsl"/>
	<xsl:include href="navButtons.xsl"/>
	<xsl:include href="event.xsl"/>
	<xsl:include href="emptyTemplates.xsl"/>
	<xsl:include href="error.xsl"/>
	<xsl:include href="howto.xsl"/>

	<xsl:template match="/">
		<html lang="de" xml:lang="de" xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<meta name="viewport" content="width=device-width"/>
				<meta name="theme-color" content="#2979FF"/>
				<link rel="stylesheet" type="text/css" href="/css/main.css"/>
				<link rel="stylesheet" type="text/css" href="/css/calendar.css"/>
				<link rel="stylesheet" type="text/css" href="/css/eventDetail.css"/>
				<link rel="stylesheet" type="text/css" href="/css/addRemote.css"/>
				<link rel="stylesheet" type="text/css" href="/css/red.css" title="Rot"/>
				<link rel="stylesheet" type="text/css" href="/css/monthView.css"/>
				<link rel="stylesheet" type="text/css" href="/css/howto.css"/>
				<link rel="alternate stylesheet" type="text/css" href="/css/blue.css" title="Blau"/>
				<link href="https://fonts.googleapis.com/css?family=Roboto:400,500" rel="stylesheet"/>
				<link rel="shortcut icon" type="image/png" href="/images/icon.png"/>
				<title>
					<xsl:text>Kalender vom </xsl:text>
					<xsl:value-of select="//firstDate/@day"/>
					<xsl:text>.</xsl:text>
					<xsl:value-of select="//firstDate/@month"/>
					<xsl:text>. bis </xsl:text>
					<xsl:value-of select="//lastDate/@day"/>
					<xsl:text>.</xsl:text>
					<xsl:value-of select="//lastDate/@month"/>
					<xsl:text>.</xsl:text>
				</title>

			</head>
			<body>

				<xsl:apply-templates select="/calendar"/>

				<div>
					<a>
						<xsl:attribute name="href">
							<xsl:text>\newEvent?</xsl:text>
							<xsl:value-of select="//meta/dispForm"/>
							<xsl:text>=</xsl:text>
							<xsl:value-of select="//meta/dateOffset"/>
						</xsl:attribute>
						<img src="images/plus_white.svg" class="addButton" alt="Event hinzufügen"/>
					</a>
				</div>

				<xsl:apply-templates select="//meta/*"/>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
