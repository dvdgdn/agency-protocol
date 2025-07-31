export interface DomainEvent {
  aggregateId: string;
  eventType: string;
  eventData: any;
  timestamp: number;
  version: number;
}

export abstract class BaseDomainEvent implements DomainEvent {
  public readonly timestamp: number;

  constructor(
    public readonly aggregateId: string,
    public readonly eventType: string,
    public readonly eventData: any,
    public readonly version: number
  ) {
    this.timestamp = Date.now();
  }
}