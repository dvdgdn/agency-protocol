import { prisma } from '../prisma';
import type { Agent, IAgentRepository } from '@agency-protocol/agent-base';

export class PrismaAgentRepository implements IAgentRepository {
  async findById(id: string): Promise<Agent | null> {
    const agent = await prisma.agent.findUnique({
      where: { id },
    });

    if (!agent) {
      return null;
    }

    return {
      id: agent.id,
      name: agent.name,
      type: agent.type,
      status: agent.status,
      createdAt: agent.createdAt.toISOString(),
      updatedAt: agent.updatedAt.toISOString(),
    } as Agent;
  }

  async findAll(): Promise<Agent[]> {
    const agents = await prisma.agent.findMany();
    
    return agents.map(agent => ({
      id: agent.id,
      name: agent.name,
      type: agent.type,
      status: agent.status,
      createdAt: agent.createdAt.toISOString(),
      updatedAt: agent.updatedAt.toISOString(),
    } as Agent));
  }

  async create(agent: Agent): Promise<Agent> {
    const created = await prisma.agent.create({
      data: {
        id: agent.id,
        name: agent.name,
        type: agent.type,
        status: agent.status,
      },
    });

    return {
      id: created.id,
      name: created.name,
      type: created.type,
      status: created.status,
      createdAt: created.createdAt.toISOString(),
      updatedAt: created.updatedAt.toISOString(),
    } as Agent;
  }

  async update(id: string, agent: Partial<Agent>): Promise<Agent> {
    const updated = await prisma.agent.update({
      where: { id },
      data: {
        name: agent.name,
        type: agent.type,
        status: agent.status,
      },
    });

    return {
      id: updated.id,
      name: updated.name,
      type: updated.type,
      status: updated.status,
      createdAt: updated.createdAt.toISOString(),
      updatedAt: updated.updatedAt.toISOString(),
    } as Agent;
  }

  async delete(id: string): Promise<void> {
    await prisma.agent.delete({
      where: { id },
    });
  }
}