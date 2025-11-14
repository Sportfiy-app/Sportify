import { Router } from 'express';
import type { NextFunction, Request, Response } from 'express';

import { authenticate } from '../../middleware/auth';
import { validateBody, validateQuery } from '../../middleware/validate';

import {
  sendMessageSchema,
  getMessagesQuerySchema,
  markAsReadSchema,
  getConversationsQuerySchema,
} from './messages.schema';
import { MessagesService } from './messages.service';

const router = Router();
const messagesService = new MessagesService();

// Send message
router.post(
  '/',
  authenticate(),
  validateBody(sendMessageSchema),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.user!.sub;
      const message = await messagesService.sendMessage(
        userId,
        req.body.receiverId,
        req.body.content,
      );
      res.status(201).json(message);
    } catch (error) {
      next(error);
    }
  },
);

// Get messages (optionally filtered by conversation with specific user)
router.get(
  '/',
  authenticate(),
  validateQuery(getMessagesQuerySchema),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.user!.sub;
      const otherUserId = req.query.userId as string | undefined;
      const limit = Number(req.query.limit) || 50;
      const offset = Number(req.query.offset) || 0;
      const result = await messagesService.getMessages(userId, otherUserId, limit, offset);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

// Get conversations list
router.get(
  '/conversations',
  authenticate(),
  validateQuery(getConversationsQuerySchema),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.user!.sub;
      const limit = Number(req.query.limit) || 20;
      const offset = Number(req.query.offset) || 0;
      const result = await messagesService.getConversations(userId, limit, offset);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

// Mark messages as read
router.patch(
  '/read',
  authenticate(),
  validateBody(markAsReadSchema),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.user!.sub;
      const result = await messagesService.markAsRead(userId, req.body.messageIds);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

// Get unread messages count
router.get(
  '/unread/count',
  authenticate(),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.user!.sub;
      const result = await messagesService.getUnreadCount(userId);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

// Delete message
router.delete(
  '/:messageId',
  authenticate(),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.user!.sub;
      const result = await messagesService.deleteMessage(userId, req.params.messageId);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

export default router;

