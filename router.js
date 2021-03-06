const express = require("express");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const path = require("path");
const xml = require("xml2js");
const xmlBuilder = new xml.Builder();

const users = require("./users");
const calendar = require("./calendar");
const utils = require("./utils");

const app = express();

function sendCalendar(res, events, dispForm, injectTags) {
  res.setHeader("Content-Type", "text/xml");
  try {
    let sendObject = { calendar: { meta: injectTags } };
    sendObject.calendar[dispForm] = events;
    const s = xmlBuilder.buildObject(sendObject);
    res.send(
      utils.injectXSLT_DTD(
        s,
        "index.xsl",
        "calendar",
        "generated_" + dispForm + ".dtd"
      )
    );
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
}

function getSelectedDate(req) {
  if (req.query.month !== undefined) {
    return { dispForm: "month", dateOffset: parseInt(req.query.month) };
  } else if (req.query.week !== undefined) {
    return { dispForm: "week", dateOffset: parseInt(req.query.week) };
  } else if (req.query.day !== undefined) {
    return { dispForm: "day", dateOffset: parseInt(req.query.day) };
  } else {
    return { dispForm: "week", dateOffset: 0 };
  }
}

async function sendErrorMessage(req, res, err) {
  const selectedDate = getSelectedDate(req);
  const oEvents = await calendar.getEvents(req.user, selectedDate);
  sendCalendar(res, oEvents, selectedDate.dispForm, {
    error: { err },
    ...selectedDate
  });
}

exports.setup = function() {
  app.use(bodyParser.urlencoded({ extended: false }));
  app.use(bodyParser.json());
  app.use(cookieParser());

  app.use((req, res, next) => {
    if (
      req.path === "/login" ||
      req.path === "/register" ||
      req.path === "/addUser" ||
      req.path.indexOf("css") > -1 ||
      req.path.indexOf("dtd") > -1
    )
      return next();

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

  app.use(
    "/xsl",
    express.static(path.join(__dirname, "client", "xsl"), {
      setHeaders: (res, path) => {
        if (path.indexOf(".xsl") > -1) {
          res.setHeader("Content-Type", "text/xsl");
        }
      }
    })
  );

  app.use("/css", express.static(path.join(__dirname, "client", "css")));
  app.use("/images", express.static(path.join(__dirname, "client", "images")));
  app.use("/dtd", express.static(path.join(__dirname, "dtd")));

  app.get("/", async (req, res) => {
    console.log("Getting calendar for user", req.user);
    try {
      const selectedDate = getSelectedDate(req);
      const oEvents = await calendar.getEvents(req.user, selectedDate);
      sendCalendar(res, oEvents, selectedDate.dispForm, { ...selectedDate });
    } catch (err) {
      console.error(err);
      res.statusCode(500);
    }
  });

  app.get("/login", async (req, res) => {
    res.sendFile(path.join(__dirname, "client", "login.html"));
  });

  app.get("/register", async (req, res) => {
    res.sendFile(path.join(__dirname, "client", "register.html"));
  });

  app.get("/logout", async (req, res) => {
    res.cookie("token", "");
    res.redirect("/login");
  });

  app.post("/login", async (req, res) => {
    let token = users.checkCredentials(req.body.username, req.body.password);
    if (token === "") {
      console.error("Wrong credentials!");
      res.cookie("token", "");
      res.redirect("/login");
    } else {
      console.log("Successfull authentication: Set cookie and redirect to /");
      res.cookie("token", token, {
        expires: new Date(253402300000000),
        httpOnly: true
      });
      res.redirect("/");
    }
  });

  app.post("/addUser", async (req, res) => {
    console.log("Add new user " + req.body.username);
    if (!users.existsUser(req.body.username)) {
      users.addUser(req.body.username, req.body.password);
      calendar.newCalendarForUser(req.body.username);
    }

    let token = users.checkCredentials(req.body.username, req.body.password);
    if (token === "") {
      console.error("Wrong credentials!");
      res.cookie("token", "");
      res.redirect("/login");
    } else {
      console.log("Successfull authentication: Set cookie and redirect to /");
      res.cookie("token", token, {
        expires: new Date(253402300000000),
        httpOnly: true
      });
      res.redirect("/");
    }
  });

  app.post("/addEvent", (req, res) => {
    let startDate = new Date(req.body.eventStartDate);
    let startTime = req.body.eventStartTime.split(":");
    let endTime = req.body.eventEndTime.split(":");
    const allDayEvent = (req.body.allDayEvent == "on" ? true:false);
    const reoccuringTimes = req.body.reoccuringTimes;
    const reoccuringType = req.body.reoccuringType;

    if(allDayEvent == true){
      startTime = [0,1];
      endTime = [23,59];
    }

    let loc = req.body.eventLocation;
    if (loc == null) loc = "";

    let desc = req.body.eventDescription;
    if (desc == null) desc = "";

    let tempAdd;
    let errorReceieved = false;

    switch(reoccuringType){
          case "week":
              tempAdd = 7;
              break;

            default:
              tempAdd = 1;
              break;
      }



    for(let i = 0; i <= reoccuringTimes; i++) {

      if(i != 0) startDate.setDate(startDate.getDate() + tempAdd);

        calendar
            .addEventToCalendar(
                req.user,
                {
                    name: req.body.eventName,
                    description: desc,
                    location: loc,
                    startDateDay: Number(startDate.getDate()),
                    startDateMonth: Number(startDate.getMonth() + 1),
                    startDateYear: Number(startDate.getFullYear()),
                    startTimeHour: Number(startTime[0]),
                    startTimeMinute: Number(startTime[1]),
                    endDateDay: Number(startDate.getDate()),
                    endDateMonth: Number(startDate.getMonth() + 1),
                    endDateYear: Number(startDate.getFullYear()),
                    endTimeHour: Number(endTime[0]),
                    endTimeMinute: Number(endTime[1])
                },
                res
            )
            .then(
                res => {
                    const date = getSelectedDate(req);
                    res.redirect("/?" + date.dispForm + "=" + date.dateOffset);
                },
                err => {
                  if(!errorReceieved) {
                      errorReceieved = true;
                      console.error(err);
                      sendErrorMessage(req, res, err);
                  }
                }
            );
    }

  });

  app.post("/editEvent", async (req, res) => {
    console.log("Getting change on calender for user " + req.user);
    let eventID = req.query.eventID;
    console.log("Event ID: " + eventID);
    if (eventID) {
      await calendar.removeEventFromCalendar(req.user, eventID);

      var startDate = req.body.eventStartDate.split("-");
      var startTime = req.body.eventStartTime.split(":");
      var endTime = req.body.eventEndTime.split(":");

      var loc = req.body.eventLocation;
      if (loc == null) loc = "";

      var desc = req.body.eventDescription;
      if (desc == null) desc = "";

      await calendar
        .addEventToCalendar(
          req.user,
          {
            name: req.body.eventName,
            description: desc,
            location: loc,
            startDateDay: Number(startDate[2]),
            startDateMonth: Number(startDate[1]),
            startDateYear: Number(startDate[0]),
            startTimeHour: Number(startTime[0]),
            startTimeMinute: Number(startTime[1]),
            endDateDay: Number(startDate[2]),
            endDateMonth: Number(startDate[1]),
            endDateYear: Number(startDate[0]),
            endTimeHour: Number(endTime[0]),
            endTimeMinute: Number(endTime[1])
          },
          res
        )
        .then(
          res => {
            const date = getSelectedDate(req);
            res.redirect("/?" + date.dispForm + "=" + date.dateOffset);
          },
          err => {
            console.error(err);
            sendErrorMessage(req, res, err);
            return;
          }
        );
    }
  });

  app.get("/newEvent", async (req, res) => {
    try {
      const selectedDate = getSelectedDate(req);
      const oEvents = await calendar.getEvents(req.user, selectedDate);
      sendCalendar(res, oEvents, selectedDate.dispForm, {
        newEvent: {},
        ...selectedDate
      });
    } catch (err) {
      console.error(err);
      res.statusCode(500);
    }
  });

  app.get("/showEvent", async (req, res) => {
    let eventID = req.query.eventID;
    if (eventID) {
      try {
        const selectedDate = getSelectedDate(req);
        const oEvents = await calendar.getEvents(req.user, selectedDate);
        sendCalendar(res, oEvents, selectedDate.dispForm, {
          showEvent: { ID: eventID },
          ...selectedDate
        });
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

    const date = getSelectedDate(req);
    res.redirect("/?" + date.dispForm + "=" + date.dateOffset);
  });

  app.get("/editEvent", async (req, res) => {
    try {
      let eventID = req.query.eventID;
      if (eventID) {
        const selectedDate = getSelectedDate(req);
        const oEvents = await calendar.getEvents(req.user, selectedDate);
        sendCalendar(res, oEvents, selectedDate.dispForm, {
          editEvent: { ID: eventID },
          ...selectedDate
        });
      } else {
        res.redirect("/");
      }
    } catch (err) {
      console.error(err);
      res.statusCode(500);
    }
  });

  app.get("/howto", async (req, res) => {
    try {
      const selectedDate = getSelectedDate(req);
      const oEvents = await calendar.getEvents(req.user, selectedDate);
      sendCalendar(res, oEvents, selectedDate.dispForm, {
        howto: {},
        ...selectedDate
      });
    } catch (err) {
      console.error(err);
      res.statusCode(500);
    }
  });
};

exports.start = function() {
  app.listen(4242, () => console.log("Listening on http://127.0.0.1:4242"));
};
