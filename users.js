/*
 * This provides function for getting and adding users.
 * It synchronizes users to the './users.xml' file.
 */

const fs = require("fs");
const xml = require("xml2js");
const xmlBuilder = new xml.Builder();

const USERS_FILE = "users.xml";

let users = [];

class User {
	constructor(username, password) {
		this.username = username;
		this.password = password;
	}
}

exports.User = User;

exports.readUsersFromFile = function() {
	try {
		const obj = xml.parseString(fs.readFileSync(USERS_FILE), (err, result) => {
			if (err != null) {
				console.error(err);
				return;
			}
		
			for (let user of result.users.user) {
				users.push(new User(user.username[0], user.password[0]));
			}
		});
	} catch(err) {
		console.error(err);
	}

	console.log("Read users");
};

exports.getUsers = function() {
	return users;
};

exports.getUsersKV = function() {
	let userKV = {};
	for (let u of users) {
		userKV[u.username] = u.password;
	}
	return userKV;
};

exports.addUser = function(user) {
	users.push(user);
	try {
		const u = xmlBuilder.buildObject({ users });
		fs.writeFile(USERS_FILE, u, null, (err) => {
			if (err) {
				console.error(err);
			}
		});
	} catch (e) {
		console.error(e);
	}
};
