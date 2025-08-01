import { prisma } from '../prisma';
import type { CreditData, ICreditRepository } from '@agency-protocol/agent-credit';

export class PrismaCreditRepository implements ICreditRepository {
  async findByAgentId(agentId: string): Promise<CreditData | null> {
    const credit = await prisma.credit.findUnique({
      where: { agentId },
    });

    if (!credit) {
      return null;
    }

    return {
      id: credit.id,
      agentId: credit.agentId,
      balance: credit.balance,
      currency: credit.currency,
      lastUpdated: credit.lastUpdated.toISOString(),
    };
  }

  async findAll(): Promise<CreditData[]> {
    const credits = await prisma.credit.findMany();
    
    return credits.map(credit => ({
      id: credit.id,
      agentId: credit.agentId,
      balance: credit.balance,
      currency: credit.currency,
      lastUpdated: credit.lastUpdated.toISOString(),
    }));
  }

  async create(credit: CreditData): Promise<CreditData> {
    const created = await prisma.credit.create({
      data: {
        agentId: credit.agentId,
        balance: credit.balance,
        currency: credit.currency,
      },
    });

    return {
      id: created.id,
      agentId: created.agentId,
      balance: created.balance,
      currency: created.currency,
      lastUpdated: created.lastUpdated.toISOString(),
    };
  }

  async update(id: string, credit: Partial<CreditData>): Promise<CreditData> {
    const updated = await prisma.credit.update({
      where: { id },
      data: {
        balance: credit.balance,
        currency: credit.currency,
      },
    });

    return {
      id: updated.id,
      agentId: updated.agentId,
      balance: updated.balance,
      currency: updated.currency,
      lastUpdated: updated.lastUpdated.toISOString(),
    };
  }
}