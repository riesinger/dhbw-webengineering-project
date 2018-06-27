<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
    <xsl:template match="addRemote">
		<div class="card addRemote">
			<h1>Remote Kalender hinzufügen</h1>
			<form action="/addRemote" method="POST">
					<input type="text" name="url" placeholder="URL"/><br/>
					<input type="submit" value="Hinzufügen"/>
			</form>
			<h1>RAPLA hinzufügen</h1>
			<form action="/addRemote" method="POST">
				<input type="text" name="url" placeholder="URL"/><br/>
				<div class="alignLeft">
					<input type="checkbox" name="anwendungsprojekt"/>Anwendungsprojekt<br/>
					<input type="checkbox" name="medizin"/>Medizin<br/>
					<input type="checkbox" name="webengineering"/>Web-Engineering<br/>
					<input type="checkbox" name="marketing"/>Marketing<br/>
					<input type="checkbox" name="ccna"/>CCNA<br/>
					<input type="checkbox" name="interculturalComm1"/>Intercultural Communication I<br/>
					<input type="checkbox" name="interculturalComm2"/>Intercultural Communication II<br/>
				</div>
				<input type="submit" value="Hinzufügen"/>
			</form>
			<a href="/">
        <button class="closePopupButton">x</button>
      </a>
		</div>
	</xsl:template>
</xsl:stylesheet>
