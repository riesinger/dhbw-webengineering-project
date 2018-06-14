const fs = require("fs");
const cal = require("./calendar");

/*cal.addEventToCalendar("test1", {
	name: "Party im AKK",
	description: "partey hard",
	location: "AKK",
	startDateDay: 15,
	startDateMonth: 06,
	startDateYear: 2018,
	startTimeHour: 21,
	startTimeMinute: 00,
	endDateDay: 15,
	endDateMonth: 06,
	endDateYear: 2018,
	endTimeHour: 23,
	endTimeMinute: 59
}).then((res) => {
	console.log("Event successfully added!");
}, (err) => {
	console.error(err);
});

cal.getCurrentWeekEvents("test1").then((res) => {
	console.log(res);
}, (err) => {
	console.error(err);
});*/

cal.removeEventFromCalendar("test1", 3).then((res) => {
	if (res === true) {
		console.log("Event removed");
	} else {
		console.log("Event not removed");
	}
}, (err) => {
	console.error(err);
})