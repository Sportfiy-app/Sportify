import createHttpError from 'http-errors';

import { prisma } from '../../db/prisma';

export class UserSportsService {
  async addSport(userId: string, data: { sport: string; level?: string; ranking?: string }) {
    // Check if sport already exists for user
    const existing = await prisma.userSport.findUnique({
      where: {
        userId_sport: {
          userId,
          sport: data.sport,
        },
      },
    });

    if (existing) {
      throw createHttpError(409, 'Sport already added');
    }

    return prisma.userSport.create({
      data: {
        userId,
        sport: data.sport,
        level: data.level,
        ranking: data.ranking,
      },
    });
  }

  async getUserSports(userId: string) {
    return prisma.userSport.findMany({
      where: { userId },
      orderBy: { createdAt: 'desc' },
    });
  }

  async updateSport(userId: string, sportId: string, data: Partial<{ level: string; ranking: string }>) {
    const sport = await prisma.userSport.findFirst({
      where: {
        id: sportId,
        userId,
      },
    });

    if (!sport) {
      throw createHttpError(404, 'Sport not found');
    }

    return prisma.userSport.update({
      where: { id: sportId },
      data,
    });
  }

  async removeSport(userId: string, sportId: string) {
    const sport = await prisma.userSport.findFirst({
      where: {
        id: sportId,
        userId,
      },
    });

    if (!sport) {
      throw createHttpError(404, 'Sport not found');
    }

    await prisma.userSport.delete({
      where: { id: sportId },
    });

    return { success: true };
  }
}

