import express from 'express';

const app = express();
const port = 3000;

app.get('/api/agents', (req, res) => {
  res.json({ agents: [] });
});

app.listen(port, () => {
  console.log(`API server running at http://localhost:${port}`);
});
