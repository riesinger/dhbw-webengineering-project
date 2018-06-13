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
});*/

console.log(cal.getCurrentWeekEvents("test1"));