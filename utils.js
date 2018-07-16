exports.getFirstDayInWeek = (date, weekOffset) => {
  const d = new Date(date);
  const firstDate = new Date(
    d.setDate(d.getDate() - d.getDay() + (d.getDay() == 0 ? -6:1) + weekOffset * 7)
  );
  firstDate.setUTCHours(0, 0, 0, 1);
  console.debug("FirstDate is", firstDate.toISOString());
  return firstDate;
};

exports.getLastDayInWeek = (date, weekOffset) => {
  const d = new Date(date);
  const firstDate = exports.getFirstDayInWeek(date, weekOffset);
  let lastDate = new Date(firstDate);
  lastDate.setDate(lastDate.getDate() + 6);
  lastDate.setUTCHours(23, 59, 59, 0);
  console.debug("LastDate is", lastDate.toISOString());
  return lastDate;
};

exports.getFirstAndLastDayInWeek = (date, weekOffset) => {
  console.debug("WeekOffset is", weekOffset);
  console.debug("Date is", date.toISOString());
  return {
    firstDate: exports.getFirstDayInWeek(date, weekOffset),
    lastDate: exports.getLastDayInWeek(date, weekOffset)
  };
};

exports.getFirstAndLastDayInMonth = (date, monthOffset) => {
  console.debug("MonthOffset is", monthOffset);
  console.debug("Date is", date.toISOString());

  let d = new Date(date);
  d.setUTCMonth(d.getUTCMonth() + monthOffset);
  let firstDay = new Date();
  firstDay.setUTCFullYear(d.getUTCFullYear(), d.getUTCMonth(), 1);
  firstDay.setUTCHours(0, 0, 0, 0);
  let lastDay = new Date();
  lastDay.setUTCFullYear(d.getUTCFullYear(), d.getUTCMonth() + 1, 1);
  lastDay.setUTCHours(23, 59, 59, 0);
  lastDay.setUTCDate(lastDay.getUTCDate() - 1);

  return {
    firstDate: firstDay,
    lastDate: lastDay
  };
};

exports.jsDateToXMLObject = date => {
  return {
    year: date.getFullYear(),
    month: date.getMonth() + 1, // months are 0-based
    day: date.getDate(), // days are 1-based
    hour: date.getUTCHours(), // hours are correct
    minute: date.getMinutes()
  };
};

exports.XMLDateToJSDate = (year, month, day, hour, minute) => {
  return exports.XMLDateObjectToJSDate({
    year,
    month,
    day,
    hour,
    minute
  });
};

exports.XMLDateObjectToJSDate = dateObj => {
  return new Date(
    parseInt(dateObj.year),
    parseInt(dateObj.month) - 1,
    parseInt(dateObj.day),
    parseInt(dateObj.hour),
    parseInt(dateObj.minute)
  );
};

exports.injectXSLT_DTD = (xml, xslt, root, dtd) => {
  let slimXML = "";
  if (xml.indexOf("<?xml version") >= 0) {
    slimXML = xml.substring(xml.indexOf("\n") + 1);
  } else {
    slimXML = xml;
  }
  return (
    '<?xml version="1.0" encoding="UTF-8" ?>\n<!DOCTYPE ' +
    root +
    ' SYSTEM "dtd/' +
    dtd +
    '">\n<?xml-stylesheet type="text/xsl" href="xsl/' +
    xslt +
    '" ?>\n' +
    slimXML
  );
};

exports.injectDTD = (xml, root, dtd) => {
  let slimXML = "";
  if (xml.indexOf("<?xml version") >= 0) {
    slimXML = xml.substring(xml.indexOf("\n") + 1);
  } else {
    slimXML = xml;
  }
  return (
    '<?xml version="1.0" encoding="UTF-8" ?>\n<!DOCTYPE ' +
    root +
    ' SYSTEM "dtd/' +
    dtd +
    '">\n' +
    slimXML
  );
};
