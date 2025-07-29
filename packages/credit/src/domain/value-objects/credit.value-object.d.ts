export declare class Credit {
    private readonly _amount;
    constructor(amount: number);
    get amount(): number;
    add(other: Credit): Credit;
    subtract(other: Credit): Credit;
    multiply(factor: number): Credit;
    divide(divisor: number): Credit;
    isGreaterThan(other: Credit): boolean;
    isLessThan(other: Credit): boolean;
    equals(other: Credit): boolean;
    toString(): string;
}
//# sourceMappingURL=credit.value-object.d.ts.map