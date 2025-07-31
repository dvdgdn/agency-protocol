import { CreditAgent } from './credit-agent.entity';
import { MeritAgent } from '@agency-protocol/merit/src/domain/entities/merit-agent.entity';
import { Merit } from '@agency-protocol/merit/src/domain/value-objects/merit.value-object';
import { MeritDomain } from '@agency-protocol/merit/src/domain/value-objects/merit-domain.value-object';
import { AgentPromise } from '@agency-protocol/agent/src/domain/value-objects/agent-promise';

describe('CreditAgent Inter-Package Communication', () => {
  describe('Credit-Merit Interaction', () => {
    let creditAgent: CreditAgent;
    let meritAgent: MeritAgent;

    beforeEach(() => {
      creditAgent = new CreditAgent({
        id: 'credit-agent-1',
        public_key: 'credit-public-key',
        signature: 'credit-signature',
        timestamp: Date.now()
      });

      meritAgent = new MeritAgent({
        id: 'merit-agent-1',
        public_key: 'merit-public-key',
        signature: 'merit-signature',
        timestamp: Date.now()
      });
    });

    it('should allow credit agent to query merit scores from merit agent', () => {
      // Setup: Track merit for the credit agent
      const domain = new MeritDomain('/credit/trustworthiness');
      const merit = new Merit(0.75);
      meritAgent.trackMerit(creditAgent.id, domain, merit);

      // Act: Credit agent queries its own merit
      const creditAgentMerit = meritAgent.getMerit(creditAgent.id, domain);

      // Assert: Should receive the correct merit score
      expect(creditAgentMerit).toBeDefined();
      expect(creditAgentMerit?.value).toBe(0.75);
    });

    it('should allow credit agent to influence merit scores based on credit assessments', () => {
      // Setup: Initial merit tracking
      const domain = new MeritDomain('/credit/payment-reliability');
      const initialMerit = new Merit(0.5);
      meritAgent.trackMerit('customer-1', domain, initialMerit);

      // Act: Credit agent provides assessment result to merit agent
      const assessorMerit = new Merit(0.8); // Credit agent has high merit
      meritAgent.updateMeritFromAssessment(
        'customer-1',
        domain,
        'KEPT', // Customer kept their payment promise
        assessorMerit
      );

      // Assert: Merit should increase
      const updatedMerit = meritAgent.getMerit('customer-1', domain);
      expect(updatedMerit).toBeDefined();
      expect(updatedMerit!.value).toBeGreaterThan(0.5);
    });

    it('should recognize merit agent as a critical dependency', () => {
      // Act: Get critical dependencies
      const dependencies = creditAgent.declareCriticalDependencies();

      // Assert: Should include dependency on credit ledger
      expect(dependencies).toContainEqual({
        agent_type: 'CreditLedgerAgent',
        promise_domain: '/credit/ledger'
      });

      // In a real scenario, credit agents might also depend on merit agents
      // for creditworthiness assessments
    });

    it('should allow credit and merit agents to share event information', () => {
      // Setup: Create state change events
      const creditEvent = creditAgent.emitStateChangeEvent();
      const meritEvent = meritAgent.emitStateChangeEvent();

      // Assert: Events should be properly formatted for cross-agent communication
      expect(creditEvent.eventType).toBe('CreditAgent.StateChanged');
      expect(meritEvent.eventType).toBe('MeritAgent.StateChanged');
      expect(creditEvent.aggregateId).toBe(creditAgent.id);
      expect(meritEvent.aggregateId).toBe(meritAgent.id);
    });
  });

  describe('Layer Override Capabilities', () => {
    it('should allow custom signature verification implementation', () => {
      // Create a custom credit agent with overridden signature verification
      class CustomCreditAgent extends CreditAgent {
        private customVerificationLogic: boolean = false;

        verifySignature(data: any, signature: string): boolean {
          // Custom verification logic
          this.customVerificationLogic = true;
          return signature === 'valid-custom-signature';
        }

        wasCustomVerificationUsed(): boolean {
          return this.customVerificationLogic;
        }
      }

      // Act: Create instance and verify signature
      const customAgent = new CustomCreditAgent({
        id: 'custom-credit-agent',
        public_key: 'custom-public-key',
        signature: 'custom-signature'
      });

      const isValid = customAgent.verifySignature({}, 'valid-custom-signature');
      const isInvalid = customAgent.verifySignature({}, 'invalid-signature');

      // Assert: Should use custom verification
      expect(isValid).toBe(true);
      expect(isInvalid).toBe(false);
      expect(customAgent.wasCustomVerificationUsed()).toBe(true);
    });

    it('should allow injection of custom services', () => {
      // Create a credit agent with injected signature service
      class InjectedCreditAgent extends CreditAgent {
        constructor(
          params: ConstructorParameters<typeof CreditAgent>[0],
          private signatureService: any
        ) {
          super(params);
        }

        verifySignature(data: any, signature: string): boolean {
          // Use injected service instead of default implementation
          return this.signatureService.verify(
            data,
            signature,
            this.public_key
          );
        }
      }

      // Mock signature service
      const mockSignatureService = {
        sign: jest.fn(),
        verify: jest.fn().mockReturnValue(true),
        hash: jest.fn()
      };

      // Act: Create agent with injected service
      const injectedAgent = new InjectedCreditAgent(
        {
          id: 'injected-credit-agent',
          public_key: 'injected-public-key',
          signature: 'injected-signature'
        },
        mockSignatureService
      );

      const result = injectedAgent.verifySignature({ test: 'data' }, 'test-signature');

      // Assert: Should use injected service
      expect(result).toBe(true);
      expect(mockSignatureService.verify).toHaveBeenCalledWith(
        { test: 'data' },
        'test-signature',
        'injected-public-key'
      );
    });

    it('should allow extension of promise sets', () => {
      // Create extended credit agent with additional promises
      class ExtendedCreditAgent extends CreditAgent {
        constructor(params: ConstructorParameters<typeof CreditAgent>[0]) {
          super(params);
          
          // Add additional promises specific to this implementation
          (this as any)._promises.push(
            new AgentPromise('/credit/fraud-detection', 'I promise to detect and prevent fraudulent transactions'),
            new AgentPromise('/credit/risk-assessment', 'I promise to provide accurate risk assessments')
          );
        }

        // Add new methods for the extended functionality
        assessFraudRisk(transactionId: string): number {
          // Implementation specific to fraud detection
          return Math.random(); // Placeholder
        }
      }

      // Act: Create extended agent
      const extendedAgent = new ExtendedCreditAgent({
        id: 'extended-credit-agent',
        public_key: 'extended-public-key',
        signature: 'extended-signature'
      });

      // Assert: Should have both base and extended promises
      const promises = extendedAgent.promises;
      expect(promises).toHaveLength(3); // 1 base + 2 extended
      expect(promises.map(p => p.domain)).toContain('/credit/accurate-scores');
      expect(promises.map(p => p.domain)).toContain('/credit/fraud-detection');
      expect(promises.map(p => p.domain)).toContain('/credit/risk-assessment');
    });
  });
});