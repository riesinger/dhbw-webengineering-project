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
};

function getEventStartDate(event) {
	return new Date(event.startDateYear[0], event.startDateMonth[0] - 1, event.startDateDay[0] - 1);
}

function getEventEndDate(event) {
	return new Date(event.endDateYear[0], event.endDateMonth[0] - 1, event.endDateDay[0] - 1);
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

exports.getCurrentWeekEvents = (username) => {
	let tmpDate = new Date();
	let firstday = new Date(tmpDate.setDate(tmpDate.getDate() - tmpDate.getDay() + 1));
	let lastday = new Date(tmpDate.setDate(firstday.getDate() + 6));
	let curday = new Date();
	
	return new Promise((resolve, reject) => {
		xml.parseString(getCalendarFile(username), (err, result) => {
			if (err || result === null) {
				reject("Error parsing calendar file: " + err);
			}

			let eventArray = result.calendar.events[0].event.filter(event => {
        const startDate = getEventStartDate(event);
        const endDate = getEventEndDate(event);

				return ((startDate >= firstday && startDate <= lastday) || (endDate >= firstday && endDate <= lastday)); 
      }).sort(eventDateComparator);
	
			let week = {};
			addTimeToObj(week, "curDate", curday);
			addTimeToObj(week, "firstDate", firstday);
			addTimeToObj(week, "lastDate", lastday);
			week.events = { event: eventArray };
		
			resolve(xmlBuilder.buildObject({ week }));
    });
  });
}