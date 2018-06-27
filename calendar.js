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
	return new Date(
		parseInt(event.startDateYear[0]),
		parseInt(event.startDateMonth[0]) - 1, // 0-based, but we add one later
		parseInt(event.startDateDay[0]) + 1, // 0-based
		parseInt(event.startTimeHour[0]) + 2, // 0-based
		parseInt(event.startTimeMinute[0])
	);
}

function getEventEndDate(event) {
	return new Date(
		parseInt(event.endDateYear[0]),
		parseInt(event.endDateMonth[0]) - 1, // 0-based, but we add one later
		parseInt(event.endDateDay[0]) + 1, // 0-based
		parseInt(event.endTimeHour[0]) + 2, // 0-based
		parseInt(event.endTimeMinute[0])
	);
}

const parseCalendarFile = async (username) => {
	return new Promise((resolve, reject) => {
		xml.parseString(getCalendarFile(username), (err, data) => {
			if (err) {
				reject(err);
			}
			resolve(data);
		})
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
	obj[timeName + "Day"] = time.getDate();
	obj[timeName + "Month"] = time.getMonth() + 1;
	obj[timeName + "Year"] = time.getFullYear();
	obj[timeName + "Hour"] = time.getHours();
	obj[timeName + "Minute"] = time.getMinutes();
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
				ID: [eventID],
				name: [eventDetails["name"]],
				description: [eventDetails["description"]],
				location: [eventDetails["location"]],
				startDateDOW: [new Date().getDay()],
				startDateDay: [eventDetails["startDateDay"]],
				startDateMonth: [eventDetails["startDateMonth"]],
				startDateYear: [eventDetails["startDateYear"]],
				startTimeHour: [eventDetails["startTimeHour"]],
				startTimeMinute: [eventDetails["startTimeMinute"]],
				endDateDay: [eventDetails["endDateDay"]],
				endDateMonth: [eventDetails["endDateMonth"]],
				endDateYear: [eventDetails["endDateYear"]],
				endTimeHour: [eventDetails["endTimeHour"]],
				endTimeMinute: [eventDetails["endTimeMinute"]]
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
				if (parseInt(eventArray[it].ID[0]) === parseInt(eventID)) {
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

const getEventsBetween = async (username, firstDate, lastDate) => {
	try {
		const calendar = await parseCalendarFile(username);
		const events = calendar.calendar.events[0].event;
		let filteredEvents = events.filter(event => {
			const startDate = getEventStartDate(event);
			const endDate = getEventEndDate(event);
			const included = ((startDate >= firstDate && startDate <= lastDate) || (endDate >= firstDate && endDate <= lastDate));
			return included;
		});
		
		filteredEvents = filteredEvents.sort(eventDateComparator);
		return filteredEvents;
	} catch (err) {
		console.error("Could not get events between dates: ", err);
	}

};

exports.getEventsInCurrentWeek = async (username) => {
    const date = new Date();
    let firstDate = new Date(date.setDate(date.getDate() - date.getDay() + 1));
    firstDate.setUTCHours(0, 0, 0, 0);

    let lastDate = new Date(date.setDate(firstDate.getDate() + 6));
    lastDate.setUTCHours(23, 59, 59, 0);

    console.debug(`Getting events between ${firstDate.toISOString()} and ${lastDate.toISOString()}`);
    const events = await getEventsBetween(username, firstDate, lastDate);

    let week = {};
    addTimeToObj(week, "currentDate", new Date());
    addTimeToObj(week, "firstDate", firstDate);
    addTimeToObj(week, "lastDate", lastDate);

    week.events = {event: events};
    return week;
};

exports.getEventsInWeek = async (username, week) => {
    const date = new Date();
    let firstDate = new Date(date.setDate(date.getDate() - date.getDay() + 1)) + week * 7;
    firstDate.setUTCHours(0, 0, 0, 0);

    let lastDate = new Date(date.setDate(firstDate.getDate() + 6)) + week * 7;
    lastDate.setUTCHours(23, 59, 59, 0);

    console.debug(`Getting events between ${firstDate.toISOString()} and ${lastDate.toISOString()}`);
    const events = await getEventsBetween(username, firstDate, lastDate);

    let returnWeek = {};
    addTimeToObj(week, "currentDate", new Date());
    addTimeToObj(week, "firstDate", firstDate);
    addTimeToObj(week, "lastDate", lastDate);

    week.events = {event: events};
    return returnWeek;
};

