import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';

interface RateLimitEntry {
  count: number;
  resetTime: number;
}

const globalStore: Map<string, RateLimitEntry> = new Map();
const loginStore: Map<string, RateLimitEntry> = new Map();

@Injectable()
export class RateLimitMiddleware implements NestMiddleware {
  private readonly maxRequests = 100; 
  private readonly windowMs = 15 * 60 * 1000; 

  use(req: Request, res: Response, next: NextFunction) {
    const key = this.getClientIp(req);
    const now = Date.now();

    let entry = globalStore.get(key);

    if (!entry || now > entry.resetTime) {
      entry = {
        count: 0,
        resetTime: now + this.windowMs,
      };
      globalStore.set(key, entry);
    }

    entry.count++;

    res.setHeader('X-RateLimit-Limit', this.maxRequests);
    res.setHeader('X-RateLimit-Remaining', Math.max(0, this.maxRequests - entry.count));
    res.setHeader('X-RateLimit-Reset', new Date(entry.resetTime).toISOString());

    if (entry.count > this.maxRequests) {
      return res.status(429).json({
        statusCode: 429,
        message: 'Muitas requisições. Por favor tente novamente mais tarde.',
        retryAfter: Math.ceil((entry.resetTime - now) / 1000),
      });
    }

    next();
  }

  private getClientIp(req: Request): string {
    return (
      (req.headers['x-forwarded-for'] as string)?.split(',')[0].trim() ||
      (req.headers['x-real-ip'] as string) ||
      req.socket.remoteAddress ||
      'unknown'
    );
  }
}

export function rateLimitLoginMiddleware() {
  const maxRequests = 5; 
  const windowMs = 15 * 60 * 1000; 

  return (req: Request, res: Response, next: NextFunction) => {
    const clientIp = getClientIp(req);
    const key = `${clientIp}:${req.path}`;
    const now = Date.now();

    let entry = loginStore.get(key);

    if (!entry || now > entry.resetTime) {
      entry = {
        count: 0,
        resetTime: now + windowMs,
      };
      loginStore.set(key, entry);
    }

    entry.count++;

    res.setHeader('X-RateLimit-Limit', maxRequests);
    res.setHeader('X-RateLimit-Remaining', Math.max(0, maxRequests - entry.count));
    res.setHeader('X-RateLimit-Reset', new Date(entry.resetTime).toISOString());

    if (entry.count > maxRequests) {
      return res.status(429).json({
        statusCode: 429,
        message: 'Muitas tentativas de login. Por favor tente novamente mais tarde.',
        retryAfter: Math.ceil((entry.resetTime - now) / 1000),
      });
    }

    next();
  };
}

function getClientIp(req: Request): string {
  return (
    (req.headers['x-forwarded-for'] as string)?.split(',')[0].trim() ||
    (req.headers['x-real-ip'] as string) ||
    req.socket.remoteAddress ||
    'unknown'
  );
}

@Injectable()
export class StrictRateLimitMiddleware implements NestMiddleware {
  private readonly maxRequests = 5; 
  private readonly windowMs = 15 * 60 * 1000; 
  use(req: Request, res: Response, next: NextFunction) {
    const key = `${this.getClientIp(req)}:${req.path}`;
    const now = Date.now();

    let entry = loginStore.get(key);

    if (!entry || now > entry.resetTime) {
      entry = {
        count: 0,
        resetTime: now + this.windowMs,
      };
      loginStore.set(key, entry);
    }

    entry.count++;

    res.setHeader('X-RateLimit-Limit', this.maxRequests);
    res.setHeader('X-RateLimit-Remaining', Math.max(0, this.maxRequests - entry.count));
    res.setHeader('X-RateLimit-Reset', new Date(entry.resetTime).toISOString());

    if (entry.count > this.maxRequests) {
      return res.status(429).json({
        statusCode: 429,
        message: 'Muitas tentativas de login. Por favor tente novamente mais tarde.',
        retryAfter: Math.ceil((entry.resetTime - now) / 1000),
      });
    }

    next();
  }

  private getClientIp(req: Request): string {
    return (
      (req.headers['x-forwarded-for'] as string)?.split(',')[0].trim() ||
      (req.headers['x-real-ip'] as string) ||
      req.socket.remoteAddress ||
      'unknown'
    );
  }
}
