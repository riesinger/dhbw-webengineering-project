/**
 * This provides methods for getting and updating calendar files
 */

const fs = require("fs");
const path = require("path");

exports.getCalendarFileForUser = (username) => {
	return fs.readFileSync(path.join(__dirname, "calendars", username + ".xml"));
};