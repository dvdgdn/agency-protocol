import React, { useEffect, useState } from 'react';

interface Agent {
  id: string;
  name: string;
}

const App: React.FC = () => {
  const [agents, setAgents] = useState<Agent[]>([]);

  useEffect(() => {
    fetch('/api/agents')
      .then(response => response.json())
      .then(data => setAgents(data.agents));
  }, []);

  return (
    <div>
      <h1>Agents</h1>
      <ul>
        {agents.map(agent => (
          <li key={agent.id}>{agent.name}</li>
        ))}
      </ul>
    </div>
  );
};

export default App;
