Agency Protocol
A decentralized, infrastructure-agnostic protocol for building trust among autonomous agents using cryptographically signed promises.

The Agency Protocol is a system designed to facilitate trust and coordination between any type of autonomous agent—be it a human, an AI, or an organization. It leverages principles from promise theory to create a network where agents make explicit, stake-backed commitments. The protocol then assesses whether these promises are kept, creating a quantifiable, domain-specific reputation score (merit) for each agent.

Core Principles
This repository is built on a strict set of architectural principles to ensure clarity, consistency, and maximum modularity. Understanding these principles is key to understanding the codebase.

Everything is an Agent: Every package within the packages/ directory is an agent. There are no generic "shared" or "feature" libraries. Each package has a clear, defined role as a specific type of agent.

Consistent Internal Structure: Every agent, regardless of its type, adheres to the same internal Domain-Driven Design (DDD) structure: application/, domain/, infrastructure/, and interface/. This creates a predictable and easy-to-navigate codebase.

Explicit Relationships: Every agent contains an agent.json manifest file that explicitly declares its type, its dependencies on other agents (extends), and its relationship to the concepts it represents (represents). This eliminates ambiguity and makes the architecture self-documenting.

Composition Over Inheritance: Agents are built by composing functionality from ancestor agents. This is used for both backend logic (e.g., agent-merit extends the domain of agent-base) and frontend components (e.g., agent-merit-ui uses components from agent-ui-core).

True Infrastructure Agnosticism: The core logic of an agent is completely decoupled from infrastructure concerns like databases. Logic agents define abstract contracts (e.g., IMeritRepository), and a separate adapter agent provides the concrete implementation (e.g., PrismaMeritRepository), which is injected at runtime by the main server agent.

Repository Structure: The Parallel Agent Model
The architecture is designed around a "Parallel Agent Model," which enforces a strict separation of concerns between backend logic, frontend UI, and infrastructure.

.
└── packages/
    ├── agent-server/           # RUNNABLE: The NestJS API Host (The Composer Root)
    ├── agent-web-ui/           # RUNNABLE: The Next.js Web App (The UI Host)
    │
    ├── agent-base/             # HEADLESS: Foundational Logic & Contracts
    ├── agent-merit/            # HEADLESS: Merit Domain Logic
    │
    ├── agent-ui-core/          # UI: The Base UI Agent (Design System)
    ├── agent-merit-ui/         # UI: Extends agent-ui-core for Merit
    │
    └── agent-adapter-prisma/   # INFRASTRUCTURE: Concrete DB Implementations

Agent Types
Logic Agents (agent-*): Headless packages containing the core DDD business logic for a specific domain (e.g., agent-merit). They are infrastructure-agnostic.

UI Agents (agent-*-ui): Packages containing only the React components and hooks needed to render a visual representation of a corresponding logic agent.

Adapter Agents (agent-adapter-*): Infrastructure-specific packages that provide concrete implementations of the abstract repository interfaces defined in the logic agents.

Runnable Agents (agent-server, agent-web-ui): These are the only executable packages. They act as hosts, composing the various logic, UI, and adapter agents into a running application.

Getting Started
Follow these steps to get the Agency Protocol platform running on your local machine.

Prerequisites
Node.js (v18 or later)

npm (or your preferred package manager)

A Supabase account and a new project created.

1. Installation
Clone the repository and install the dependencies.

git clone https://github.com/dvdgdn/agency-protocol.git
cd agency-protocol
npm install

2. Environment Setup
The project uses a Supabase Postgres database.

Create a .env file in the root of the project.

Go to your Supabase project's Settings > Database page.

Copy the Connection string and add it to your .env file, replacing [YOUR-PASSWORD] with your database password. You will need two versions: one for Prisma Client (with pg-bouncer) and one for Prisma Migrate.

# .env
DATABASE_URL="prisma://postgres.[YOUR-SUPABASE-ID].supabase.co:6543/postgres?pg-bouncer=true"
DIRECT_URL="postgres://postgres:[YOUR-PASSWORD]@[YOUR-SUPABASE-ID].supabase.co:5432/postgres"

3. Database Migration
Run the Prisma migration to create the necessary tables in your Supabase database.

npx prisma migrate dev --name "initial-setup" --schema=./packages/agent-adapter-prisma/src/infrastructure/prisma/schema.prisma

4. Running the Platform
The platform consists of two separate, runnable agents: the backend server and the frontend web app. You will need to run them in two separate terminal windows.

Terminal 1: Start the API Server

nx serve agent-server

This will start the NestJS backend on http://localhost:3000.

Terminal 2: Start the Web App

nx serve agent-web-ui

This will start the Next.js frontend on http://localhost:4200.

You can now open http://localhost:4200 in your browser to view the running application.

Technology Stack
Monorepo: Nx

Backend: NestJS

Frontend: Next.js & React

Database ORM: Prisma

Database: Supabase (Postgres)

Language: TypeScript


License
This project is licensed under the MIT License. See the LICENSE file for details.