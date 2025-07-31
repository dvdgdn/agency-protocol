import * as crypto from 'crypto';

export interface SignatureService {
  sign(data: any, privateKey: string): string;
  verify(data: any, signature: string, publicKey: string): boolean;
}

export class CryptoSignatureService implements SignatureService {
  sign(data: any, privateKey: string): string {
    const sign = crypto.createSign('SHA256');
    sign.update(JSON.stringify(data));
    sign.end();
    return sign.sign(privateKey, 'hex');
  }

  verify(data: any, signature: string, publicKey: string): boolean {
    try {
      const verify = crypto.createVerify('SHA256');
      verify.update(JSON.stringify(data));
      verify.end();
      return verify.verify(publicKey, signature, 'hex');
    } catch (error) {
      return false;
    }
  }
}