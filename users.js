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
	constructor(username, password, token) {
		this.username = username;
		this.password = password;
		this.token = token;
	}
}

exports.User = User;

function writeUsers() {
	try {
		const u = xmlBuilder.buildObject({ "users": { "user": users } });
		fs.writeFileSync(USERS_FILE, u, null);
	} catch (e) {
		console.error(e);
	}
}

exports.readUsersFromFile = function() {
	try {
		xml.parseString(fs.readFileSync(USERS_FILE), (err, result) => {
			if (err != null) {
				console.error(err);
				return;
			}
		
			for (let user of result.users.user) {
				if (user.token === undefined) {
					user.token = [ "" ]
				}
				users.push(new User(user.username[0], user.password[0], user.token[0]));
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

exports.addUser = function(user) {
	users.push(user);
	writeUsers();
};

exports.checkCredentials = function(username, password) {
	let user = users.find(el => el.username === username );
	if (user !== undefined && user.password === password) {
		let randString = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
		user.token = randString;
		writeUsers();

		return username + ":" + randString;
	} else {
		return "";
	}
}

exports.checkToken = function(username, token) {
	let user = users.find(el => el.username === username);
	if (user) {
		if (user.token !== "" && user.token === token) {
			return true;
		} else {
			return false;
		}
	} else {
		return false;
	}
}
