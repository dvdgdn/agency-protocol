export class AgentPromise {
  constructor(
    public readonly domain: string,
    public readonly description: string,
    public readonly inheritedFrom?: string
  ) {}

  toString(): string {
    return `${this.domain}: ${this.description}`;
  }
}