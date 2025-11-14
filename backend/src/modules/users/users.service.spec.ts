import { prisma } from '../../db/prisma';

import { UsersService } from './users.service';

jest.mock('../../db/prisma', () => ({
  prisma: {
    user: {
      findUnique: jest.fn(),
      update: jest.fn(),
    },
  },
}));

describe('UsersService', () => {
  let usersService: UsersService;

  beforeEach(() => {
    usersService = new UsersService();
    jest.clearAllMocks();
  });

  describe('findById', () => {
    it('should return user by id', async () => {
      const userId = 'user-123';
      const mockUser = {
        id: userId,
        email: 'test@example.com',
        firstName: 'John',
        lastName: 'Doe',
        phone: '+33612345678',
        avatarUrl: null,
        dateOfBirth: null,
        gender: null,
        city: null,
        role: 'USER',
        createdAt: new Date(),
        updatedAt: new Date(),
      };

      (prisma.user.findUnique as jest.Mock).mockResolvedValue(mockUser);

      const result = await usersService.findById(userId);

      expect(result).toEqual(mockUser);
      expect(prisma.user.findUnique).toHaveBeenCalledWith({
        where: { id: userId },
        select: expect.any(Object),
      });
    });

    it('should throw error if user not found', async () => {
      (prisma.user.findUnique as jest.Mock).mockResolvedValue(null);

      await expect(usersService.findById('nonexistent-id')).rejects.toThrow('User not found');
    });
  });

  describe('updateProfile', () => {
    it('should update user profile', async () => {
      const userId = 'user-123';
      const updateData = {
        firstName: 'Jane',
        lastName: 'Smith',
        city: 'Paris',
        dateOfBirth: new Date('1990-01-01'),
        gender: 'FEMALE',
      };

      const updatedUser = {
        id: userId,
        ...updateData,
        email: 'test@example.com',
      };

      (prisma.user.update as jest.Mock).mockResolvedValue(updatedUser);

      const result = await usersService.updateProfile(userId, updateData);

      expect(result).toEqual(updatedUser);
      expect(prisma.user.update).toHaveBeenCalledWith({
        where: { id: userId },
        data: updateData,
        select: expect.any(Object),
      });
    });
  });

  describe('uploadAvatar', () => {
    it('should update user avatar URL', async () => {
      const userId = 'user-123';
      const avatarUrl = 'https://example.com/avatar.jpg';

      const updatedUser = {
        id: userId,
        avatarUrl,
        email: 'test@example.com',
      };

      (prisma.user.update as jest.Mock).mockResolvedValue(updatedUser);

      const result = await usersService.uploadAvatar(userId, avatarUrl);

      expect(result).toEqual(updatedUser);
      expect(prisma.user.update).toHaveBeenCalledWith({
        where: { id: userId },
        data: { avatarUrl },
        select: expect.any(Object),
      });
    });
  });
});

