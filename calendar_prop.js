const express = require("express");
const convert = require('xml-js');
const fs = require('fs');
const xmlOptions = {compact: true, ignoreComment: true, spaces: 2};

const calendar = {
	calendar: [
		{
			ID: 0,
			name: "Mein Kalender!",
			remoteUrl: "Wenn des n ical kalender ist. Events und so fällt weg und wird beim Aufruf gefüllt",
			events: { event: [
				{
					name: "Einkaufen gehen",
					description: "Hab Hunger!",
					location: "Lidl",
					startDateDay: 12,
					startDateMonth: 5,
					startDateYear: 2018,
					startTimeHour: 13,
					startTimeMinute: 15,
					endDateDay: 12,
					endDateMonth: 5,
					endDateYear: 2018,
					endTimeHour: 13,
					endTimeMinute: 45
				},
				{
					name: "Kino",
					description: "PiPaPo",
					location: "ZKM",
					startDateDay: 13,
					startDateMonth: 6,
					startDateYear: 2018,
					startTimeHour: 19,
					startTimeMinute: 15,
					endDateDay: 13,
					endDateMonth: 6,
					endDateYear: 2018,
					endTimeHour: 22,
					endTimeMinute: 00
				}
			] },
			__recurr_events__: { __recurr_event__: [
				// Vllt für die Zukunft....
			] }
		}
	]
};

var xmlData = convert.js2xml(calendar, xmlOptions);

fs.writeFile("calendar_prop.xml", xmlData, function(err) {
	if(err) {
			return console.log(err);
	}

	console.log("File saved!");
}); 