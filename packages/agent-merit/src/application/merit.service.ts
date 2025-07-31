import type { MeritData } from '../domain/merit.types';

/**
 * Returns a list of merit agent data. Stub implementation for demo purposes.
 */
export function getMeritData(): MeritData[] {
  return [
    { agentId: 'merit-001', meritScore: 1250, lastUpdated: new Date().toISOString() },
    { agentId: 'merit-002', meritScore: 875, lastUpdated: new Date().toISOString() },
  ];
}
