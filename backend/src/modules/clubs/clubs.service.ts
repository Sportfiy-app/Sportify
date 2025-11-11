import { prisma } from '../../db/prisma';

export class ClubsService {
  findAll() {
    return prisma.club.findMany({
      include: {
        reviews: {
          take: 5,
          orderBy: { createdAt: 'desc' },
        },
      },
    });
  }

  findById(id: string) {
    return prisma.club.findUnique({
      where: { id },
      include: {
        reviews: {
          orderBy: { createdAt: 'desc' },
          include: { user: { select: { id: true, firstName: true, lastName: true } } },
        },
      },
    });
  }
}

