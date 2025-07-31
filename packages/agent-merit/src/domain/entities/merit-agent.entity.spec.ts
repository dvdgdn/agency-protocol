import { MeritAgent } from './merit-agent.entity';
import { Merit } from '../value-objects/merit.value-object';
import { MeritDomain } from '../value-objects/merit-domain.value-object';
import { CreditAgent } from '@agency-protocol/credit/src/domain/entities/credit-agent.entity';
import { CreditLedgerAgent } from '@agency-protocol/credit/src/domain/entities/credit-ledger-agent.entity';
import { Credit } from '@agency-protocol/credit/src/domain/value-objects/credit.value-object';
import { Transaction } from '@agency-protocol/credit/src/domain/value-objects/transaction.value-object';
import { AgentPromise } from '@agency-protocol/agent/src/domain/value-objects/agent-promise';

describe('MeritAgent Inter-Package Communication', () => {
  describe('Merit-Credit Interaction', () => {
    let meritAgent: MeritAgent;
    let creditAgent: CreditAgent;
    let creditLedgerAgent: CreditLedgerAgent;

    beforeEach(() => {
      meritAgent = new MeritAgent({
        id: 'merit-agent-1',
        public_key: 'merit-public-key',
        signature: 'merit-signature',
        timestamp: Date.now()
      });

      creditAgent = new CreditAgent({
        id: 'credit-agent-1',
        public_key: 'credit-public-key',
        signature: 'credit-signature',
        timestamp: Date.now()
      });

      creditLedgerAgent = new CreditLedgerAgent({
        id: 'credit-ledger-1',
        public_key: 'ledger-public-key',
        signature: 'ledger-signature',
        timestamp: Date.now()
      });
    });

    it('should allow merit agent to influence credit decisions based on merit scores', () => {
      // Setup: Agent has high merit in financial domain
      const financialDomain = new MeritDomain('/finance/reliability');
      const highMerit = new Merit(0.9);
      meritAgent.trackMerit('borrower-1', financialDomain, highMerit);

      // Act: Credit decision considers merit score
      const borrowerMerit = meritAgent.getMerit('borrower-1', financialDomain);
      
      // In a real scenario, credit agent would query merit agent
      const creditDecision = borrowerMerit && borrowerMerit.value > 0.7 
        ? 'approved' 
        : 'rejected';

      // Assert: High merit leads to credit approval
      expect(creditDecision).toBe('approved');
      expect(borrowerMerit?.value).toBe(0.9);
    });

    it('should update merit based on credit transaction outcomes', () => {
      // Setup: Initial merit and credit transaction
      const creditDomain = new MeritDomain('/credit/repayment');
      const initialMerit = new Merit(0.6);
      meritAgent.trackMerit('borrower-1', creditDomain, initialMerit);

      // Create a credit transaction
      const credit = new Credit(1000);
      const transaction = new Transaction(
        'credit-ledger-1',
        'borrower-1',
        credit,
        Date.now(),
        'tx-1'
      );

      // Act: Process credit repayment and update merit
      const wasRepaid = true; // Simulate successful repayment
      if (wasRepaid) {
        // Merit agent receives high merit assessment from credit ledger
        const creditLedgerMerit = new Merit(0.95); // Credit ledger has high merit
        meritAgent.updateMeritFromAssessment(
          'borrower-1',
          creditDomain,
          'KEPT', // Promise to repay was kept
          creditLedgerMerit
        );
      }

      // Assert: Merit should increase after successful repayment
      const updatedMerit = meritAgent.getMerit('borrower-1', creditDomain);
      expect(updatedMerit).toBeDefined();
      expect(updatedMerit!.value).toBeGreaterThan(0.6);
    });

    it('should recognize credit agents as potential dependencies', () => {
      // Act: Get critical dependencies
      const dependencies = meritAgent.declareCriticalDependencies();

      // Assert: Should include assessment-related dependencies
      expect(dependencies).toContainEqual({
        agent_type: 'AssessmentAgent',
        promise_domain: '/assessment/evaluation'
      });

      // Merit agents track merit for all agents, including credit agents
      const creditAgentDomain = new MeritDomain('/agent/reliability');
      const creditAgentMerit = new Merit(0.8);
      meritAgent.trackMerit(creditAgent.id, creditAgentDomain, creditAgentMerit);

      const trackedMerit = meritAgent.getMerit(creditAgent.id, creditAgentDomain);
      expect(trackedMerit?.value).toBe(0.8);
    });

    it('should handle cross-domain merit tracking for credit agents', () => {
      // Setup: Track merit for credit agent across multiple domains
      const domains = [
        new MeritDomain('/credit/accuracy'),
        new MeritDomain('/credit/timeliness'),
        new MeritDomain('/credit/fairness')
      ];

      const merits = [0.85, 0.92, 0.78];

      domains.forEach((domain, index) => {
        meritAgent.trackMerit(creditAgent.id, domain, new Merit(merits[index]));
      });

      // Act: Query merit across all domains
      const meritScores = domains.map(domain => ({
        domain: domain.toString(),
        merit: meritAgent.getMerit(creditAgent.id, domain)?.value
      }));

      // Assert: All merit scores should be tracked
      expect(meritScores).toHaveLength(3);
      expect(meritScores[0].merit).toBe(0.85);
      expect(meritScores[1].merit).toBe(0.92);
      expect(meritScores[2].merit).toBe(0.78);
    });
  });

  describe('Advanced Layer Interactions', () => {
    it('should allow composite agents combining merit and credit functionality', () => {
      // Create a composite agent that extends both merit and credit capabilities
      class MeritCreditAgent extends MeritAgent {
        private creditCapabilities: Map<string, Credit> = new Map();

        trackCredit(agentId: string, credit: Credit): void {
          this.creditCapabilities.set(agentId, credit);
          
          // Update merit based on credit allocation
          const creditDomain = new MeritDomain('/credit/management');
          const currentMerit = this.getMerit(agentId, creditDomain) || new Merit(0.5);
          
          // Higher credit allocation indicates trust, increase merit slightly
          const meritBoost = Math.min(credit.amount / 10000, 0.1);
          const newMeritValue = Math.min(currentMerit.value + meritBoost, 1.0);
          
          this.trackMerit(agentId, creditDomain, new Merit(newMeritValue));
        }

        getCredit(agentId: string): Credit | undefined {
          return this.creditCapabilities.get(agentId);
        }
      }

      // Act: Use composite agent
      const compositeAgent = new MeritCreditAgent({
        id: 'composite-agent-1',
        public_key: 'composite-public-key',
        signature: 'composite-signature'
      });

      const testCredit = new Credit(5000);
      compositeAgent.trackCredit('user-1', testCredit);

      // Assert: Should have both merit and credit capabilities
      const credit = compositeAgent.getCredit('user-1');
      const merit = compositeAgent.getMerit('user-1', new MeritDomain('/credit/management'));

      expect(credit).toBeDefined();
      expect(credit?.amount).toBe(5000);
      expect(merit).toBeDefined();
      expect(merit!.value).toBeGreaterThan(0.5); // Merit increased due to credit allocation
    });

    it('should support event-driven communication between merit and credit systems', () => {
      // Setup: Create event handlers
      const eventLog: any[] = [];

      // Merit agent emits event when merit threshold is crossed
      class EventEmittingMeritAgent extends MeritAgent {
        trackMerit(agentId: string, domain: MeritDomain, value: Merit): void {
          super.trackMerit(agentId, domain, value);
          
          if (value.value > 0.8) {
            const event = {
              type: 'MeritThresholdCrossed',
              agentId,
              domain: domain.toString(),
              merit: value.value,
              timestamp: Date.now()
            };
            eventLog.push(event);
          }
        }
      }

      // Act: Track high merit
      const eventMeritAgent = new EventEmittingMeritAgent({
        id: 'event-merit-agent',
        public_key: 'event-public-key',
        signature: 'event-signature'
      });

      const creditworthyDomain = new MeritDomain('/credit/worthiness');
      eventMeritAgent.trackMerit('high-merit-user', creditworthyDomain, new Merit(0.85));

      // Assert: Event should be emitted
      expect(eventLog).toHaveLength(1);
      expect(eventLog[0].type).toBe('MeritThresholdCrossed');
      expect(eventLog[0].agentId).toBe('high-merit-user');
      expect(eventLog[0].merit).toBe(0.85);
    });

    it('should allow dynamic promise composition based on other agents', () => {
      // Create a merit agent that adds promises based on credit agent presence
      class DynamicMeritAgent extends MeritAgent {
        addCreditRelatedPromises(creditAgent: CreditAgent): void {
          // Add promises that relate to credit agent interaction
          const creditPromises = [
            new AgentPromise(
              '/merit/credit-assessment', 
              'I promise to provide merit assessments for credit decisions'
            ),
            new AgentPromise(
              '/merit/credit-monitoring',
              'I promise to monitor and update merit based on credit behavior'
            )
          ];

          // Add to internal promises
          (this as any)._promises.push(...creditPromises);
        }
      }

      // Act: Create dynamic agent and add credit-related promises
      const dynamicAgent = new DynamicMeritAgent({
        id: 'dynamic-merit-agent',
        public_key: 'dynamic-public-key',
        signature: 'dynamic-signature'
      });

      const creditAgent = new CreditAgent({
        id: 'partner-credit-agent',
        public_key: 'partner-public-key',
        signature: 'partner-signature'
      });

      dynamicAgent.addCreditRelatedPromises(creditAgent);

      // Assert: Should have additional promises
      const promises = dynamicAgent.promises;
      const promiseDomains = promises.map(p => p.domain);
      
      expect(promiseDomains).toContain('/merit/credit-assessment');
      expect(promiseDomains).toContain('/merit/credit-monitoring');
    });
  });
});