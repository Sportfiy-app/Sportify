import { Router } from 'express';

import { authenticate } from '../../middleware/auth';
import { validateBody } from '../../middleware/validate';
import { createSubscriptionSchema, updateSubscriptionSchema } from './subscriptions.schema';
import { SubscriptionsService } from './subscriptions.service';

const router = Router();
const subscriptionsService = new SubscriptionsService();

// Get user subscription
router.get(
  '/',
  authenticate(),
  async (req, res, next) => {
    try {
      const subscription = await subscriptionsService.getUserSubscription(req.user!.sub);
      res.json({ subscription });
    } catch (error) {
      next(error);
    }
  },
);

// Check if user is premium
router.get(
  '/premium',
  authenticate(),
  async (req, res, next) => {
    try {
      const isPremium = await subscriptionsService.isPremium(req.user!.sub);
      res.json({ isPremium });
    } catch (error) {
      next(error);
    }
  },
);

// Create subscription
router.post(
  '/',
  authenticate(),
  validateBody(createSubscriptionSchema),
  async (req, res, next) => {
    try {
      const subscription = await subscriptionsService.createSubscription(req.user!.sub, req.body);
      res.status(201).json(subscription);
    } catch (error) {
      next(error);
    }
  },
);

// Update subscription
router.patch(
  '/:subscriptionId',
  authenticate(),
  validateBody(updateSubscriptionSchema),
  async (req, res, next) => {
    try {
      const subscription = await subscriptionsService.updateSubscription(
        req.user!.sub,
        req.params.subscriptionId,
        req.body,
      );
      res.json(subscription);
    } catch (error) {
      next(error);
    }
  },
);

// Cancel subscription
router.post(
  '/:subscriptionId/cancel',
  authenticate(),
  async (req, res, next) => {
    try {
      const subscription = await subscriptionsService.cancelSubscription(
        req.user!.sub,
        req.params.subscriptionId,
      );
      res.json(subscription);
    } catch (error) {
      next(error);
    }
  },
);

export default router;

