import { ContentAddressable } from '../value-objects/content-addressable';
import { AgentPromise } from '../value-objects/agent-promise';
import { AgentState, AgentDependency, FailureReason } from '../interfaces/agent.interfaces';
import { DomainEvent } from '../events/domain-event';
export declare abstract class Agent extends ContentAddressable {
    protected readonly _id: string;
    protected readonly _public_key: string;
    protected readonly _previous_version_cid?: string;
    protected readonly _signature: string;
    protected readonly _timestamp: number;
    protected readonly _agent_type: string;
    protected readonly _parent_type?: string;
    protected readonly _promises: AgentPromise[];
    constructor(params: {
        id: string;
        public_key: string;
        signature: string;
        agent_type: string;
        parent_type?: string;
        previous_version_cid?: string;
        promises?: AgentPromise[];
        timestamp?: number;
    });
    abstract verifySignature(data: any, signature: string): boolean;
    abstract emitStateChangeEvent(): DomainEvent;
    abstract respondToStateQuery(): AgentState;
    abstract declareCriticalDependencies(): AgentDependency[];
    abstract emitFailureEvent(promise: string, reason: FailureReason): DomainEvent;
    get id(): string;
    get public_key(): string;
    get signature(): string;
    get agent_type(): string;
    get parent_type(): string | undefined;
    get previous_version_cid(): string | undefined;
    get promises(): readonly AgentPromise[];
    get timestamp(): number;
}
//# sourceMappingURL=agent.entity.d.ts.map