export interface AgentAPI {
    GET: {
        '/agents/:id': (id: string) => Promise<any>;
        '/agents': (query: {
            type?: string;
            domain?: string;
        }) => Promise<any[]>;
    };
    POST: {
        '/agents': (body: {
            type: string;
            publicKey: string;
            signature: string;
        }) => Promise<{
            id: string;
        }>;
    };
    PUT: {
        '/agents/:id': (id: string, body: any) => Promise<void>;
    };
}
export declare class AgentAPIImplementation {
    private readonly agentService;
    constructor(agentService: any);
    getAgent(id: string): Promise<any>;
    listAgents(query: {
        type?: string;
        domain?: string;
    }): Promise<any[]>;
    createAgent(body: {
        type: string;
        publicKey: string;
        signature: string;
    }): Promise<{
        id: string;
    }>;
    updateAgent(id: string, body: any): Promise<void>;
}
//# sourceMappingURL=agent-api.d.ts.map