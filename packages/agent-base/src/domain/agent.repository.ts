import type { Agent } from './entities/agent.entity';

export interface IAgentRepository {
  findById(id: string): Promise<Agent | null>;
  findAll(): Promise<Agent[]>;
  create(agent: Agent): Promise<Agent>;
  update(id: string, agent: Partial<Agent>): Promise<Agent>;
  delete(id: string): Promise<void>;
}