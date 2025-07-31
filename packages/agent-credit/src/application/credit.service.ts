import type { CreditData } from '../domain/credit.types';

/**
 * Returns a list of credit agent data. Stub implementation for demo purposes.
 */
export function getCreditData(): CreditData[] {
  return [
    { agentId: 'credit-001', credit: 500 },
    { agentId: 'credit-002', credit: 300 },
  ];
}
