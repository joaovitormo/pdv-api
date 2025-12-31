import { Injectable, NestInterceptor, ExecutionContext, CallHandler, Logger } from '@nestjs/common';
import { Observable } from 'rxjs';
import { tap, catchError } from 'rxjs/operators';
import { Request, Response } from 'express';

@Injectable()
export class LoggingInterceptor implements NestInterceptor {
  private readonly logger = new Logger(LoggingInterceptor.name);

  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const request = context.switchToHttp().getRequest<Request>();
    const response = context.switchToHttp().getResponse<Response>();

    const { method, url, ip, body, query, params } = request;
    const userAgent = request.get('user-agent') || '';
    const contentLength = request.get('content-length');

    const startTime = Date.now();

    return next.handle().pipe(
      tap((responseData) => {
        const duration = Date.now() - startTime;
        const statusCode = response.statusCode;
        const isError = statusCode >= 400;

        this.logger.log({
          timestamp: new Date().toISOString(),
          method,
          url,
          statusCode,
          duration: `${duration}ms`,
          ip,
          userAgent,
          ...(isError && { error: responseData?.message }),
        });
      }),
      catchError((error) => {
        const duration = Date.now() - startTime;
        const statusCode = error.status || 500;

        this.logger.error({
          timestamp: new Date().toISOString(),
          method,
          url,
          statusCode,
          duration: `${duration}ms`,
          ip,
          userAgent,
          error: error.message,
          stack: error.stack,
        });

        throw error;
      }),
    );
  }
}
