import { DomainEvent } from '../../domain/events/domain-event';
export interface EventBus {
    publish(event: DomainEvent): Promise<void>;
    subscribe(eventType: string, handler: (event: DomainEvent) => void): void;
    unsubscribe(eventType: string, handler: (event: DomainEvent) => void): void;
}
export declare class InMemoryEventBus implements EventBus {
    private handlers;
    publish(event: DomainEvent): Promise<void>;
    subscribe(eventType: string, handler: (event: DomainEvent) => void): void;
    unsubscribe(eventType: string, handler: (event: DomainEvent) => void): void;
}
//# sourceMappingURL=event-bus.service.d.ts.map