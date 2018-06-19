<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="/css/main.css"/>
			</head>
			<body>
				<header>
					<h1>Mein Kalender</h1>
				</header>
				<h5>
					<xsl:value-of select="week/curDateDay"/>
				</h5>
				<h5>
					<xsl:value-of select="week/curDateMonth"/>
				</h5>
				<table>
					<thead>
						<tr>
							<th>Zeit</th>
							<th>Montag</th>
							<th>Dienstag</th>
							<th>Mittwoch</th>
							<th>Donnerstag</th>
							<th>Freitag</th>
							<th>Samstag</th>
							<th>Sonntag</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>00:00</td>
							<td>
								<xsl:for-each select="week/events/event">
									<xsl:if test="startTimeHour &eq; 0"></xsl:if>
								</xsl:for-each>
							</td>
						</tr>
						<tr>
							<td>00:30</td>
						</tr>
						<tr>
							<td>01:00</td>
						</tr>
					</tbody>
				</table>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
