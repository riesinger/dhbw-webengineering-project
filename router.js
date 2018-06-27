const express = require("express");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const path = require("path");
const xml = require("xml2js");
const xmlBuilder = new xml.Builder();

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

function sendCalendar(res, events, injectTags) {
	res.setHeader("Content-Type", "text/xml");
	try {
		let sendObject = { calendar: { week: events, meta: injectTags } };
		const s = xmlBuilder.buildObject(sendObject)

		res.send(injectXSLT(s, "index.xsl"));
	} catch (err) {
		console.error(err);
		res.sendStatus(500);
	}
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
		try {
			const oEvents = await calendar.getEventsInCurrentWeek(req.user);
			sendCalendar(res, oEvents, []);
		} catch (err) {
			console.error(err);
			res.statusCode(500);
		}
	});

	app.get("/login", async (req, res) => {
		res.sendFile(path.join(__dirname, "client", "login.html"))
	});

	app.post("/login", async (req, res) => {
		let token = users.checkCredentials(req.body.username, req.body.password);
		if (token === "") {
			console.error("Wrong credentials!");
			res.cookie("token", "");
			res.redirect("/login");
		} else {
			console.log("Successfull authentication: Set cookie and redirect to /");
			res.cookie("token", token, { expires: new Date(253402300000000), httpOnly: true });
			res.redirect("/");
		}
	});

	app.post("/addEvent", (req, res) => {

		var startDate = req.body.eventStartDate.split('-');
		var endDate = req.body.eventEndDate.split('-');

        calendar.addEventToCalendar(req.user, {
            name: req.body.eventName,
            description: req.body.eventDescription,
            location: req.body.eventLocation,
            startDateDay: Number(startDate[2]),
            startDateMonth: Number(startDate[1]),
            startDateYear: Number(startDate[0]),
            startTimeHour: Number(req.body.eventStartTimeHour),
            startTimeMinute: Number(req.body.eventStartTimeMinute),
            endDateDay: Number(endDate[2]),
            endDateMonth: Number(endDate[1]),
            endDateYear: Number(endDate[0]),
            endTimeHour: Number(req.body.eventEndTimeHour),
            endTimeMinute: Number(req.body.eventEndTimeMinute)
        }).then((res) => {
            console.log("Event successfully added!");
        }, (err) => {
            console.error(err);
        });

        res.redirect("/");
    });

	app.get("/newEvent", async (req, res) => {
		try {
            const oEvents = await calendar.getEventsInCurrentWeek(req.user);
            sendCalendar(res, oEvents, {"newEventWindow": {}});
        } catch (err){
            console.error(err);
            res.statusCode(500);
		}
	});

	app.get("/showEvent", async (req, res) => {
		let eventID = req.query.eventID;
		if (eventID) {
			try {
				const oEvents = await calendar.getEventsInCurrentWeek(req.user);
				sendCalendar(res, oEvents, { "showEvent": {ID: eventID} });
			} catch (err) {
				console.error(err);
				res.statusCode(500);
			}
		} else {
			res.redirect("/");
		}
	});

	app.get("/deleteEvent", async (req, res) => {
		let eventID = req.query.eventID;
		if (eventID) {
			console.log("Remove event " + eventID + " for user " + req.user);
			await calendar.removeEventFromCalendar(req.user, eventID);
		}

		res.redirect("/");
	});

	app.get("/addRemote", async (req, res) => {
		try {
			const oEvents = await calendar.getEventsInCurrentWeek(req.user);
			sendCalendar(res, oEvents, { "addRemote": {} });
		} catch (err) {
			console.error(err);
			res.statusCode(500);
		}
	});

};

exports.start = function () {
	app.listen(9991, () => console.log("Listening on http://127.0.0.1:9991"));
};

