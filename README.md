# Agency Protocol

A decentralized trust infrastructure where autonomous agents make explicit, cryptographically-signed promises about their behavior, creating emergent trustworthiness through economic incentives rather than external enforcement.

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
- [Development](#development)
- [Project Structure](#project-structure)
- [Core Concepts](#core-concepts)
- [Contributing](#contributing)
- [Testing](#testing)
- [Documentation](#documentation)
- [License](#license)

## Overview

The Agency Protocol implements a promise-theoretic approach to decentralized trust, where:

- **Agents** are autonomous entities (humans, AIs, organizations) that can only make promises about their own behavior
- **Promises** are explicit, cryptographically signed commitments with economic stakes
- **Assessments** evaluate whether promises were kept, creating reputation (merit) and economic consequences
- **Trust emerges** from aligned incentives rather than central authority

### Why Agency Protocol?

Traditional trust systems rely on central authorities or reputation scores that can be gamed. The Agency Protocol creates a self-enforcing system where:

1. **Economic alignment**: Breaking promises costs more than keeping them
2. **Domain-specific trust**: Merit in one domain doesn't transfer to others
3. **Decentralized verification**: Any agent can assess any promise
4. **Progressive autonomy**: Agents earn greater capabilities through proven trustworthiness

## Key Features

- 🔐 **Cryptographic Identity**: All agents and promises are content-addressed and signed
- 💰 **Dual Currency System**: Transferable credits for economic stakes, non-transferable merit for reputation
- 🌳 **Hierarchical Promise Inheritance**: Agents compose promises from their parents in the type hierarchy
- 🔄 **Cycle Detection**: Prevents circular dependencies in inheritance and promise chains
- ⚡ **Batch Processing**: Efficient merit and credit updates with configurable intervals
- 🎯 **Domain Isolation**: Trust is contextual and domain-specific
- 🛡️ **Multiple Assessment Types**: Different risk/reward profiles for various validation needs

## Architecture

The project follows Domain-Driven Design (DDD) principles with clear separation of concerns:

```
agency-protocol/
├── abm/                    # Agent-Based Modeling simulations
│   ├── tournament-results/ # Tournament simulation outputs
│   └── *.py               # Various ABM scenarios and tests
├── agency-protocol/        # Main protocol implementation
│   ├── packages/          # Core package structure
│   └── jest/tsconfig      # Testing configuration
├── coq/                    # Formal verification proofs
│   └── *.v                # Coq proof files for theorems
├── docs/                   # Documentation and whitepapers
│   ├── whitepaper.org     # System design document
│   └── yellowpaper.org    # Technical specification
├── features/               # Gherkin specifications
│   ├── digital_twin/      # Digital twin features
│   └── *.feature          # Feature specifications
└── packages/              # Additional packages (empty currently)
```

### Technology Stack

- **Framework**: NX Monorepo
- **Language**: TypeScript
- **Testing**: Jest
- **Build**: SWC
- **Architecture**: Domain-Driven Design (DDD)

## Getting Started

### Prerequisites

- Node.js 18+
- npm or yarn
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/agency-protocol.git
cd agency-protocol

# Install dependencies in the main protocol directory
cd agency-protocol
npm install

# Build all packages
npm run build
```

### Quick Example

```typescript
import { Agent, Promise, MeritableAssessment } from '@agency-protocol/domain';

// Create an agent
const deliveryAgent = new Agent({
  id: 'delivery-agent-001',
  public_key: 'pubkey...',
  signature: 'sig...',
  agent_type: 'DeliveryAgent',
  parent_type: 'ServiceAgent'
});

// Make a promise
const promise = new Promise({
  promiser_id: deliveryAgent.id,
  promisee_scope: ['customer-123'],
  body: {
    domain: '/logistics/delivery/_deliversWithinHours',
    parameters: { hours: 24 }
  },
  stake: { credits: 100 },
  signature: 'promise-sig...'
});

// Assess the promise
const assessment = new MeritableAssessment({
  assessor_id: 'customer-123',
  subject_promise_id: promise.cid,
  judgement: 'KEPT',
  domain_cid: 'domain-cid...',
  signature: 'assessment-sig...'
});
```

## Development

### Running Tests

```bash
# Run all tests
npm test

# Run tests for a specific package
nx test @agency-protocol/domain

# Run tests in watch mode
nx test @agency-protocol/domain --watch
```

### Building

```bash
# Build all packages
npm run build

# Build specific package
nx build @agency-protocol/domain
```

### Linting

```bash
# Lint all packages
npm run lint

# Lint specific package
nx lint @agency-protocol/domain
```

## Project Structure

### Core Components

#### Agent-Based Modeling (`abm/`)

Python-based simulations for protocol behavior analysis:
- Tournament simulations with different agent strategies
- Treasury stress testing
- Attack scenario modeling
- Multi-domain asynchronous simulations

#### Protocol Implementation (`agency-protocol/`)

The TypeScript/NX implementation:
- **packages/**: Core domain and infrastructure code
- **jest.config.ts**: Testing configuration
- **nx.json**: Monorepo configuration

#### Formal Verification (`coq/`)

Mathematical proofs of protocol properties:
- Consensus detection theorems
- Merit update correctness
- Error tolerance bounds
- Stake function properties

#### Feature Specifications (`features/`)

Gherkin specifications defining behavior:
- Core protocol features (agents, promises, assessments)
- Digital twin capabilities
- Domain-specific implementations (healthcare, supply chain)
- Security and privacy requirements

## Core Concepts

### Promise Lifecycle

```
Intention → Promise (+ Stake) → Assessment (+ Evidence) → Merit/Credit Update
```

### Promise Object Structure

```json
{
  "promiser_id": "agent-cid",
  "promisee_scope": ["*"],
  "body": {
    "domain": "/logistics/delivery/_deliversWithinHours",
    "parameters": { "hours": 48 }
  },
  "stake": { "credits": 75 },
  "signature": "..."
}
```

### Assessment Types

1. **Meritable**: Standard assessment with merit at risk
2. **Disputable**: Higher risk/reward for contentious promises
3. **Creditable**: Credit-staked assessments
4. **Delayable**: Anonymous assessments with time delay
5. **Includable**: Pre-authorized assessments

### Economic Model

- **Stake Formula**: `S_p(M) = S_base × (1 - w(M))`
- **Merit Impact**: 
  - Keeping promises: `ΔM⁺ = γ_d × (1 - M_a,d)`
  - Breaking promises: `ΔM⁻ = -λ_d × γ_d × M_a,d`
- **Asymmetric penalties**: λ ≥ 4 recommended

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Process

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Coding Standards

- Use TypeScript for all new code
- Follow the existing code style
- Write tests for new functionality
- Update documentation as needed
- Ensure all tests pass before submitting PR

### Commit Messages

Follow conventional commits:
- `feat:` New features
- `fix:` Bug fixes
- `docs:` Documentation changes
- `test:` Test additions or changes
- `refactor:` Code refactoring
- `chore:` Maintenance tasks

## Testing

The project uses Jest for testing. Tests are colocated with source files.

```bash
# Run all tests
npm test

# Run with coverage
npm run test:coverage

# Run specific test file
nx test @agency-protocol/domain --testFile=agent.entity.spec.ts
```

### Test Structure

- Unit tests for domain logic
- Integration tests for services
- E2E tests for complete workflows

## Documentation

- [Whitepaper](docs/whitepaper.org) - Comprehensive system design
- [Yellow Paper](docs/yellowpaper.org) - Technical specification
- [API Documentation](docs/api/index.md) - Generated API docs
- [Architecture Decision Records](docs/adr/) - Key design decisions

## Roadmap

### Phase 1: Foundation (Current)
- ✅ Core domain implementation
- ✅ Assessment types
- ✅ Batch processing
- 🔄 Agent implementations
- 🔄 Application services

### Phase 2: First Vertical
- Goal Engine marketplace
- Dispute resolution system
- Basic governance

### Phase 3: Ecosystem
- SDK for third-party developers
- Advanced merit algorithms
- Decentralized governance transition

## Security

### Reporting Security Issues

Please report security vulnerabilities to security@agencyprotocol.org. Do not open public issues for security concerns.

### Security Features

- Content-addressed storage prevents tampering
- Cryptographic signatures on all promises
- Economic stakes align incentives
- Cycle detection prevents attack vectors

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Promise Theory by Mark Burgess
- The broader Web3 and cryptoeconomics community
- Contributors and early adopters

## Links

- [Website](https://agencyprotocol.org)
- [Documentation](https://docs.agencyprotocol.org)
- [Discord Community](https://discord.gg/agencyprotocol)
- [Twitter](https://twitter.com/agencyprotocol)

---

Built with ❤️ for a more trustworthy future