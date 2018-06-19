const express = require("express");
const basicAuth = require('express-basic-auth');
const path = require("path");

const users = require("./users");
const calendar = require("./calendar");

const app = express();

function injectXSLT(xml, xslt) {
	if (xml.indexOf("<?xml version") >= 0) {
		var slimXML = xml.substring(xml.indexOf("\n") + 1);
	} else {
		var slimXML = xml;
	}
	return "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<?xml-stylesheet type=\"text/xsl\" href=\"xsl/" + xslt + "\" ?>\n" + slimXML;
}

exports.setup = function () {

	app.use(basicAuth({
		users: users.getUsersKV(),
		challenge: true,
		realm: 'You need to login'
	}));

	app.use("/xsl", express.static(path.join(__dirname, "client")));
	app.use("/css", express.static(path.join(__dirname, "client", "css")));

	app.get("/", (req, res) => {
		console.log("Getting calendar for user", req.auth.user);
		res.setHeader("Content-Type", "text/xml");
		calendar.getCurrentWeekEvents(req.auth.user).then((week) => {
			res.send(injectXSLT(week, "index.xsl"));
		}, (err) => {
			res.sendStatus(500);
		})
	});

	app.post("/addEvent", (req, res) => {	
	})
};

exports.start = function () {
	app.listen(9991, () => console.log("Listening on http://127.0.0.1:9991"));
};

