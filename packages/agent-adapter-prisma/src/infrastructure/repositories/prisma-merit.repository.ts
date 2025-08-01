import { prisma } from '../prisma';
import type { MeritData, IMeritRepository } from '@agency-protocol/agent-merit';

export class PrismaMeritRepository implements IMeritRepository {
  async findByAgentId(agentId: string): Promise<MeritData | null> {
    const merit = await prisma.merit.findUnique({
      where: { agentId },
    });

    if (!merit) {
      return null;
    }

    return {
      agentId: merit.agentId,
      meritScore: merit.meritScore,
      lastUpdated: merit.lastUpdated.toISOString(),
    };
  }

  async findAll(): Promise<MeritData[]> {
    const merits = await prisma.merit.findMany();
    
    return merits.map(merit => ({
      agentId: merit.agentId,
      meritScore: merit.meritScore,
      lastUpdated: merit.lastUpdated.toISOString(),
    }));
  }

  async seed() {
    await prisma.merit.upsert({
      where: { agentId: 'merit-001' },
      update: {},
      create: { agentId: 'merit-001', meritScore: 1250 },
    });
    await prisma.merit.upsert({
      where: { agentId: 'merit-002' },
      update: {},
      create: { agentId: 'merit-002', meritScore: 875 },
    });
  }
}