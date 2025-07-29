export interface SignatureService {
    sign(data: any, privateKey: string): string;
    verify(data: any, signature: string, publicKey: string): boolean;
}
export declare class CryptoSignatureService implements SignatureService {
    sign(data: any, privateKey: string): string;
    verify(data: any, signature: string, publicKey: string): boolean;
}
//# sourceMappingURL=signature.service.d.ts.map