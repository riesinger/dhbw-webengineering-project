const router = require("./router");
const users = require("./users");

users.readUsersFromFile();

router.setup();
router.start();

