import { Credit } from './credit.value-object';

export class Transaction {
  constructor(
    public readonly from: string,
    public readonly to: string,
    public readonly amount: Credit,
    public readonly timestamp: number,
    public readonly id: string = generateTransactionId()
  ) {}

  toString(): string {
    return `${this.from} -> ${this.to}: ${this.amount.toString()} credits at ${new Date(this.timestamp).toISOString()}`;
  }
}

function generateTransactionId(): string {
  return `tx_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
}