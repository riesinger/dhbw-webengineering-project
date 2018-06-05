const express = require("express");
const path = require("path");
const convert = require('xml-js');

const app = express();

var xmlOptions = {compact: true, ignoreComment: true, spaces: 2};

const catalog = {
  _declaration: { _attributes: {version: "1.0", encoding: "UTF-8" } },
  _instruction: { "xml-stylesheet": 'type="text/xsl" href="xsl/index.xsl"' },
  catalog: {
    cd: [
      {
        title: "Empire Birlesque",
        artist: "Bob Dylan",
        country: "USA",
        company: "Columbia",
        price: 10.90,
        year: 1985
      },
      {
        title: "asdsad sadsadsad",
        artist: "Bob Dylan",
        country: "USA",
        company: "Columbia",
        price: 10.90,
        year: 1985
      }
    ]
  }
}

app.get("/", (req, res) => {
  res.setHeader("Content-Type", "text/xml")
  res.send(convert.json2xml(catalog, xmlOptions))
});

app.use("/xsl", express.static(path.join(__dirname, "client")));

app.listen(9991, () => console.log("Listening on http://127.0.0.1:9991"));
