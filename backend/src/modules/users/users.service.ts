import createHttpError from 'http-errors';

import { prisma } from '../../db/prisma';

export class UsersService {
  async findById(id: string) {
    const user = await prisma.user.findUnique({
      where: { id },
      select: {
        id: true,
        email: true,
        phone: true,
        firstName: true,
        lastName: true,
        avatarUrl: true,
        role: true,
        createdAt: true,
        updatedAt: true,
      },
    });
    if (!user) {
      throw createHttpError(404, 'User not found');
    }
    return user;
  }

  async updateProfile(
    id: string,
    data: Partial<{ firstName: string; lastName: string; phone: string; avatarUrl: string; dateOfBirth: Date; gender: string; city: string }>,
  ) {
    return prisma.user.update({
      where: { id },
      data,
      select: {
        id: true,
        email: true,
        phone: true,
        firstName: true,
        lastName: true,
        avatarUrl: true,
        dateOfBirth: true,
        gender: true,
        city: true,
        role: true,
        createdAt: true,
        updatedAt: true,
      },
    });
  }
  
  async uploadAvatar(id: string, imageUrl: string) {
    return prisma.user.update({
      where: { id },
      data: { avatarUrl: imageUrl },
      select: {
        id: true,
        email: true,
        phone: true,
        firstName: true,
        lastName: true,
        avatarUrl: true,
        role: true,
        createdAt: true,
        updatedAt: true,
      },
    });
  }
}

