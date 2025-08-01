// Domain exports
export * from './domain/entities/merit-agent.entity';
export * from './domain/value-objects/merit.value-object';
export * from './domain/value-objects/merit-domain.value-object';
export * from './domain/merit.types';

// Infrastructure exports (to be implemented)
// export * from './infrastructure/repositories/merit.repository';
// export * from './infrastructure/services/merit-calculation.service';

// Application exports
export * from './application/merit.service';

// Interface exports
export { MeritModule } from './interface/merit.module';
export { MeritController } from './interface/api/merit.controller';
export { MERIT_REPOSITORY_TOKEN } from './interface/merit.module';

// Repository interface
export * from './domain/merit.repository';
