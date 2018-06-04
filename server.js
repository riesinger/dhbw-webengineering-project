const express = require("express");
const path = require("path");

const app = express();

const fileOptions = {
  root: __dirname + "/client/",
  dotfiles: "ignore",
}

app.get("/", (req, res) => {
  res.sendFile("index.xml", fileOptions);
});

app.use("/xsl", express.static(path.join(__dirname, "client", "xsl")));

app.listen(9991, () => console.log("Listening on http://127.0.0.1:9991"));
