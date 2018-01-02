const pgp = require('pg-promise')();
const config = require('../app_config')

let dbOptions = null
if(process.env.NODE_ENV === "production") {
  const { hostname, port, username, password, db_name } = config.db
  dbOptions = {
    host: hostname,
    port: port,
    database: db_name,
    user: username,
    password: password
  }
} else {
  dbOptions = {
    host: 'localhost',
    port: 5432,
    database: 'greentap',
    user: 'arjunnayak',
    password: 'speedo'
  }
}

const db = pgp(dbOptions);

module.exports = db;