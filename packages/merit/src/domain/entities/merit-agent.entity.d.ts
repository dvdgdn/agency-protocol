import { Agent, AgentState, AgentDependency, FailureReason, DomainEvent } from '@agency-protocol/agent';
import { Merit } from '../value-objects/merit.value-object';
import { MeritDomain } from '../value-objects/merit-domain.value-object';
export declare class MeritAgent extends Agent {
    private readonly meritScores;
    constructor(params: {
        id: string;
        public_key: string;
        signature: string;
        previous_version_cid?: string;
        timestamp?: number;
    });
    trackMerit(agentId: string, domain: MeritDomain, value: Merit): void;
    getMerit(agentId: string, domain: MeritDomain): Merit | undefined;
    updateMeritFromAssessment(agentId: string, domain: MeritDomain, assessmentOutcome: 'KEPT' | 'BROKEN', assessorMerit: Merit): void;
    verifySignature(data: any, signature: string): boolean;
    emitStateChangeEvent(): DomainEvent;
    respondToStateQuery(): AgentState;
    declareCriticalDependencies(): AgentDependency[];
    emitFailureEvent(promise: string, reason: FailureReason): DomainEvent;
}
//# sourceMappingURL=merit-agent.entity.d.ts.map