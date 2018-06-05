const express = require("express");
const basicAuth = require('express-basic-auth')
const path = require("path");
const convert = require('xml-js');

const app = express();

app.use(basicAuth({
    users: {
      "user1": "secret1",
      "user2": "secret2"
    },
    challenge: true,
    realm: 'j4#1z0TLu@81'
}))

const xmlOptions = {compact: true, ignoreComment: true, spaces: 2};

const calendar = {
  _declaration: { _attributes: {version: "1.0", encoding: "UTF-8" } },
  _instruction: { "xml-stylesheet": 'type="text/xsl" href="xsl/index.xsl"' },
	calendar: [
		{
			ID: 0,
			name: "Mein Kalender!",
			remoteUrl: "Wenn des n ical kalender ist. Events und so fällt weg und wird beim Aufruf gefüllt",
			events: { event: [
				{
					name: "Einkaufen gehen",
					description: "Hab Hunger!",
					location: "Lidl",
					startDateDay: 12,
					startDateMonth: 5,
					startDateYear: 2018,
					startTimeHour: 13,
					startTimeMinute: 15,
					endDateDay: 12,
					endDateMonth: 5,
					endDateYear: 2018,
					endTimeHour: 13,
					endTimeMinute: 45
				},
				{
					name: "Kino",
					description: "PiPaPo",
					location: "ZKM",
					startDateDay: 13,
					startDateMonth: 6,
					startDateYear: 2018,
					startTimeHour: 19,
					startTimeMinute: 15,
					endDateDay: 13,
					endDateMonth: 6,
					endDateYear: 2018,
					endTimeHour: 22,
					endTimeMinute: 00
				}
			] }
		}
	]
};

app.get("/", (req, res) => {
  res.setHeader("Content-Type", "text/xml");
  res.send(convert.js2xml(calendar, xmlOptions));
});

app.use("/xsl", express.static(path.join(__dirname, "client")));

app.listen(9991, () => console.log("Listening on http://127.0.0.1:9991"));
