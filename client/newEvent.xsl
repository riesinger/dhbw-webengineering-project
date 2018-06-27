<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
    <xsl:template match="/" mode="event_new">
        <div id="newEventWindowDiv" class="card">
            <h3 class="centeredText">Neuer Termin</h3>
            <div>
                <form id="newEventForm" action="/addEvent" method="post">
                    <div class="newEventFormDiv">
                        Termin Name:<br/>
                        <input type="text" name="eventName" style="width: 80%"/> <br/>
                        <textarea form="newEventForm" style="margin-top: 5px; width: 80%; resize: none" name="eventDescription" rows="4">Beschreibung</textarea> <br/>
                    </div>
                    <hr style="width:90%; opacity:0.5;"/>
                    <div class="newEventFormDiv">
                        Von <input type="date" name="eventStartDate"/> <input type="time" name="eventStartTime"/> Uhr<br/>
                        Bis <input type="date" name="eventEndDate"/> <input type="time" name="eventEndTime"/> Uhr<br/>
                    </div>
                    <hr style="width:90%; opacity:0.5;"/>
                    <div class="newEventFormDiv">
                        Ort:<br/>
                        <input type="text" name="eventLocation" style="width: 80%"/>
                    </div>
                    <div class="newEventButtonsDiv">
                        <input type="submit" value="Zum Kalender hinzufügen"/>
                    </div>
                </form>
            </div>
            <a href="/">
                <button class="closePopupButton">x</button>
            </a>
        </div>
    </xsl:template>
</xsl:stylesheet>
