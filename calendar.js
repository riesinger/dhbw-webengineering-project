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
			eventArray.sort(eventDateComparator);
	
			writeCalendarFile(username, result);

			resolve();
		});
	});
};

exports.getCurrentWeekEvents = (username) => {
	return new Promise((resolve, reject) => {
		let tmpDate = new Date;
		let firstday = new Date(tmpDate.setDate(tmpDate.getDate() - tmpDate.getDay() + 1));
		let lastday = new Date(tmpDate.setDate(firstday.getDate() + 6));
		let curday = new Date;
	
		new Promise((resolveXML, rejectXML) => {
			xml.parseString(getCalendarFile(username), (err, result) => {
				if (err !== null || result === null) {
					rejectXML("Error parsing calendar file: " + err);
				}
	
				let eventArray = result.calendar.events[0].event;
				let resArray = [];
				for (var it = 0; it < eventArray.length; it++) {
					let event = eventArray[it];
					let startDate = getEventStartDate(event);
					let endDate = getEventEndDate(event);
	
					if ((startDate >= firstday && startDate <= lastday) || (endDate >= firstday && endDate <= lastday)) {
						resArray.push(event);
					}
				}
	
				resolveXML(resArray);
			});
		}).then((res) => {
			let week = {};
			addTimeToObj(week, "curDate", curday);
			addTimeToObj(week, "firstDate", firstday);
			addTimeToObj(week, "lastDate", lastday);
			res.sort(eventDateComparator);
			week["events"] = { event: res };
		
			resolve(xmlBuilder.buildObject({ week }));
		}, (err) => {
			reject(err);
		});
	});	
}