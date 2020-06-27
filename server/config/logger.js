const winston = require('winston')
const { format, transports, createLogger } = winston
const { combine, timestamp, errors, label, printf, splat, colorize } = format;

const customFormat = printf(info => {
  // printf can't print objects
  if (typeof info.message === 'object') {
    info.message = JSON.stringify(info.message, null, 2)
  }
  return `${info.timestamp} ${info.level} [${info.label}]: ${info.message}`
})

module.exports = (sourceLabel) => {
  return createLogger({
    transports: [
      new transports.Console()
    ],
    format: combine(
      label({ label: sourceLabel }),
      colorize(),
      timestamp(),
      errors({ stack: true }),
      splat(),
      customFormat,
    ),
    exitOnError: false
  });
}