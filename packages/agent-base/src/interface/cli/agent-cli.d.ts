export interface AgentCLI {
    registerAgent(args: {
        type: string;
        publicKey: string;
    }): Promise<string>;
    queryAgent(agentId: string): Promise<any>;
    listAgentsByType(type: string): Promise<any[]>;
    listAgentsByDomain(domain: string): Promise<any[]>;
}
export declare class AgentCLIImplementation implements AgentCLI {
    private readonly agentService;
    constructor(agentService: any);
    registerAgent(args: {
        type: string;
        publicKey: string;
    }): Promise<string>;
    queryAgent(agentId: string): Promise<any>;
    listAgentsByType(type: string): Promise<any[]>;
    listAgentsByDomain(domain: string): Promise<any[]>;
}
//# sourceMappingURL=agent-cli.d.ts.map