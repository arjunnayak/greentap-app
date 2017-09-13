const pgp = require('pg-promise')();

const dbOptions = {
  host: 'localhost',
  port: 5432,
  database: 'greentap',
  user: 'arjunnayak',
  password: 'speedo'
};

const db = pgp(dbOptions);

module.exports = db;