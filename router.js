const express = require("express");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const path = require("path");
const cal = require("./calendar");

const users = require("./users");
const calendar = require("./calendar");

const app = express();

function injectXSLT(xml, xslt) {
	let slimXML = '';
	if (xml.indexOf("<?xml version") >= 0) {
		slimXML = xml.substring(xml.indexOf("\n") + 1);
	} else {
		slimXML = xml;
	}
	return "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<?xml-stylesheet type=\"text/xsl\" href=\"xsl/" + xslt + "\" ?>\n" + slimXML;
}

exports.setup = function () {
	app.use(bodyParser.urlencoded({ extended: false }));
	app.use(bodyParser.json());
	app.use(cookieParser());

	app.use((req, res, next) => {
		if (req.path === "/login" || req.path.indexOf("css") > -1) return next();

		let cookie = req.cookies.token;
		if (cookie) {
			let splitToken = cookie.split(":");

			if (!users.checkToken(splitToken[0], splitToken[1])) {
				res.cookie("token", "");
				res.redirect("/login");
				return;
			}

			req.user = splitToken[0];
			next();
		} else {
			res.redirect("/login");
		}
	});

	app.use("/xsl", express.static(path.join(__dirname, "client"), {
		setHeaders: (res, path) => {
			if (path.indexOf(".xsl") > -1) {
				res.setHeader("Content-Type", "text/xsl");
			}
		}
	}));

	app.use("/css", express.static(path.join(__dirname, "client", "css")));
	app.use("/images", express.static(path.join(__dirname, "client", "images")));

	app.get("/", async (req, res) => {
		console.log("Getting calendar for user", req.user);
		res.setHeader("Content-Type", "text/xml");
		try {
			const events = await calendar.getEventsInCurrentWeek(req.user);
			res.send(injectXSLT(events, "index.xsl"));
		} catch (err) {
			console.error(err);
			res.sendStatus(500);
		}
	});

	app.get("/login", async (req, res) => {
		res.sendFile(path.join(__dirname, "client", "login.html"))
	});

	app.post("/login", async (req, res) => {
		let token = users.checkCredentials(req.body.username, req.body.password);
		console.log(token);
		if (token === "") {
			console.error("Wrong credentials!");
			res.cookie("token", "");
			res.redirect("/login");
		} else {
			console.log("Successfull authentication: Set cookie and redirect to /");
			res.cookie("token", token, { maxAge: 999999, httpOnly: true });
			res.redirect("/");
		}
	});

	app.post("/addEvent", (req, res) => {

		var startDate = req.body.eventStartDate.split('-');
		var endDate = req.body.eventEndDate.split('-');
		var startTime = req.body.eventStartTime.split(':');
		var endTime = req.body.eventEndTime.split(':');

        cal.addEventToCalendar(req.user, {
            name: req.body.eventName,
            description: req.body.eventDescription,
            location: req.body.eventLocation,
            startDateDay: startDate[2],
            startDateMonth: startDate[1],
            startDateYear: startDate[0],
            startTimeHour: startTime[0],
            startTimeMinute: startTime[1],
            endDateDay: endDate[2],
            endDateMonth: endDate[1],
            endDateYear: endDate[0],
            endTimeHour: endTime[0],
            endTimeMinute: endTime[1]
        }).then((res) => {
            console.log("Event successfully added!");
        }, (err) => {
            console.error(err);
        });

        res.redirect("/");
	});
};

exports.start = function () {
	app.listen(9991, () => console.log("Listening on http://127.0.0.1:9991"));
};

