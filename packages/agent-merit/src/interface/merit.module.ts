import { Module, DynamicModule, Provider } from '@nestjs/common';
import { MeritService } from '../application/merit.service';
import { MeritController } from './api/merit.controller';
import type { IMeritRepository } from '../domain/merit.repository';

export const MERIT_REPOSITORY_TOKEN = 'MERIT_REPOSITORY';

@Module({})
export class MeritModule {
  static forRoot(repository: IMeritRepository): DynamicModule {
    const repositoryProvider: Provider = {
      provide: MERIT_REPOSITORY_TOKEN,
      useValue: repository,
    };

    return {
      module: MeritModule,
      providers: [repositoryProvider, MeritService],
      controllers: [MeritController],
      exports: [MeritService],
    };
  }
}