import { prisma } from '../../db/prisma';

interface CreateReviewParams {
  userId: string;
  clubId: string;
  rating: number;
  comment?: string;
}

export class ReviewsService {
  create(params: CreateReviewParams) {
    return prisma.review.create({
      data: params,
    });
  }

  findForClub(clubId: string) {
    return prisma.review.findMany({
      where: { clubId },
      orderBy: { createdAt: 'desc' },
      include: { user: { select: { id: true, firstName: true, lastName: true } } },
    });
  }
}

