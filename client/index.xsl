<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="/css/main.css"/>
				<link rel="stylesheet" type="text/css" href="/css/calendar.css"/>
			</head>
			<body>
				<header>
					<h1>Mein Kalender</h1>
				</header>
				<div class="calendar">
					<div class="calendar__legend">
						<div>00:00</div>
						<div>01:00</div>
						<div>02:00</div>
						<div>03:00</div>
						<div>04:00</div>
						<div>05:00</div>
						<div>06:00</div>
						<div>07:00</div>
						<div>08:00</div>
						<div>09:00</div>
						<div>10:00</div>
						<div>11:00</div>
						<div>12:00</div>
						<div>13:00</div>
						<div>14:00</div>
						<div>15:00</div>
						<div>16:00</div>
						<div>17:00</div>
						<div>18:00</div>
						<div>19:00</div>
						<div>20:00</div>
						<div>21:00</div>
						<div>22:00</div>
						<div>23:00</div>
					</div>
					<div class="calendar__days">
						<div class="calendar__day">
							<h3>Montag</h3>
							<div class="calendar__events">
								<div class="calendar__event starts_0_00 length_0_30">Ausflug mit TINF17B1</div>
							</div>
						</div>
						<div class="calendar__day">
							<h3>Dienstag</h3>
							<div class="calendar__events">
								<div class="calendar__event starts_0_00 length_1_30">Ausflug mit TINF17B1</div>
							</div>
						</div>
						<div class="calendar__day">
							<h3>Mittwoch</h3>
							<div class="calendar__events">
								<div class="calendar__event starts_5_30 length_8_45">Ausflug mit TINF17B1</div>
							</div>
						</div>
						<div class="calendar__day">
							<h3>Donnerstag</h3>
							<div class="calendar__events">
								<div class="calendar__event starts_0_00 length_23_30">Ausflug mit TINF17B1</div>
							</div>
						</div>
						<div class="calendar__day">
							<h3>Freitag</h3>
							<div class="calendar__events">
								<div class="calendar__event starts_10_30 length_1_00">Ausflug mit TINF17B1</div>
							</div>
						</div>
						<div class="calendar__day">
							<h3>Samstag</h3>
							<div class="calendar__events">
								<div class="calendar__event starts_20_30 length_0_30">Ausflug mit TINF17B1</div>
							</div>
						</div>
						<div class="calendar__day">
							<h3>Sonntag</h3>
							<div class="calendar__events">
								<div class="calendar__event starts_20_45 length_0_30">Ausflug mit TINF17B1</div>
							</div>
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
