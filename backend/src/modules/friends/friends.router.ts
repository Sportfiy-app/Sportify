import { Router } from 'express';
import type { NextFunction, Request, Response } from 'express';

import { authenticate } from '../../middleware/auth';
import { validateBody, validateQuery } from '../../middleware/validate';

import {
  sendFriendRequestSchema,
  respondToFriendRequestSchema,
  getFriendsQuerySchema,
  removeFriendSchema,
} from './friends.schema';
import { FriendsService } from './friends.service';

const router = Router();
const friendsService = new FriendsService();

// Send friend request
router.post(
  '/request',
  authenticate(),
  validateBody(sendFriendRequestSchema),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.user!.sub;
      const friendship = await friendsService.sendFriendRequest(userId, req.body.addresseeId);
      res.status(201).json(friendship);
    } catch (error) {
      next(error);
    }
  },
);

// Respond to friend request (accept/reject/block)
router.post(
  '/respond',
  authenticate(),
  validateBody(respondToFriendRequestSchema),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.user!.sub;
      const result = await friendsService.respondToFriendRequest(
        userId,
        req.body.friendshipId,
        req.body.action,
      );
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

// Get friends list
router.get(
  '/',
  authenticate(),
  validateQuery(getFriendsQuerySchema),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.user!.sub;
      const status = req.query.status as any;
      const limit = Number(req.query.limit) || 20;
      const offset = Number(req.query.offset) || 0;
      const result = await friendsService.getFriends(userId, status, limit, offset);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

// Get friend requests (sent or received)
router.get(
  '/requests',
  authenticate(),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.user!.sub;
      const type = (req.query.type as 'sent' | 'received') || 'received';
      const requests = await friendsService.getFriendRequests(userId, type);
      res.json({ requests });
    } catch (error) {
      next(error);
    }
  },
);

// Get friendship status with another user
router.get(
  '/status/:userId',
  authenticate(),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.user!.sub;
      const otherUserId = req.params.userId;
      const status = await friendsService.getFriendshipStatus(userId, otherUserId);
      res.json(status);
    } catch (error) {
      next(error);
    }
  },
);

// Remove friend
router.delete(
  '/:friendshipId',
  authenticate(),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.user!.sub;
      const result = await friendsService.removeFriend(userId, req.params.friendshipId);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

// Cancel friend request (for requester)
router.delete(
  '/request/:friendshipId',
  authenticate(),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.user!.sub;
      const result = await friendsService.cancelFriendRequest(userId, req.params.friendshipId);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

export default router;

