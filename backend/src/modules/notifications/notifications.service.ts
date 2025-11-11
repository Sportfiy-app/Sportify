import { prisma } from '../../db/prisma';

export class NotificationsService {
  findForUser(userId: string) {
    return prisma.notification.findMany({
      where: { userId },
      orderBy: { createdAt: 'desc' },
    });
  }
}

