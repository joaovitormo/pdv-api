import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class HealthService {
  constructor(private prisma: PrismaService) {}

  async check() {
    const dbHealth = await this.checkDatabase();
    return {
      status: dbHealth.status,
      timestamp: new Date().toISOString(),
      uptime: process.uptime(),
      database: dbHealth,
    };
  }

  async checkDatabase() {
    try {
      await this.prisma.$queryRaw`SELECT 1`;
      return {
        status: 'UP',
        database: 'PostgreSQL',
      };
    } catch (error) {
      return {
        status: 'DOWN',
        database: 'PostgreSQL',
        error: error.message,
      };
    }
  }
}
