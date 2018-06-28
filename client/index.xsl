<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
								xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
								xmlns="http://www.w3.org/1999/xhtml">

	<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN"
							doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>

	<xsl:include href="newEvent.xsl"/>
	<xsl:include href="details.xsl"/>
	<xsl:include href="editEvent.xsl"/>
	<xsl:include href="week.xsl"/>
	<xsl:include href="day.xsl"/>
	<xsl:include href="navButtons.xsl"/>
	<xsl:include href="event.xsl"/>

	<xsl:template match="/">
		<html lang="de" xml:lang="de" xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<link rel="stylesheet" type="text/css" href="/css/main.css"/>
				<link rel="stylesheet" type="text/css" href="/css/calendar.css"/>
				<link rel="stylesheet" type="text/css" href="/css/eventDetail.css"/>
				<link rel="stylesheet" type="text/css" href="/css/addRemote.css"/>
				<link rel="stylesheet" type="text/css" href="/css/event.css"/>
				<link href="https://fonts.googleapis.com/css?family=Roboto:400,500" rel="stylesheet"/>
				<link rel="shortcut icon" type="image/png" href="/images/icon.png"/>
				<title>Kalender vom <xsl:value-of select="//firstDateDay"/>.<xsl:value-of select="//firstDateMonth"/>.
					bis <xsl:value-of select="//lastDateDay"/>.<xsl:value-of
						select="//lastDateMonth"/>.
				</title>

			</head>
			<body>
				
				<xsl:apply-templates select="/calendar"/>

				<div>
					<a>
						<xsl:attribute name="href">\newEvent?<xsl:value-of select="//meta/dispForm"/>=<xsl:value-of select="//meta/dateOffset"/></xsl:attribute>
						<button type="button" class="addButton">+</button>
					</a>
				</div>

				<xsl:apply-templates select="//meta/*"/>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
