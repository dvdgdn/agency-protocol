export class MeritDomain {
  constructor(private readonly domain: string) {
    if (!domain || !domain.startsWith('/')) {
      throw new Error('Merit domain must start with /');
    }
  }

  toString(): string {
    return this.domain;
  }

  isSubdomainOf(parent: MeritDomain): boolean {
    return this.domain.startsWith(parent.domain);
  }

  getParent(): MeritDomain | null {
    const parts = this.domain.split('/').filter(p => p);
    if (parts.length <= 1) return null;
    
    const parentPath = '/' + parts.slice(0, -1).join('/');
    return new MeritDomain(parentPath);
  }

  equals(other: MeritDomain): boolean {
    return this.domain === other.domain;
  }
}