import { Injectable, Inject } from '@nestjs/common';
import type { MeritData } from '../domain/merit.types';
import type { IMeritRepository } from '../domain/merit.repository';
import { MERIT_REPOSITORY_TOKEN } from '../interface/merit.module';

@Injectable()
export class MeritService {
  constructor(
    @Inject(MERIT_REPOSITORY_TOKEN)
    private readonly meritRepository: IMeritRepository
  ) {}

  async getMeritData(): Promise<MeritData[]> {
    return this.meritRepository.findAll();
  }

  async getMeritByAgentId(agentId: string): Promise<MeritData | null> {
    return this.meritRepository.findByAgentId(agentId);
  }

  async seedData(): Promise<void> {
    return this.meritRepository.seed();
  }
}