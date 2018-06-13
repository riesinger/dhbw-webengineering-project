const express = require("express");
const basicAuth = require('express-basic-auth');
const path = require("path");

const users = require("./users");
const calendar = require("./calendar");

const app = express();

exports.setup = function () {

	app.use(basicAuth({
		users: users.getUsersKV(),
		challenge: true,
		realm: 'You need to login'
	}));

	app.use("/xsl", express.static(path.join(__dirname, "client")));

	app.get("/", (req, res) => {
		console.log("Getting calendar for user", req.auth.user);
		res.setHeader("Content-Type", "text/xml");
		res.send(calendar.getCalendarFile(req.auth.user));
	});

	app.post("/addEvent", (req, res) => {	
	})
};

exports.start = function () {
	app.listen(9991, () => console.log("Listening on http://127.0.0.1:9991"));
};

