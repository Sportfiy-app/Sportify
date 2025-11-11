import createHttpError from 'http-errors';

import { prisma } from '../../db/prisma';

interface CreateBookingParams {
  userId: string;
  clubId: string;
  startsAt: Date;
  endsAt: Date;
}

export class BookingsService {
  async create(params: CreateBookingParams) {
    if (params.endsAt <= params.startsAt) {
      throw createHttpError(400, 'Invalid booking date range');
    }

    return prisma.booking.create({
      data: {
        userId: params.userId,
        clubId: params.clubId,
        startsAt: params.startsAt,
        endsAt: params.endsAt,
      },
    });
  }

  async findMine(userId: string) {
    return prisma.booking.findMany({
      where: { userId },
      include: {
        club: true,
        payment: true,
      },
      orderBy: { startsAt: 'desc' },
    });
  }
}

