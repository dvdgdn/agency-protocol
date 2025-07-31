import { CreditAgent } from './credit-agent.entity';
import { Credit } from '../value-objects/credit.value-object';
import { Transaction } from '../value-objects/transaction.value-object';
import { DomainEvent } from '@agency-protocol/agent';
export declare class CreditLedgerAgent extends CreditAgent {
    private readonly ledger;
    private readonly transactions;
    constructor(params: {
        id: string;
        public_key: string;
        signature: string;
        previous_version_cid?: string;
        timestamp?: number;
    });
    getBalance(agentId: string): Credit;
    transfer(from: string, to: string, amount: Credit): Transaction;
    getTransactionHistory(agentId: string, limit?: number): Transaction[];
    lockStake(agentId: string, amount: Credit): void;
    releaseStake(agentId: string, amount: Credit): void;
    emitStateChangeEvent(): DomainEvent;
}
//# sourceMappingURL=credit-ledger-agent.entity.d.ts.map