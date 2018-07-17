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
Hier müssen mit dem Befehl `npm install` die Abhängigkeiten des Backends installiert werden. Diese 
Abhängigkeiten beschränken sich im wesentliche auf zwei Module: `xml2js` übernimmt das umwandeln
von XML in JavaScript-Objekte und umgekehrt, `express` dient als Router. Für `express` sind noch zwei
weitere Addons eingebunden, `body-parser` und `cookie-parser`, welche es ermöglichen, den Body von HTTP-Requests
auszuwerten (POST) und Cookies zu verwalten. Für die Entwicklung wurde noch ein weiteres Modul verwendet,
welches den Server automatisch neu startet, sobald sich der Quellcode ändert.
Bei der Installation unter Windows und Linux wird es zu einer Warnung ähnlich 

```sh
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.4 (node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.4: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})
```

kommen. Diese können getrost ignoriert werden, da `fsevents` nur eine optionale Abhängigkeit von `express` darstellt.

Sobald alle Abhängigkeiten installiert sind, kann mit dem Befehl `node server.js` der Server
gestartet werden und der Kalender ist unter der Adresse `http://localhost:9991` erreichbar.
Der Server kann durch das Senden eines `SIGINT`-Signals gestoppt werden, dies geschieht häufig 
über die Tastenkombination `STRG+C`.

## Login

Um den Kalender nutzen zu können, muss man sich zunächst auf der Weboberfläche anmelden.
Falls dies noch nicht geschehen ist, wird man automatisch auf die Anmeldeseite weitergeleitet.

Für Testzwecke werden mit der Installation zwei Benutzerkonten mitgeliefert, welche die folgenden
Zugangsdaten haben:

Nutzername | Passwort | Hash
:-------------:| :------: | :-------------------------------:
Max Mustermann | 123456   | e10adc3949ba59abbe56e057f20f883e
test           | 123456   | e10adc3949ba59abbe56e057f20f883e

## Erläuterungen zum Backend

Im folgenden Abschnitt wird grob die Funktionalität des Backends und warum diese nötig sind erläutert.
Das Backend hat drei grundlegende Funktionalitäten: User Management, Herausfiltern der anzuzeigenden Events und behandeln von verschiedenen URLs.

Das User Management beschränkt sich auf eine simple Authentifizierung von Benutzern und das Erstellen/Tracken von Sessions.
Die Authentifizierung funktioniert über eine Post-Request aus dem Frontend. In dieser werden Benutzername und Password mit Hilfe der `users.xml` Datei validiert und dann ein Token erstellt.
Dieser Token wird einmal in der `users.xml` Datei gespeichert und als Cookie and den Browser gesendet.
Bei jeder weiteren Anfrage kann durch den Cookie der Username und die Validität der Anfrage überprüft werden.
Dieser Teil ist sehr wichtig, um mehrere User zu unterstützen, da dies, vor allem mit Authentifizierung, in purem XSLT/HTML nicht möglich ist.

Beim Herausfiltern der anzuzeigenden Events sind hauptsächlich drei Aspekte wichtig: Der anfordernde User, die angeforderte Ansicht und der "Offset" der angeforderten Sicht.
Bei jeder Anfrage sind diese Daten vorhanden. Der Username kommt dabei aus dem Authentifizierungssystem, der Rest über GET-Parameter. Per default wird die Wochenansicht mit einem Offset von 0 Wochen gewählt.
Sollte das Backend eine Weiterleitung machen, so werden diese GET-Parameter an die URL der Weiterleitung angehängt.
Das tatsächliche Herausfiltern der Events wird dann aus der Kalender XML-Datei des Users und dem angeforderten Zeitraum gemacht. Dies ist nötig, da in XSLT das aktuelle Datum nicht abrufbar ist.
Deshalt wird das akutelle Datum und Uhrzeit in das genertierte XML auch eingefügt.
Je nachdem, welche Darstellungsform angefordert wurde, wird ein entsprechendes XML Tag verwendet. Dadurch kann im XSLT auf den Namen der Darstellungsform gematcht werden.

Verschiedene URLs werden über verschiedene Handler abgearbeitet. Dadurch kann in den `meta` Tag des generierten XML (neben dem angeforderten Kalender) unterschiedliche Daten geschrieben werden.
Zum Beispiel bei der relativen URL `/newEvent` wird dem XML der Tag `newEvent` hinzugefügt. Im Frontend wird auf dieses Tag gematcht und das entsprechende Popup angezeigt.
Verwendet wird diese Technik, damit mit relativ geringem Aufwand immer das selbe XSLT Template verwendet werden kann.
Dies gestaltet die Programmierung relativ dynamisch.

## Sonstiges

Alle XML-Daten, welche von unserem Backend übermittelt werden sind über mitgelieferte DTDs validierbar.
Diese liegen im Unterverzeichnis `dtd/` und haben jeweils denselben Namen, wie das Root-Tag der Daten.
Ausnahmen bilden dabei die XML-Daten, welche vom Server generiert sind. Diese sind mit dem Präfix `generated_`
versehen und sind dann nach dem Namen der Ansicht benannt, also `day`, `week` oder `month`.

Alle Dateien, welche für das Frontend verwendet werden, liegen im Verzeichnis `client/`. Dies beinhaltet
sämtliche CSS-, Bild- und XSL-Ressourcen. Die XML-Daten, welche an das Frontend gesendet werden, werden
dynamisch generiert und sind nur über den Browser-Debugger zu sehen.
