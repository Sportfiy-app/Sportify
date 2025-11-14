import { prisma } from '../../db/prisma';

import { SubscriptionsService } from './subscriptions.service';

jest.mock('../../db/prisma', () => ({
  prisma: {
    subscription: {
      create: jest.fn(),
      findFirst: jest.fn(),
      update: jest.fn(),
    },
  },
}));

describe('SubscriptionsService', () => {
  let subscriptionsService: SubscriptionsService;

  beforeEach(() => {
    subscriptionsService = new SubscriptionsService();
    jest.clearAllMocks();
  });

  describe('createSubscription', () => {
    it('should create a monthly subscription', async () => {
      const userId = 'user-123';
      const subscriptionData = {
        plan: 'monthly' as const,
        stripeId: 'stripe-123',
      };

      (prisma.subscription.findFirst as jest.Mock).mockResolvedValue(null);
      (prisma.subscription.create as jest.Mock).mockResolvedValue({
        id: 'sub-123',
        userId,
        ...subscriptionData,
        status: 'active',
        currentPeriodStart: new Date(),
        currentPeriodEnd: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000),
      });

      const result = await subscriptionsService.createSubscription(userId, subscriptionData);

      expect(result).toHaveProperty('id');
      expect(result.plan).toBe('monthly');
      expect(prisma.subscription.create).toHaveBeenCalled();
    });

    it('should create an annual subscription', async () => {
      const userId = 'user-123';
      const subscriptionData = {
        plan: 'annual' as const,
      };

      (prisma.subscription.findFirst as jest.Mock).mockResolvedValue(null);
      (prisma.subscription.create as jest.Mock).mockResolvedValue({
        id: 'sub-123',
        userId,
        ...subscriptionData,
        status: 'active',
        currentPeriodStart: new Date(),
        currentPeriodEnd: new Date(Date.now() + 365 * 24 * 60 * 60 * 1000),
      });

      const result = await subscriptionsService.createSubscription(userId, subscriptionData);

      expect(result.plan).toBe('annual');
    });

    it('should throw error if user already has active subscription', async () => {
      const userId = 'user-123';
      const subscriptionData = {
        plan: 'monthly' as const,
      };

      (prisma.subscription.findFirst as jest.Mock).mockResolvedValue({
        id: 'existing-sub',
        userId,
        status: 'active',
      });

      await expect(
        subscriptionsService.createSubscription(userId, subscriptionData)
      ).rejects.toThrow();
    });
  });

  describe('getUserSubscription', () => {
    it('should return user subscription', async () => {
      const userId = 'user-123';
      const mockSubscription = {
        id: 'sub-123',
        userId,
        plan: 'monthly',
        status: 'active',
      };

      (prisma.subscription.findFirst as jest.Mock).mockResolvedValue(mockSubscription);

      const result = await subscriptionsService.getUserSubscription(userId);

      expect(result).toEqual(mockSubscription);
    });
  });

  describe('cancelSubscription', () => {
    it('should cancel subscription', async () => {
      const userId = 'user-123';
      const subscriptionId = 'sub-123';

      (prisma.subscription.findFirst as jest.Mock).mockResolvedValue({
        id: subscriptionId,
        userId,
        status: 'active',
      });

      (prisma.subscription.update as jest.Mock).mockResolvedValue({
        id: subscriptionId,
        cancelAtPeriodEnd: true,
      });

      const result = await subscriptionsService.cancelSubscription(userId, subscriptionId);

      expect(result.cancelAtPeriodEnd).toBe(true);
      expect(prisma.subscription.update).toHaveBeenCalledWith({
        where: { id: subscriptionId },
        data: { cancelAtPeriodEnd: true },
      });
    });
  });

  describe('isPremium', () => {
    it('should return true for active premium subscription', async () => {
      const userId = 'user-123';

      (prisma.subscription.findFirst as jest.Mock).mockResolvedValue({
        id: 'sub-123',
        userId,
        status: 'active',
        currentPeriodEnd: new Date(Date.now() + 1000000),
        cancelAtPeriodEnd: false,
      });

      const result = await subscriptionsService.isPremium(userId);

      expect(result).toBe(true);
    });

    it('should return false if no active subscription', async () => {
      const userId = 'user-123';

      (prisma.subscription.findFirst as jest.Mock).mockResolvedValue(null);

      const result = await subscriptionsService.isPremium(userId);

      expect(result).toBe(false);
    });
  });
});

