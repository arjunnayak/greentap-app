const pgp = require('pg-promise')();
const config = require('../app_config')

const { hostname, port, username, password, db_name } = config.db
const dbOptions = {
  host: hostname,
  port: port,
  database: db_name,
  user: username,
  password: password
}

const db = pgp(dbOptions)

module.exports = db