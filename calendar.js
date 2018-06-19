/**
 * This provides methods for getting and updating calendar files
 */

const fs = require("fs");
const path = require("path");
const xml = require("xml2js")
const xmlBuilder = new xml.Builder();

function getPath(username) {
	return path.join(__dirname, "calendars", username + ".xml")
}

function getCalendarFile(username) {
	return fs.readFileSync(getPath(username));
}

function getEventStartDate(event) {
	return new Date(event.startDateYear[0], event.startDateMonth[0] - 1, event.startDateDay[0]);
}

function getEventEndDate(event) {
	return new Date(event.endDateYear[0], event.endDateMonth[0] - 1, event.endDateDay[0]);
}

function writeCalendarFile(username, calendar) {
	try {
		const u = xmlBuilder.buildObject(calendar);
		fs.writeFileSync(getPath(username), u, null);
	} catch (e) {
		console.error(e);
	}
}

function addTimeToObj(obj, timeName, time) {
	obj[timeName + "Day"] = time.getDate() + 1;
	obj[timeName + "Month"] = time.getMonth() + 1;
	obj[timeName + "Year"] = time.getFullYear();
	obj[timeName + "Hour"] = time.getHours() + 1;
	obj[timeName + "Minute"] = time.getMinutes() + 1;
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
			result.calendar.nextEventID[0] = Number(result.calendar.nextEventID[0]) + 1;

			let eventArray = result.calendar.events[0].event;
			eventArray.push({
				ID: [ eventID ],
				name: [ eventDetails["name"] ],
				description: [ eventDetails["description"] ],
				location: [ eventDetails["location"] ],
				startDateDay: [ eventDetails["startDateDay"] ],
				startDateMonth: [ eventDetails["startDateMonth"] ],
				startDateYear: [ eventDetails["startDateYear"] ],
				startTimeHour: [ eventDetails["startTimeHour"] ],
				startTimeMinute: [ eventDetails["startTimeMinute"] ],
				endDateDay: [ eventDetails["endDateDay"] ],
				endDateMonth: [ eventDetails["endDateMonth"] ],
				endDateYear: [ eventDetails["endDateYear"] ],
				endTimeHour: [ eventDetails["endTimeHour"] ],
				endTimeMinute: [ eventDetails["endTimeMinute"] ]
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
			let eventIt = null;
			for (let it = 0; it < eventArray.length; it++) {
				if (Number(eventArray[it].ID[0]) === eventID) {
					eventIt = it;
					break;
				}
			}

			if (eventIt != null) {
				eventArray.splice(eventIt, 1);
			} else {
				resolve(false);
			}
	
			writeCalendarFile(username, result);

			resolve(true);
    });
	});
};

function getEvents(username, firstDate, lastDate) {
	let curDate = new Date();
	
	return new Promise((resolve, reject) => {
		xml.parseString(getCalendarFile(username), (err, result) => {
			if (err || result === null) {
				reject("Error parsing calendar file: " + err);
			}

			let eventArray = result.calendar.events[0].event.filter(event => {
        const startDate = getEventStartDate(event);
				const endDate = getEventEndDate(event);

				return ((startDate >= firstDate && startDate <= lastDate) || (endDate >= firstDate && endDate <= lastDate)); 
      }).sort(eventDateComparator);
	
			let week = {};
			addTimeToObj(week, "curDate", curDate);
			addTimeToObj(week, "firstDate", firstDate);
			addTimeToObj(week, "lastDate", lastDate);
			week.events = { event: eventArray };
		
			resolve(xmlBuilder.buildObject({ week }));
    });
  });
}
exports.getEvents = getEvents;

function getWeekEvents(username, date) {
	let firstDate = new Date(date.setDate(date.getDate() - date.getDay() + 1));
	firstDate.setUTCHours(0, 0, 0, 0);
	let lastDate = new Date(date.setDate(firstDate.getDate() + 6));
	lastDate.setUTCHours(23, 59, 59, 0);

	return getEvents(username, firstDate, lastDate);
}
exports.getWeekEvents = getWeekEvents;

exports.getCurrentWeekEvents = (username) => {
	return getWeekEvents(username, new Date());
}