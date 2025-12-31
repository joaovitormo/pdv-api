import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { WinstonModule } from 'nest-winston';
import { AllExceptionsFilter } from './common/filters/all-exceptions.filter';
import { LoggingInterceptor } from './config/logging.interceptor';
import { rateLimitLoginMiddleware } from './config/rate-limit.config';
import { logger } from './config/logger';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {
    logger: WinstonModule.createLogger({
      instance: logger,
    }),
  });

  app.useGlobalPipes(new ValidationPipe({
    whitelist: true,
    forbidNonWhitelisted: true,
    transform: true,
    transformOptions: {
      enableImplicitConversion: true,
    },
  }));

  app.useGlobalFilters(new AllExceptionsFilter());

  app.useGlobalInterceptors(new LoggingInterceptor());

  app.enableCors({
    origin: process.env.CORS_ORIGIN || '*',
    credentials: true,
  });

  app.use('/api/auth/login', rateLimitLoginMiddleware());
  app.use('/api/auth/register', rateLimitLoginMiddleware());

  app.setGlobalPrefix('api');

  const port = process.env.PORT || 3001;
  await app.listen(port);

  logger.info(`🚀 Application is running on: http://localhost:${port}`, 'Bootstrap');
  logger.info(`📚 Environment: ${process.env.NODE_ENV || 'development'}`, 'Bootstrap');
  logger.info(`📊 Health check: http://localhost:${port}/api/health`, 'Bootstrap');
  logger.info(`📋 Endpoints mapped: 35+`, 'Bootstrap');
  logger.info(`🔒 Rate Limit: 5 tentativas por 15 minutos para login/register`, 'Bootstrap');
}

bootstrap().catch(err => {
  logger.error('Failed to start application', err);
  process.exit(1);
});
