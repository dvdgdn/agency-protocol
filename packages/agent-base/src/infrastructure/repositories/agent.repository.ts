import { AgentRepository } from '../../domain/interfaces/agent.interfaces';

export class InMemoryAgentRepository implements AgentRepository {
  private agents: Map<string, any> = new Map();
  private agentsByType: Map<string, Set<string>> = new Map();
  private agentsByDomain: Map<string, Set<string>> = new Map();

  async save(agent: any): Promise<void> {
    this.agents.set(agent.id, agent);

    // Index by type
    if (!this.agentsByType.has(agent.agent_type)) {
      this.agentsByType.set(agent.agent_type, new Set());
    }
    this.agentsByType.get(agent.agent_type)!.add(agent.id);

    // Index by promise domains
    for (const promise of agent.promises) {
      if (!this.agentsByDomain.has(promise.domain)) {
        this.agentsByDomain.set(promise.domain, new Set());
      }
      this.agentsByDomain.get(promise.domain)!.add(agent.id);
    }
  }

  async findById(id: string): Promise<any | null> {
    return this.agents.get(id) || null;
  }

  async findByType(type: string): Promise<any[]> {
    const ids = this.agentsByType.get(type) || new Set();
    return Array.from(ids).map(id => this.agents.get(id)!).filter(Boolean);
  }

  async findByPromiseDomain(domain: string): Promise<any[]> {
    const ids = this.agentsByDomain.get(domain) || new Set();
    return Array.from(ids).map(id => this.agents.get(id)!).filter(Boolean);
  }
}