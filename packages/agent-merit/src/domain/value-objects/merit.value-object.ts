export class Merit {
  private readonly _value: number;

  constructor(value: number) {
    if (value < 0 || value > 1) {
      throw new Error('Merit value must be between 0 and 1');
    }
    this._value = value;
  }

  get value(): number {
    return this._value;
  }

  updateFromAssessment(outcome: 'KEPT' | 'BROKEN', assessorMerit: Merit): Merit {
    const weight = assessorMerit.value;
    const adjustment = outcome === 'KEPT' ? 0.1 : -0.1;
    const weightedAdjustment = adjustment * weight;
    
    const newValue = Math.max(0, Math.min(1, this._value + weightedAdjustment));
    return new Merit(newValue);
  }

  add(other: Merit): Merit {
    return new Merit(Math.min(1, this._value + other._value));
  }

  subtract(other: Merit): Merit {
    return new Merit(Math.max(0, this._value - other._value));
  }

  multiply(factor: number): Merit {
    return new Merit(Math.max(0, Math.min(1, this._value * factor)));
  }

  toString(): string {
    return this._value.toFixed(3);
  }
}