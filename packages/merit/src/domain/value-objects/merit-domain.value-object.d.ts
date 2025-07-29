export declare class MeritDomain {
    private readonly domain;
    constructor(domain: string);
    toString(): string;
    isSubdomainOf(parent: MeritDomain): boolean;
    getParent(): MeritDomain | null;
    equals(other: MeritDomain): boolean;
}
//# sourceMappingURL=merit-domain.value-object.d.ts.map