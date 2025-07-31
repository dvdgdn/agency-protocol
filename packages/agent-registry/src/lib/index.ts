import React from 'react';
import { MeritView } from '@agency-protocol/agent-merit-ui';
import { CreditView } from '@agency-protocol/agent-credit-ui';

// Define a type for our UI components
type AgentComponent = React.ComponentType<any>;

// The registry maps agent types to their UI components
export const uiRegistry: Record<string, AgentComponent> = {
  'MeritAgent': MeritView,
  'CreditAgent': CreditView,
};