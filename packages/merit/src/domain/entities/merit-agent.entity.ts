import { Agent, AgentState, AgentDependency, FailureReason, DomainEvent, AgentPromise } from '@agency-protocol/agent';
import { Merit } from '../value-objects/merit.value-object';
import { MeritDomain } from '../value-objects/merit-domain.value-object';

export class MeritAgent extends Agent {
  private readonly meritScores: Map<string, Merit> = new Map();

  constructor(params: {
    id: string;
    public_key: string;
    signature: string;
    previous_version_cid?: string;
    timestamp?: number;
  }) {
    const meritPromises: AgentPromise[] = [
      new AgentPromise('/merit/tracking', 'I promise to track and validate merit across the system'),
      new AgentPromise('/merit/domain-specific', 'I promise to track domain-specific merit for agents'),
      new AgentPromise('/merit/assessment-updates', 'I promise to update merit from assessments; weight by assessor merit'),
      new AgentPromise('/merit/historical-accountability', 'I promise to maintain historical accountability')
    ];

    super({
      ...params,
      agent_type: 'MeritAgent',
      parent_type: 'Agent',
      promises: meritPromises
    });
  }

  // Merit-specific methods
  trackMerit(agentId: string, domain: MeritDomain, value: Merit): void {
    const key = `${agentId}:${domain.toString()}`;
    this.meritScores.set(key, value);
    this.emitStateChangeEvent();
  }

  getMerit(agentId: string, domain: MeritDomain): Merit | undefined {
    const key = `${agentId}:${domain.toString()}`;
    return this.meritScores.get(key);
  }

  updateMeritFromAssessment(
    agentId: string,
    domain: MeritDomain,
    assessmentOutcome: 'KEPT' | 'BROKEN',
    assessorMerit: Merit
  ): void {
    const currentMerit = this.getMerit(agentId, domain) || new Merit(0.5); // Start at neutral
    const updatedMerit = currentMerit.updateFromAssessment(assessmentOutcome, assessorMerit);
    this.trackMerit(agentId, domain, updatedMerit);
  }

  // Implement abstract methods
  verifySignature(data: any, signature: string): boolean {
    // Would use injected signature service
    return true; // Placeholder
  }

  emitStateChangeEvent(): DomainEvent {
    return {
      aggregateId: this.id,
      eventType: 'MeritAgent.StateChanged',
      eventData: {
        meritScores: Array.from(this.meritScores.entries()).map(([key, value]) => ({
          key,
          value: value.value
        }))
      },
      timestamp: Date.now(),
      version: 1
    };
  }

  respondToStateQuery(): AgentState {
    return {
      id: this.id,
      public_key: this.public_key,
      previous_version_cid: this.previous_version_cid,
      timestamp: this.timestamp
    };
  }

  declareCriticalDependencies(): AgentDependency[] {
    return [
      { agent_type: 'AssessmentAgent', promise_domain: '/assessment/evaluation' },
      { agent_type: 'MeritLedgerAgent', promise_domain: '/merit/ledger' }
    ];
  }

  emitFailureEvent(promise: string, reason: FailureReason): DomainEvent {
    return {
      aggregateId: this.id,
      eventType: 'MeritAgent.PromiseFailed',
      eventData: {
        promise,
        reason
      },
      timestamp: Date.now(),
      version: 1
    };
  }
}