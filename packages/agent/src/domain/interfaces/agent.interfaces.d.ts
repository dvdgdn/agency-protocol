export interface AgentState {
    id: string;
    public_key: string;
    previous_version_cid?: string;
    timestamp: number;
}
export interface AgentDependency {
    agent_type: string;
    promise_domain?: string;
}
export interface FailureReason {
    code: string;
    context: any;
}
export interface AgentPromiseDefinition {
    domain: string;
    description: string;
    inherited_from?: string;
}
export interface AgentRepository {
    save(agent: any): Promise<void>;
    findById(id: string): Promise<any | null>;
    findByType(type: string): Promise<any[]>;
    findByPromiseDomain(domain: string): Promise<any[]>;
}
//# sourceMappingURL=agent.interfaces.d.ts.map