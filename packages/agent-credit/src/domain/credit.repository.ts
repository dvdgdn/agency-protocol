import type { CreditData } from './credit.types';

export interface ICreditRepository {
  findByAgentId(agentId: string): Promise<CreditData | null>;
  findAll(): Promise<CreditData[]>;
  create(credit: CreditData): Promise<CreditData>;
  update(id: string, credit: Partial<CreditData>): Promise<CreditData>;
}