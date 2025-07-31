import { DomainEvent } from '../../domain/events/domain-event';

export interface EventBus {
  publish(event: DomainEvent): Promise<void>;
  subscribe(eventType: string, handler: (event: DomainEvent) => void): void;
  unsubscribe(eventType: string, handler: (event: DomainEvent) => void): void;
}

export class InMemoryEventBus implements EventBus {
  private handlers: Map<string, Set<(event: DomainEvent) => void>> = new Map();

  async publish(event: DomainEvent): Promise<void> {
    const eventHandlers = this.handlers.get(event.eventType) || new Set();
    for (const handler of eventHandlers) {
      try {
        handler(event);
      } catch (error) {
        console.error(`Error handling event ${event.eventType}:`, error);
      }
    }
  }

  subscribe(eventType: string, handler: (event: DomainEvent) => void): void {
    if (!this.handlers.has(eventType)) {
      this.handlers.set(eventType, new Set());
    }
    this.handlers.get(eventType)!.add(handler);
  }

  unsubscribe(eventType: string, handler: (event: DomainEvent) => void): void {
    const eventHandlers = this.handlers.get(eventType);
    if (eventHandlers) {
      eventHandlers.delete(handler);
    }
  }
}