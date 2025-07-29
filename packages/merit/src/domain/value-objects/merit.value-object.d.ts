export declare class Merit {
    private readonly _value;
    constructor(value: number);
    get value(): number;
    updateFromAssessment(outcome: 'KEPT' | 'BROKEN', assessorMerit: Merit): Merit;
    add(other: Merit): Merit;
    subtract(other: Merit): Merit;
    multiply(factor: number): Merit;
    toString(): string;
}
//# sourceMappingURL=merit.value-object.d.ts.map