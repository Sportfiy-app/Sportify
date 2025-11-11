import createHttpError from 'http-errors';

import { prisma } from '../../db/prisma';

export class UsersService {
  async findById(id: string) {
    const user = await prisma.user.findUnique({
      where: { id },
      select: { id, email, phone, firstName, lastName, role, createdAt, updatedAt },
    });
    if (!user) {
      throw createHttpError(404, 'User not found');
    }
    return user;
  }

  async updateProfile(
    id: string,
    data: Partial<{ firstName: string; lastName: string; phone: string }>,
  ) {
    return prisma.user.update({
      where: { id },
      data,
      select: { id, email, phone, firstName, lastName, role, createdAt, updatedAt },
    });
  }
}

