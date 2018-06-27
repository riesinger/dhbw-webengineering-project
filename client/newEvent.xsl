<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" encoding="UTF-8"/>
    <xsl:template match="newEventWindow">
        <div id="newEventWindowDiv" class="card">
            <h3 class="centeredText">Neuer Termin</h3>
            <div>
                <form id="newEventForm" action="/addEvent" method="post">
                    <div class="newEventFormDiv">
                        Termin Name:<br/>
                        <input type="text" name="eventName" style="width: 80%; margin-left: 0px;" required="required"/> <br/>
                    </div>
                    <div class="newEventFormDiv">
                        <table>
                            <tr>
                                <td>Von</td>
                                <td><input type="date" name="eventStartDate" required="required"/></td>
                                <td> um </td>
                                <td>
                                    <select name="eventStartTimeHour" form="newEventForm">
                                        <option value="0">0</option>
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                        <option value="9">9</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                        <option value="21">21</option>
                                        <option value="22">22</option>
                                        <option value="23">23</option>
                                    </select>
                                </td>
                                <td>:</td>
                                <td>
                                    <select name="eventStartTimeMinute" form="newEventForm">
                                        <option value="0">00</option>
                                        <option value="15">15</option>
                                        <option value="30">30</option>
                                        <option value="45">45</option>
                                    </select>
                                </td>
                                <td>Uhr</td>
                            </tr>
                            <tr>
                                <td>Bis</td>
                                <td><input type="date" name="eventEndDate" required="required"/></td>
                                <td> um </td>
                                <td>
                                    <select name="eventEndTimeHour" form="newEventForm">
                                        <option value="0">0</option>
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                        <option value="9">9</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                        <option value="21">21</option>
                                        <option value="22">22</option>
                                        <option value="23">23</option>
                                    </select>
                                </td>
                                <td>:</td>
                                <td>
                                    <select name="eventEndTimeMinute" form="newEventForm">
                                        <option value="0">00</option>
                                        <option value="15">15</option>
                                        <option value="30">30</option>
                                        <option value="45">45</option>
                                    </select>
                                </td>
                                <td>Uhr</td>
                            </tr>
                        </table>
                    </div>
                    <hr style="width:90%; opacity:0.5;"/>
                    <div class="newEventFormDiv">
                        Ort:<br/>
                        <input type="text" name="eventLocation" style="width: 80%; margin-left: 0px;"/> <br/>
                        Details:<br/>
                        <textarea form="newEventForm" style="margin-top: 5px; width: 80%; resize: none" name="eventDescription" rows="5"/><br/>
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
