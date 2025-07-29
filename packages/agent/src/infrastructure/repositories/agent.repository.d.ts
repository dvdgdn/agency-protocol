import { AgentRepository } from '../../domain/interfaces/agent.interfaces';
export declare class InMemoryAgentRepository implements AgentRepository {
    private agents;
    private agentsByType;
    private agentsByDomain;
    save(agent: any): Promise<void>;
    findById(id: string): Promise<any | null>;
    findByType(type: string): Promise<any[]>;
    findByPromiseDomain(domain: string): Promise<any[]>;
}
//# sourceMappingURL=agent.repository.d.ts.map