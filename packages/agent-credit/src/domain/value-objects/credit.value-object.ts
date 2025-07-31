export class Credit {
  private readonly _amount: number;

  constructor(amount: number) {
    if (amount < 0) {
      throw new Error('Credit amount cannot be negative');
    }
    this._amount = Math.floor(amount); // Credits are integers
  }

  get amount(): number {
    return this._amount;
  }

  add(other: Credit): Credit {
    return new Credit(this._amount + other._amount);
  }

  subtract(other: Credit): Credit {
    if (this._amount < other._amount) {
      throw new Error('Cannot subtract more credits than available');
    }
    return new Credit(this._amount - other._amount);
  }

  multiply(factor: number): Credit {
    return new Credit(Math.floor(this._amount * factor));
  }

  divide(divisor: number): Credit {
    if (divisor === 0) {
      throw new Error('Cannot divide by zero');
    }
    return new Credit(Math.floor(this._amount / divisor));
  }

  isGreaterThan(other: Credit): boolean {
    return this._amount > other._amount;
  }

  isLessThan(other: Credit): boolean {
    return this._amount < other._amount;
  }

  equals(other: Credit): boolean {
    return this._amount === other._amount;
  }

  toString(): string {
    return this._amount.toString();
  }
}