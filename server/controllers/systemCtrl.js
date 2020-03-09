const db = require("../config/db");

exports.healthCheck = (req, res, next) => {
  db.connect()
    .then(_ => {
      return res.status(200).end();
    })
    .catch(error => {
      console.log("db connection failed", error);
      return res.status(500).end();
    });
};
