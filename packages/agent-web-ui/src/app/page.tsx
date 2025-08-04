'use client';

import React, { useState, useEffect } from 'react';

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

export default function Page() {
  const [agents, setAgents] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const apiUrl = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3001/api';
        
        // Fetch merit data
        const meritResponse = await fetch(`${apiUrl}/merit`);
        if (!meritResponse.ok) {
          throw new Error('Failed to fetch merit data');
        }
        const meritData: MeritData[] = await meritResponse.json();
        
        // Transform merit data into agent format
        const meritAgents = meritData.map(merit => ({
          type: 'MeritAgent',
          data: merit
        }));
        
        // For now, just use merit data. In future, we'll fetch credit data too
        setAgents(meritAgents);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to fetch data');
        // Fall back to mock data if API is not available
        setAgents([
          { type: 'MeritAgent', data: { agentId: 'merit-001', meritScore: 1250, lastUpdated: new Date().toISOString() } },
          { type: 'CreditAgent', data: { agentId: 'credit-001', credit: 500 } },
          { type: 'MeritAgent', data: { agentId: 'merit-002', meritScore: 875, lastUpdated: new Date().toISOString() } },
        ]);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  // Registry
  const uiRegistry: Record<string, React.ComponentType<any>> = {
    'MeritAgent': MeritView,
    'CreditAgent': CreditView,
  };

  return (
    <main style={{ fontFamily: 'sans-serif', padding: '1em 2em' }}>
      <header>
        <h1>Agency Protocol Dashboard</h1>
        <p style={{ color: '#666' }}>Parallel Agent Model Demo</p>
      </header>
      
      {loading && (
        <div style={{ textAlign: 'center', padding: '2em' }}>
          <p>Loading agents...</p>
        </div>
      )}
      
      {error && (
        <div style={{ 
          backgroundColor: '#fff3cd', 
          border: '1px solid #ffeaa7', 
          color: '#856404', 
          padding: '1em', 
          borderRadius: '4px',
          margin: '1em 0'
        }}>
          <strong>Note:</strong> {error}. Using mock data instead.
        </div>
      )}
      
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
      
      {!loading && agents.length === 0 && (
        <div style={{ textAlign: 'center', padding: '2em', color: '#666' }}>
          <p>No agents found. Try seeding the database first.</p>
        </div>
      )}
    </main>
  );
}