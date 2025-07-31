export interface DomainEvent {
    aggregateId: string;
    eventType: string;
    eventData: any;
    timestamp: number;
    version: number;
}
export declare abstract class BaseDomainEvent implements DomainEvent {
    readonly aggregateId: string;
    readonly eventType: string;
    readonly eventData: any;
    readonly version: number;
    readonly timestamp: number;
    constructor(aggregateId: string, eventType: string, eventData: any, version: number);
}
//# sourceMappingURL=domain-event.d.ts.map