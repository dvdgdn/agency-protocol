import { Credit } from './credit.value-object';
export declare class Transaction {
    readonly from: string;
    readonly to: string;
    readonly amount: Credit;
    readonly timestamp: number;
    readonly id: string;
    constructor(from: string, to: string, amount: Credit, timestamp: number, id?: string);
    toString(): string;
}
//# sourceMappingURL=transaction.value-object.d.ts.map