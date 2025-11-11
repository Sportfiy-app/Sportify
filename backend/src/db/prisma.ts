import { PrismaClient } from '@prisma/client';

import { config } from '../config';

export const prisma = new PrismaClient({
  datasources: {
    db: {
      url: config.databaseUrl,
    },
  },
});

export async function connectPrisma(): Promise<void> {
  await prisma.$connect();
}

export async function disconnectPrisma(): Promise<void> {
  await prisma.$disconnect();
}

