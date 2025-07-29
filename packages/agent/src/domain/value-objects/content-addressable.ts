import * as crypto from 'crypto';

export abstract class ContentAddressable {
  private readonly _cid: string;

  constructor(content: any) {
    this._cid = this.calculateCID(content);
  }

  private calculateCID(content: any): string {
    const canonicalContent = this.canonicalize(content);
    const hash = crypto.createHash('sha256');
    hash.update(canonicalContent);
    return hash.digest('hex');
  }

  private canonicalize(obj: any): string {
    return JSON.stringify(obj, Object.keys(obj).sort());
  }

  get cid(): string {
    return this._cid;
  }
}