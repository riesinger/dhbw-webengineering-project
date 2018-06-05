const express = require("express");
const basicAuth = require('express-basic-auth');
const path = require("path");
const xml = require("xml-js");

const users = require("./users");
const calendar = require("./calendar");

const app = express();

const xmlOptions = {compact: true, ignoreComment: true, spaces: 2};

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
		res.send(calendar.getCalendarFileForUser(req.auth.user));
	});
};

exports.start = function () {
	app.listen(9991, () => console.log("Listening on http://127.0.0.1:9991"));
};

