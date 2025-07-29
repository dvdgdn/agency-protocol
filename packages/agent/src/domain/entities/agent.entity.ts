import { ContentAddressable } from '../value-objects/content-addressable';
import { AgentPromise } from '../value-objects/agent-promise';
import { AgentState, AgentDependency, FailureReason } from '../interfaces/agent.interfaces';
import { DomainEvent } from '../events/domain-event';

export abstract class Agent extends ContentAddressable {
  protected readonly _id: string;
  protected readonly _public_key: string;
  protected readonly _previous_version_cid?: string;
  protected readonly _signature: string;
  protected readonly _timestamp: number;
  protected readonly _agent_type: string;
  protected readonly _parent_type?: string;
  protected readonly _promises: AgentPromise[] = [];

  constructor(params: {
    id: string;
    public_key: string;
    signature: string;
    agent_type: string;
    parent_type?: string;
    previous_version_cid?: string;
    promises?: AgentPromise[];
    timestamp?: number;
  }) {
    super({
      id: params.id,
      public_key: params.public_key,
      agent_type: params.agent_type,
      parent_type: params.parent_type,
      previous_version_cid: params.previous_version_cid,
      promises: params.promises || [],
      timestamp: params.timestamp || Date.now()
    });

    this._id = params.id;
    this._public_key = params.public_key;
    this._signature = params.signature;
    this._agent_type = params.agent_type;
    this._parent_type = params.parent_type;
    this._previous_version_cid = params.previous_version_cid;
    this._promises = params.promises || [];
    this._timestamp = params.timestamp || Date.now();
  }

  // Core agent promises from the hierarchy
  abstract verifySignature(data: any, signature: string): boolean;
  abstract emitStateChangeEvent(): DomainEvent;
  abstract respondToStateQuery(): AgentState;
  abstract declareCriticalDependencies(): AgentDependency[];
  abstract emitFailureEvent(promise: string, reason: FailureReason): DomainEvent;

  // Getters
  get id(): string { return this._id; }
  get public_key(): string { return this._public_key; }
  get signature(): string { return this._signature; }
  get agent_type(): string { return this._agent_type; }
  get parent_type(): string | undefined { return this._parent_type; }
  get previous_version_cid(): string | undefined { return this._previous_version_cid; }
  get promises(): readonly AgentPromise[] { return [...this._promises]; }
  get timestamp(): number { return this._timestamp; }
}