import http from 'http';

import { createApp } from './app';
import { config } from './config';
import { connectPrisma, disconnectPrisma } from './db/prisma';

async function bootstrap() {
  await connectPrisma();

  const app = createApp();
  const server = http.createServer(app);

  server.listen(config.port, () => {
    // eslint-disable-next-line no-console
    console.log(`🚀 Sportify API listening on http://localhost:${config.port}`);
  });

  const shutdown = async () => {
    await disconnectPrisma();
    server.close(() => process.exit(0));
  };

  process.on('SIGINT', shutdown);
  process.on('SIGTERM', shutdown);
}

bootstrap().catch((error) => {
  // eslint-disable-next-line no-console
  console.error('Failed to start server', error);
  process.exit(1);
});

