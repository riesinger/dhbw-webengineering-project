# Kalender 42

Dieses Projekt ist für den Kurs Webengineering I in TINF17B1.
Entwickelt wurde ein Kalender, welcher Daten im XML-Format von einem in NodeJS
geschriebenen Backend abruft und diese via XSLT in XML-Konformes HTML5 umwandelt.

## Installation

Zunächst müssen die beiden Programme "Node.js" und "NPM" installiert werden.
Unter Windows muss dafür lediglich die aktuellste Version von Node.js unter
[https://nodejs.org/](https://nodejs.org/en/) heruntergeladen und installiert werden.
Wichtig ist, dass nicht die sogenannte LTS-Version, sondern die aktuellste installiert wird (10.x.x).

Unter Linux muss häufig NPM getrennt von Node.js aus einem eigenen Paket installiert werden.
Dafür sollte die Dokumentation der jeweiligen Distribution zur Rate gezogen werden.

Für eine Installation unter macOS kann auch die aktuelle Version unter der oben gegebenen Adresse
heruntergeladen werden. Diese inkludiert NPM ebenfalls.

Sobald Node.js und NPM installiert sind, muss eine Kommandozeile im Quellcodeverzeichnis geöffnet werden.
Hier müssen mit dem Befehl `npm install` die Abhängigkeiten des Backends installiert werden.

Sobald alle Abhängigkeiten installiert sind, kann mit dem Befehl `node server.js` der Server
gestartet werden und der Kalender ist unter der Adresse `http://localhost:9991` erreichbar.
Der Server kann durch das Senden eines `SIGINT`-Signals gestoppt werden, dies geschieht häufig 
über die Tastenkombination `STRG+C`.

## Login

Um den Kalender nutzen zu können, muss man sich zunächst auf der Weboberfläche anmelden.
Falls dies noch nicht geschehen ist, wird man automatisch auf die Anmeldeseite weitergeleitet.

Für Testzwecke werden mit der Installation zwei Benutzerkonten mitgeliefert, welche die folgenden
Zugangsdaten haben:

Nutzername | Passwort
:---------:| :------:
test1      | 123456
test2      | 123456

## Sonstiges

Alle XML-Daten, welche von unserem Backend übermittelt werden sind über mitgelieferte DTDs validierbar.
Diese liegen im Unterverzeichnis `dtd/` und haben jeweils denselben Namen, wie das Root-Tag der Daten.

Alle Dateien, welche für das Frontend verwendet werden, liegen im Verzeichnis `client/`. Dies beinhaltet
sämtliche CSS-, Bild- und XSL-Ressourcen. Die XML-Daten, welche an das Frontend gesendet werden, werden
dynamisch generiert und sind nur über den Browser-Debugger zu sehen.
