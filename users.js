/*
 * This provides function for getting and adding users.
 * It synchronizes users to the './users.xml' file.
 */

const xml = require("xml-js");
const fs = require("fs");

const USERS_FILE = "users.xml";

let users = [];

const xmlOptions = {compact: true, ignoreComment: true};

class User {
	constructor(username, password) {
		this.username = username;
		this.password = password;
	}
}

exports.User = User;

exports.readUsersFromFile = function() {
	try {
		// elements[0] = users
		const obj = xml.xml2js(fs.readFileSync(USERS_FILE), xmlOptions);
		for (let user of obj.users.user) {
			users.push(new User(user.username._text, user.password._text));
		}
	} catch (e) {
		console.error(e);
	}

	console.log("Read users", users);
};

exports.getUsers = function() {
	return users;
};

exports.getUsersKV = function() {
	let userKV = {};
	for (let u of users) {
		userKV[u.username] = u.password;
	}
	console.debug(userKV);
	return userKV;
};

exports.addUser = function(user) {
	users.push(user);
	try {
		const u = xml.js2xml({ users });
		fs.writeFile(USERS_FILE, u, null, (err) => {
			if (err) {
				console.error(err);
			}
		});
	} catch (e) {
		console.error(e);
	}
};
