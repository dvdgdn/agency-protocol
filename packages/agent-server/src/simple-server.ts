import 'reflect-metadata';
import { NestFactory } from '@nestjs/core';
import { Module, Controller, Get } from '@nestjs/common';

@Controller()
class AppController {
  @Get()
  getHello(): string {
    return 'Agency Protocol Server is running!';
  }
  
  @Get('api/merit')
  getMerit() {
    return [
      { agentId: 'merit-001', meritScore: 1250, lastUpdated: new Date().toISOString() },
      { agentId: 'merit-002', meritScore: 875, lastUpdated: new Date().toISOString() }
    ];
  }
}

@Module({
  controllers: [AppController],
})
class AppModule {}

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors();
  const port = process.env.API_PORT || 3001;
  await app.listen(port);
  console.log(`🚀 Server is running on: http://localhost:${port}`);
}

bootstrap();