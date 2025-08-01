import React from 'react';
import { Card } from '@agency-protocol/agent-ui-core';
import type { CreditData } from '@agency-protocol/agent-credit';

export const CreditView = ({ agentId, credit }: CreditData) => {
  return (
    <Card title={`Credit View: ${agentId}`}>
      <p style={{ 
        fontSize: '2.5em', 
        textAlign: 'center', 
        margin: 0, 
        fontWeight: 'bold', 
        color: '#4caf50' 
      }}>
        {credit} credits
      </p>
    </Card>
  );
};