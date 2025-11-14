import { VerificationService } from './verification.service';
import { prisma } from '../../db/prisma';

jest.mock('../../db/prisma', () => ({
  prisma: {
    user: {
      update: jest.fn(),
      findFirst: jest.fn(),
    },
  },
}));

describe('VerificationService', () => {
  let verificationService: VerificationService;

  beforeEach(() => {
    verificationService = new VerificationService();
    jest.clearAllMocks();
  });

  describe('sendSmsCode', () => {
    it('should generate and save SMS verification code', async () => {
      const phone = '+33612345678';
      const userId = 'user-123';

      (prisma.user.update as jest.Mock).mockResolvedValue({
        id: userId,
        phone,
        phoneVerificationCode: '123456',
      });

      const result = await verificationService.sendSmsCode(phone, userId);

      expect(result).toHaveProperty('expiresIn');
      expect(prisma.user.update).toHaveBeenCalledWith({
        where: { id: userId },
        data: expect.objectContaining({
          phoneVerificationCode: expect.any(String),
          phoneVerificationExpires: expect.any(Date),
        }),
      });
    });
  });

  describe('verifySmsCode', () => {
    it('should verify SMS code successfully', async () => {
      const phone = '+33612345678';
      const code = '123456';
      const userId = 'user-123';

      (prisma.user.findFirst as jest.Mock).mockResolvedValue({
        id: userId,
        phone,
        phoneVerificationCode: code,
        phoneVerificationExpires: new Date(Date.now() + 600000), // 10 minutes from now
      });

      (prisma.user.update as jest.Mock).mockResolvedValue({
        id: userId,
        phoneVerified: true,
      });

      const result = await verificationService.verifySmsCode(phone, code, userId);

      expect(result.verified).toBe(true);
      expect(prisma.user.update).toHaveBeenCalledWith({
        where: { id: userId },
        data: {
          phoneVerified: true,
          phoneVerificationCode: null,
          phoneVerificationExpires: null,
        },
      });
    });

    it('should throw error for invalid code', async () => {
      const phone = '+33612345678';
      const code = 'wrongcode';
      const userId = 'user-123';

      (prisma.user.findFirst as jest.Mock).mockResolvedValue({
        id: userId,
        phone,
        phoneVerificationCode: '123456',
        phoneVerificationExpires: new Date(Date.now() + 600000),
      });

      await expect(verificationService.verifySmsCode(phone, code, userId)).rejects.toThrow();
    });

    it('should throw error for expired code', async () => {
      const phone = '+33612345678';
      const code = '123456';
      const userId = 'user-123';

      (prisma.user.findFirst as jest.Mock).mockResolvedValue({
        id: userId,
        phone,
        phoneVerificationCode: code,
        phoneVerificationExpires: new Date(Date.now() - 1000), // Expired
      });

      await expect(verificationService.verifySmsCode(phone, code, userId)).rejects.toThrow();
    });
  });

  describe('sendEmailVerification', () => {
    it('should generate and save email verification token', async () => {
      const email = 'test@example.com';
      const userId = 'user-123';

      (prisma.user.update as jest.Mock).mockResolvedValue({
        id: userId,
        email,
        emailVerificationToken: 'token-123',
      });

      const result = await verificationService.sendEmailVerification(email, userId);

      expect(result).toHaveProperty('token');
      expect(prisma.user.update).toHaveBeenCalledWith({
        where: { id: userId },
        data: expect.objectContaining({
          emailVerificationToken: expect.any(String),
        }),
      });
    });
  });

  describe('verifyEmail', () => {
    it('should verify email token successfully', async () => {
      const token = 'valid-token';

      (prisma.user.findFirst as jest.Mock).mockResolvedValue({
        id: 'user-123',
        email: 'test@example.com',
        emailVerificationToken: token,
      });

      (prisma.user.update as jest.Mock).mockResolvedValue({
        id: 'user-123',
        emailVerified: true,
      });

      const result = await verificationService.verifyEmail(token);

      expect(result.verified).toBe(true);
      expect(prisma.user.update).toHaveBeenCalledWith({
        where: { id: 'user-123' },
        data: {
          emailVerified: true,
          emailVerificationToken: null,
        },
      });
    });

    it('should throw error for invalid token', async () => {
      (prisma.user.findFirst as jest.Mock).mockResolvedValue(null);

      await expect(verificationService.verifyEmail('invalid-token')).rejects.toThrow();
    });
  });
});

