import React from 'react';
import { Card } from '@agency-protocol/agent-ui-core';
import type { MeritData } from '@agency-protocol/agent-merit';

export const MeritView = ({ agentId, meritScore, lastUpdated }: MeritData) => {
  return (
    <Card title={`Merit View: ${agentId}`}>
      <p style={{ 
        fontSize: '2.5em', 
        textAlign: 'center', 
        margin: 0, 
        fontWeight: 'bold', 
        color: '#1a73e8' 
      }}>
        {meritScore}
      </p>
      <p style={{ 
        fontSize: '0.8em', 
        textAlign: 'center', 
        color: '#777', 
        margin: '0.5em 0 0' 
      }}>
        Last Updated: {new Date(lastUpdated).toLocaleString()}
      </p>
    </Card>
  );
};