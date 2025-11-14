import { z } from 'zod';

export const createSubscriptionSchema = z.object({
  plan: z.enum(['monthly', 'annual']),
  stripeId: z.string().optional(),
});

export const updateSubscriptionSchema = z.object({
  status: z.enum(['active', 'cancelled', 'expired']).optional(),
  cancelAtPeriodEnd: z.boolean().optional(),
});

