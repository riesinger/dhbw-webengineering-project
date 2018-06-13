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

function writeCalendarFile(username, calendar) {
	try {
		const u = xmlBuilder.buildObject(calendar);
		fs.writeFile(getPath(username), u, null, (err) => {
			if (err) {
				console.error(err);
			}
		});
	} catch (e) {
		console.error(e);
	}
}

exports.addEventToCalendar = (username, eventDetails) => {
	xml.parseString(getCalendarFile(username), (err, result) => {
		if (err != null) {
			console.error(err);
			return;
		}

		let eventArray = result.calendar.events[0].event;
		eventArray.push({
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

		writeCalendarFile(username, result);
	});
};

exports.getCurrentWeekEvents = (username) => {
	let tmpDate = new Date;
	let firstday = new Date(tmpDate.setDate(tmpDate.getDate() - tmpDate.getDay() + 1));
	let lastday = new Date(tmpDate.setDate(firstday.getDate() + 6));
	let curday = new Date;
	let resArray = [];

	xml.parseString(getCalendarFile(username), (err, result) => {
		if (err != null) {
			console.error(err);
			return;
		}

		let eventArray = result.calendar.events[0].event;
		for (var it = 0; it < eventArray.length; it++) {
			let event = eventArray[it];
			let startDate = new Date(event.startDateYear[0], event.startDateMonth[0] - 1, event.startDateDay[0] - 1);
			let endDate = new Date(event.endDateYear[0], event.endDateMonth[0] - 1, event.endDateDay[0] - 1);

			if ((startDate >= firstday && startDate <= lastday) || (endDate >= firstday && endDate <= lastday)) {
				resArray.push(event);
			}
		}
	});

	let week = {
		curDateDay: curday.getDate() + 1,
		curDateMonth: curday.getMonth() + 1,
		curDateYear: curday.getFullYear(),
		curDateHour: curday.getHours() + 1,
		curDateMinute: curday.getMinutes() + 1,

		firstDateDay: firstday.getDate() + 1,
		firstDateMonth: firstday.getMonth() + 1,
		firstDateYear: firstday.getFullYear(),
		firstDateHour: firstday.getHours() + 1,
		firstDateMinute: firstday.getMinutes() + 1,

		lastDateDay: lastday.getDate() + 1,
		lastDateMonth: lastday.getMonth() + 1,
		lastDateYear: lastday.getFullYear(),
		lastDateHour: lastday.getHours() + 1,
		lastDateMinute: lastday.getMinutes() + 1,
		
		events: { event: resArray}
	}

	return xmlBuilder.buildObject(week);
}