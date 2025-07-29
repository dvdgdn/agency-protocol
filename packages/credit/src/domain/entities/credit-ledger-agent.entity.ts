import { CreditAgent } from './credit-agent.entity';
import { Credit } from '../value-objects/credit.value-object';
import { Transaction } from '../value-objects/transaction.value-object';
import { AgentPromise, DomainEvent } from '@agency-protocol/agent';

export class CreditLedgerAgent extends CreditAgent {
  private readonly ledger: Map<string, Credit> = new Map();
  private readonly transactions: Transaction[] = [];

  constructor(params: {
    id: string;
    public_key: string;
    signature: string;
    previous_version_cid?: string;
    timestamp?: number;
  }) {
    super(params);
    
    // Add ledger-specific promises
    const ledgerPromises: AgentPromise[] = [
      new AgentPromise('/credit/ledger/immutable-records', 'I promise to maintain immutable records of credits/debits', 'CreditAgent'),
      new AgentPromise('/credit/ledger/transaction-history', 'I promise to provide transaction history to authorised parties', 'CreditAgent'),
      new AgentPromise('/credit/ledger/fraud-detection', 'I promise to enforce transaction rules and detect fraud', 'CreditAgent')
    ];
    
    this._promises.push(...ledgerPromises);
  }

  // Credit ledger specific methods
  getBalance(agentId: string): Credit {
    return this.ledger.get(agentId) || new Credit(0);
  }

  transfer(from: string, to: string, amount: Credit): Transaction {
    const fromBalance = this.getBalance(from);
    const toBalance = this.getBalance(to);

    if (fromBalance.isLessThan(amount)) {
      throw new Error('Insufficient credits');
    }

    const transaction = new Transaction(from, to, amount, Date.now());
    
    this.ledger.set(from, fromBalance.subtract(amount));
    this.ledger.set(to, toBalance.add(amount));
    this.transactions.push(transaction);

    this.emitStateChangeEvent();
    return transaction;
  }

  getTransactionHistory(agentId: string, limit: number = 100): Transaction[] {
    return this.transactions
      .filter(tx => tx.from === agentId || tx.to === agentId)
      .slice(-limit);
  }

  lockStake(agentId: string, amount: Credit): void {
    const balance = this.getBalance(agentId);
    if (balance.isLessThan(amount)) {
      throw new Error('Insufficient credits for stake');
    }
    
    // Create a lock transaction (to a special stake address)
    const stakeTransaction = new Transaction(agentId, `stake:${agentId}`, amount, Date.now());
    this.ledger.set(agentId, balance.subtract(amount));
    this.transactions.push(stakeTransaction);
  }

  releaseStake(agentId: string, amount: Credit): void {
    const stakeKey = `stake:${agentId}`;
    const stakedAmount = this.ledger.get(stakeKey) || new Credit(0);
    
    if (stakedAmount.isLessThan(amount)) {
      throw new Error('Insufficient staked amount');
    }

    const currentBalance = this.getBalance(agentId);
    this.ledger.set(agentId, currentBalance.add(amount));
    this.ledger.set(stakeKey, stakedAmount.subtract(amount));
    
    const releaseTransaction = new Transaction(stakeKey, agentId, amount, Date.now());
    this.transactions.push(releaseTransaction);
  }

  override emitStateChangeEvent(): DomainEvent {
    return {
      aggregateId: this.id,
      eventType: 'CreditLedgerAgent.StateChanged',
      eventData: {
        totalTransactions: this.transactions.length,
        activeAccounts: this.ledger.size
      },
      timestamp: Date.now(),
      version: 1
    };
  }
}