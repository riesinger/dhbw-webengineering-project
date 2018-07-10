var crypto = require('crypto');
const hash = crypto.createHash("md5").update("123456").digest("hex");
console.log(hash);