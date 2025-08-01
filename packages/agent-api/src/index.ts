import express from 'express';
import { PrismaMeritRepository } from '@agency-protocol/agent-adapter-prisma';

const app = express();
const port = 3000;

const meritRepo = new PrismaMeritRepository();

// Seed the database with initial data
meritRepo.seed().catch(console.error);

app.get('/api/agents', async (req, res) => {
  try {
    const meritAgents = await meritRepo.findAll();

    const response = meritAgents.map(agent => ({
      type: 'MeritAgent',
      data: {
        ...agent,
        lastUpdated: agent.lastUpdated,
      },
    }));

    console.log('API Response:', response);
    res.json(response);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.listen(port, () => {
  console.log(`API server running at http://localhost:${port}`);
});
