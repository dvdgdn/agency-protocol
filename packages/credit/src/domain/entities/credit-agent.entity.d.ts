import { Agent, AgentState, AgentDependency, FailureReason, DomainEvent } from '@agency-protocol/agent';
export declare class CreditAgent extends Agent {
    constructor(params: {
        id: string;
        public_key: string;
        signature: string;
        previous_version_cid?: string;
        timestamp?: number;
    });
    verifySignature(data: any, signature: string): boolean;
    emitStateChangeEvent(): DomainEvent;
    respondToStateQuery(): AgentState;
    declareCriticalDependencies(): AgentDependency[];
    emitFailureEvent(promise: string, reason: FailureReason): DomainEvent;
}
//# sourceMappingURL=credit-agent.entity.d.ts.map