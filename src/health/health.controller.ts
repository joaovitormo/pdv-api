import { Controller, Get } from '@nestjs/common';
import { HealthService } from './health.service';

@Controller('health')
export class HealthController {
  constructor(private healthService: HealthService) {}

  @Get()
  async check() {
    return this.healthService.check();
  }

  @Get('db')
  async checkDatabase() {
    return this.healthService.checkDatabase();
  }

  @Get('live')
  async live() {
    return { status: 'UP', timestamp: new Date().toISOString() };
  }

  @Get('ready')
  async ready() {
    return this.healthService.checkDatabase();
  }
}
