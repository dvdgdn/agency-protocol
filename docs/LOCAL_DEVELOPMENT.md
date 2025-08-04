# Local Development Guide

This guide provides detailed instructions for setting up and running the Agency Protocol platform locally.

## Quick Start

1. **Clone and install**
   ```bash
   git clone https://github.com/dvdgdn/agency-protocol.git
   cd agency-protocol
   npm install
   ```

2. **Set up environment**
   ```bash
   cp .env.example .env
   # Edit .env with your Supabase credentials
   ```

3. **Run database migrations**
   ```bash
   npx prisma migrate dev --name "initial-setup" --schema=./packages/agent-adapter-prisma/src/infrastructure/prisma/schema.prisma
   ```

4. **Start the platform** (in separate terminals)
   ```bash
   # Terminal 1: API Server
   nx serve agent-server

   # Terminal 2: Web App
   nx serve agent-web-ui
   ```

5. **Seed sample data** (optional)
   ```bash
   curl -X POST http://localhost:3000/api/merit/seed
   ```

## Architecture Overview

The platform uses a Parallel Agent Model with these key components:

- **agent-server**: NestJS API server (port 3000)
- **agent-web-ui**: Next.js web application (port 4200)
- **agent-adapter-prisma**: Database adapter using Prisma ORM
- **agent-merit**: Business logic for merit scoring
- **agent-credit**: Business logic for credit management

## Environment Variables

Create a `.env` file in the root directory with:

```env
# Supabase Database URLs
DATABASE_URL="prisma://postgres.[YOUR-SUPABASE-ID].supabase.co:6543/postgres?pg-bouncer=true"
DIRECT_URL="postgres://postgres:[YOUR-PASSWORD]@[YOUR-SUPABASE-ID].supabase.co:5432/postgres"

# API Configuration
API_PORT=3000

# Frontend Configuration
NEXT_PUBLIC_API_URL=http://localhost:3000/api
```

## Available Commands

### Development
- `nx serve agent-server` - Start the API server
- `nx serve agent-web-ui` - Start the web app
- `nx build [package-name]` - Build a specific package
- `nx test [package-name]` - Run tests for a package

### Database
- `npx prisma migrate dev` - Run migrations
- `npx prisma studio` - Open Prisma Studio GUI
- `npx prisma generate` - Generate Prisma client

### API Endpoints

Once the server is running, these endpoints are available:

- `GET /api/merit` - Get all merit scores
- `GET /api/merit/:agentId` - Get merit for specific agent
- `POST /api/merit/seed` - Seed sample merit data

## Troubleshooting

### Database Connection Issues
- Ensure your Supabase project is active
- Check that the database URLs in `.env` are correct
- Verify your database password is properly escaped

### Port Conflicts
- API server defaults to port 3000
- Web app defaults to port 4200
- Change ports via environment variables if needed

### CORS Errors
- The API server is configured to accept requests from `http://localhost:4200`
- If running the frontend on a different port, update the CORS settings in `agent-server/src/main.ts`

## Next Steps

- Explore the codebase structure in `/packages`
- Read about the agent architecture in the main README
- Check individual package README files for specific details