import * as winston from 'winston';
import { utilities as nestWinstonModuleUtilities } from 'nest-winston';

const isDevelopment = process.env.NODE_ENV === 'development';

export const logger = winston.createLogger({
  level: isDevelopment ? 'debug' : 'info',
  format: winston.format.combine(
    winston.format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss' }),
    winston.format.errors({ stack: true }),
    winston.format.splat(),
    isDevelopment
      ? nestWinstonModuleUtilities.format.nestLike('PDV API', {
          colors: true,
          prettyPrint: true,
        })
      : winston.format.json(),
  ),
  defaultMeta: {
    service: 'pdv-api',
    environment: process.env.NODE_ENV || 'development',
  },
  transports: [
    new winston.transports.Console({
      format: isDevelopment
        ? winston.format.combine(
            winston.format.colorize(),
            nestWinstonModuleUtilities.format.nestLike('PDV API', {
              colors: true,
              prettyPrint: true,
            }),
          )
        : winston.format.json(),
    }),
    new winston.transports.File({
      filename: 'logs/error.log',
      level: 'error',
      format: winston.format.json(),
    }),
    new winston.transports.File({
      filename: 'logs/combined.log',
      format: winston.format.json(),
    }),
  ],
  exceptionHandlers: [
    new winston.transports.File({
      filename: 'logs/exceptions.log',
      format: winston.format.json(),
    }),
  ],
  rejectionHandlers: [
    new winston.transports.File({
      filename: 'logs/rejections.log',
      format: winston.format.json(),
    }),
  ],
});
