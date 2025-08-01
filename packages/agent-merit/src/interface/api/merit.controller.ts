import { Controller, Get, Param, Post } from '@nestjs/common';
import { MeritService } from '../../application/merit.service';
import type { MeritData } from '../../domain/merit.types';

@Controller('merit')
export class MeritController {
  constructor(private readonly meritService: MeritService) {}

  @Get()
  async getAllMerit(): Promise<MeritData[]> {
    return this.meritService.getMeritData();
  }

  @Get(':agentId')
  async getMeritByAgentId(@Param('agentId') agentId: string): Promise<MeritData | null> {
    return this.meritService.getMeritByAgentId(agentId);
  }

  @Post('seed')
  async seedData(): Promise<{ message: string }> {
    await this.meritService.seedData();
    return { message: 'Merit data seeded successfully' };
  }
}