'use client';

import React from 'react';

// Define types inline for now
interface MeritData {
  agentId: string;
  meritScore: number;
  lastUpdated: string;
}

interface CreditData {
  agentId: string;
  credit: number;
}

// Card component
const Card = ({ title, children }: { title: string, children: React.ReactNode }) => {
  return (
    <div style={{ 
      border: '1px solid #eee', 
      borderRadius: '8px', 
      padding: '16px', 
      margin: '1em', 
      boxShadow: '0 2px 4px rgba(0,0,0,0.1)', 
      backgroundColor: 'white' 
    }}>
      <h3 style={{ 
        marginTop: 0, 
        borderBottom: '1px solid #eee', 
        paddingBottom: '0.5em', 
        color: '#333' 
      }}>{title}</h3>
      {children}
    </div>
  );
};

// MeritView component
const MeritView = ({ agentId, meritScore, lastUpdated }: MeritData) => {
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

// CreditView component
const CreditView = ({ agentId, credit }: CreditData) => {
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

// Registry
const uiRegistry: Record<string, React.ComponentType<any>> = {
  'MeritAgent': MeritView,
  'CreditAgent': CreditView,
};

export default function Page() {
  // MOCK DATA: In a real app, this would come from an API call
  // that interacts with your headless agents.
  const agents = [
    { type: 'MeritAgent', data: { agentId: 'merit-001', meritScore: 1250, lastUpdated: new Date().toISOString() } },
    { type: 'CreditAgent', data: { agentId: 'credit-001', credit: 500 } },
    { type: 'MeritAgent', data: { agentId: 'merit-002', meritScore: 875, lastUpdated: new Date().toISOString() } },
  ];

  return (
    <main style={{ fontFamily: 'sans-serif', padding: '1em 2em' }}>
      <header>
        <h1>Agency Protocol Dashboard</h1>
        <p style={{ color: '#666' }}>Parallel Agent Model Demo</p>
      </header>
      <div>
        {agents.map((agent, index) => {
          // Look up the component in the registry
          const Component = uiRegistry[agent.type];

          // If a UI component is registered, render it with its data
          if (Component) {
            return <Component key={index} {...agent.data} />;
          }

          // Handle agents with no registered UI
          return (
            <div key={index} style={{ padding: '1em', margin: '1em', border: '1px dashed #ccc' }}>
              <p>No UI component found for agent type: <strong>{agent.type}</strong></p>
            </div>
          );
        })}
      </div>
    </main>
  );
}