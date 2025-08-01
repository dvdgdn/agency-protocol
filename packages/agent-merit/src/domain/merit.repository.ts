import type { MeritData } from './merit.types';

export interface IMeritRepository {
  findByAgentId(agentId: string): Promise<MeritData | null>;
  findAll(): Promise<MeritData[]>;
  seed(): Promise<void>;
}