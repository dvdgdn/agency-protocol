import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { MeritModule } from '@agency-protocol/agent-merit';
import { PrismaMeritRepository, PrismaAgentRepository } from '@agency-protocol/agent-adapter-prisma';

@Module({
  imports: [
    MeritModule.forRoot(new PrismaMeritRepository()),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}