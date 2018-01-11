const config = {
  session_secret: process.env.SESSION_SECRET,
  email: {
    email: process.env.EMAIL,
    pass: process.env.EMAIL_PASS,
  },
  reset_password_expiration: 1000 * 60 * 60, //1 hour in milliseconds
  db: {
    hostname: process.env.DB_HOST,
    username: process.env.DB_USER,
    password: process.env.DB_PASS,
    port: process.env.DB_PORT,
    db_name: process.env.DB_NAME
  },
  client_base_url: process.env.CLIENT_BASE_URL
}

module.exports = config;