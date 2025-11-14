import createHttpError from 'http-errors';

import { prisma } from '../../db/prisma';

export class SubscriptionsService {
  async createSubscription(
    userId: string,
    data: { plan: 'monthly' | 'annual'; stripeId?: string },
  ) {
    // Check if user already has an active subscription
    const existing = await prisma.subscription.findFirst({
      where: {
        userId,
        status: 'active',
      },
    });

    if (existing) {
      throw createHttpError(409, 'User already has an active subscription');
    }

    // Calculate period dates
    const now = new Date();
    const periodEnd = new Date(now);
    if (data.plan === 'monthly') {
      periodEnd.setMonth(periodEnd.getMonth() + 1);
    } else {
      periodEnd.setFullYear(periodEnd.getFullYear() + 1);
    }

    return prisma.subscription.create({
      data: {
        userId,
        plan: data.plan,
        stripeId: data.stripeId,
        currentPeriodStart: now,
        currentPeriodEnd: periodEnd,
        status: 'active',
      },
    });
  }

  async getUserSubscription(userId: string) {
    return prisma.subscription.findFirst({
      where: { userId },
      orderBy: { createdAt: 'desc' },
    });
  }

  async updateSubscription(
    userId: string,
    subscriptionId: string,
    data: Partial<{ status: string; cancelAtPeriodEnd: boolean }>,
  ) {
    const subscription = await prisma.subscription.findFirst({
      where: {
        id: subscriptionId,
        userId,
      },
    });

    if (!subscription) {
      throw createHttpError(404, 'Subscription not found');
    }

    return prisma.subscription.update({
      where: { id: subscriptionId },
      data,
    });
  }

  async cancelSubscription(userId: string, subscriptionId: string) {
    const subscription = await prisma.subscription.findFirst({
      where: {
        id: subscriptionId,
        userId,
      },
    });

    if (!subscription) {
      throw createHttpError(404, 'Subscription not found');
    }

    return prisma.subscription.update({
      where: { id: subscriptionId },
      data: {
        cancelAtPeriodEnd: true,
      },
    });
  }

  async isPremium(userId: string): Promise<boolean> {
    const subscription = await prisma.subscription.findFirst({
      where: {
        userId,
        status: 'active',
        currentPeriodEnd: {
          gte: new Date(),
        },
      },
    });

    return subscription !== null && !subscription.cancelAtPeriodEnd;
  }
}

