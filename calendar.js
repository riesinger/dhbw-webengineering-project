/**
 * This provides methods for getting and updating calendar files
 */

const fs = require("fs");
const path = require("path");
const xml = require("xml2js");
const xmlBuilder = new xml.Builder();

const utils = require("./utils");

function getPath(username) {
  return path.join(__dirname, "calendars", username + ".xml");
}

function getCalendarFile(username) {
  return fs.readFileSync(getPath(username));
}

function getEventStartDate(event) {
	return utils.XMLDateToJSDate(
		event.startdate[0].$.year,
		event.startdate[0].$.month,
		event.startdate[0].$.day,
		event.startdate[0].$.hour,
		event.startdate[0].$.minute,
	);
}

function getEventEndDate(event) {
	return utils.XMLDateToJSDate(
		event.enddate[0].$.year,
		event.enddate[0].$.month,
		event.enddate[0].$.day,
		event.enddate[0].$.hour,
		event.enddate[0].$.minute,
	);
}

const parseCalendarFile = async username => {
  return new Promise((resolve, reject) => {
    xml.parseString(getCalendarFile(username), (err, data) => {
      if (err) {
        reject(err);
      }
      resolve(data);
    });
  });
};

function writeCalendarFile(username, calendar) {
  try {
    const u = xmlBuilder.buildObject(calendar);
    fs.writeFileSync(getPath(username), u, null);
  } catch (e) {
    console.error(e);
  }
}

function addTimeToObj(obj, timeName, time) {
  obj[timeName] = [
	  {
	  	"$": {
	  		year: time.getFullYear(),
			  month: time.getUTCMonth() + 1,
	  		day: time.getUTCDate(),
			  hour: time.getUTCHours(),
			  minute: time.getUTCMinutes(),
			  dow: time.getUTCDay() || 7, // To fix Sunday being 0
		  }
	  }
	];
}

function eventDateComparator(a, b) {
  if (getEventStartDate(a) < getEventStartDate(b)) {
    return -1;
  } else {
    return 1;
  }
}

exports.addEventToCalendar = (username, eventDetails) => {
  return new Promise((resolve, reject) => {
    xml.parseString(getCalendarFile(username), (err, result) => {
      if (err != null) {
        reject("Error parsing calendar file: " + err);
      }

      let eventID = result.calendar.nextEventID[0];
      result.calendar.nextEventID[0] =
        Number(result.calendar.nextEventID[0]) + 1;

      let eventArray = result.calendar.events[0].event;
      eventArray.push({
	      "$": {
		      ID: eventID,
        },
        name: [eventDetails["name"]],
        description: [eventDetails["description"]],
        location: [eventDetails["location"]],
        startdate: [
          {
            "$": {
              year: eventDetails.startDateYear,
	            month: eventDetails.startDateMonth,
	            day: eventDetails.startDateDay,
	            hour: eventDetails.startTimeHour,
	            minute: eventDetails.startTimeMinute,
            }
          }
        ],
	      enddate: [
		      {
		      	"$": {
							year: eventDetails.endDateYear,
	            month: eventDetails.endDateMonth,
	            day: eventDetails.endDateDay,
	            hour: eventDetails.endTimeHour,
	            minute: eventDetails.endTimeMinute,
			      }
		      }
	      ],
      });
      eventArray.sort(eventDateComparator);

      writeCalendarFile(username, result);

      resolve();
    });
  });
};

exports.removeEventFromCalendar = (username, eventID) => {
  return new Promise((resolve, reject) => {
    xml.parseString(getCalendarFile(username), (err, result) => {
      if (err || result === null) {
        reject("Error parsing calendar file: " + err);
      }

      let eventArray = result.calendar.events[0].event;
	    eventArray.map((event, i, array) => {
				if (parseInt(event.$.ID) === parseInt(eventID)) {
					array.splice(i, 1)
				}
	    });

      writeCalendarFile(username, result);

      resolve(true);
    });
  });
};

const getEventsBetween = async (username, firstDate, lastDate) => {
  try {
    const calendar = await parseCalendarFile(username);
    const events = calendar.calendar.events[0].event;
    let filteredEvents = events.filter(event => {
      const startDate = getEventStartDate(event);
      const endDate = getEventEndDate(event);
	    return (startDate >= firstDate && startDate <= lastDate) ||
	      (endDate >= firstDate && endDate <= lastDate);
    });

    filteredEvents = filteredEvents.sort(eventDateComparator);
    return filteredEvents;
  } catch (err) {
    console.error("Could not get events between dates: ", err);
  }
};

async function getEventsInMonth(username, month) {
  const date = new Date();
  const { firstDate, lastDate } = utils.getFirstAndLastDayInMonth(date, month);

  console.debug(`Getting events between ${firstDate.toISOString()} and ${lastDate.toISOString()}`);
  const events = await getEventsBetween(username, firstDate, lastDate);

  let returnMonth = {};
  addTimeToObj(returnMonth, "currentDate", new Date(Date.now()));
  addTimeToObj(returnMonth, "firstDate", firstDate);
  addTimeToObj(returnMonth, "lastDate", lastDate);

  returnMonth.events = { event: events };
  return returnMonth;
}

async function getEventsInWeek(username, week) {
  const date = new Date();
  const { firstDate, lastDate } = utils.getFirstAndLastDayInWeek(date, week);

  console.debug(`Getting events between ${firstDate.toISOString()} and ${lastDate.toISOString()}`);
  const events = await getEventsBetween(username, firstDate, lastDate);

  let returnWeek = {};
  const now = new Date();
  // Fixing the UTC Offset
	now.setHours(now.getHours() + 2);
  addTimeToObj(returnWeek, "currentDate", now);
  addTimeToObj(returnWeek, "firstDate", firstDate);
  addTimeToObj(returnWeek, "lastDate", lastDate);

  returnWeek.events = { event: events };
  return returnWeek;
}

async function getEventsInDay(username, day) {
	const date = new Date();
  let firstDate = new Date(
    date.setDate(date.getDate() + day)
  );
  firstDate.setUTCHours(0, 0, 0, 0);

  let lastDate = new Date(firstDate);
  lastDate.setUTCHours(23, 59, 59, 0);

  console.debug(`Getting events between ${firstDate.toISOString()} and ${lastDate.toISOString()}`);
  const events = await getEventsBetween(username, firstDate, lastDate);

  let returnDay = {};
	const now = new Date();
	// Fixing the UTC Offset
	now.setHours(now.getHours() + 2);
  addTimeToObj(returnDay, "currentDate", now);
  addTimeToObj(returnDay, "firstDate", firstDate);
  addTimeToObj(returnDay, "lastDate", lastDate);

  returnDay.events = { event: events };
  return returnDay;
}

exports.getEvents = async (username, date) => {
	if (date.dispForm === "month") {
    return getEventsInMonth(username, date.dateOffset);
  } else if (date.dispForm === "week") {
		return getEventsInWeek(username, date.dateOffset);
	} else if (date.dispForm === "day") {
		return getEventsInDay(username, date.dateOffset);
	} else {
		return getEventsInWeek(username, 0);
	}
};

