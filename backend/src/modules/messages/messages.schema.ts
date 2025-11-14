import { z } from 'zod';

export const sendMessageSchema = z.object({
  receiverId: z.string().cuid(),
  content: z.string().min(1).max(2000),
});

export const getMessagesQuerySchema = z.object({
  userId: z.string().cuid().optional(), // Filter by conversation with specific user
  limit: z.coerce.number().int().min(1).max(100).default(50),
  offset: z.coerce.number().int().min(0).default(0),
});

export const markAsReadSchema = z.object({
  messageIds: z.array(z.string().cuid()),
});

export const getConversationsQuerySchema = z.object({
  limit: z.coerce.number().int().min(1).max(100).default(20),
  offset: z.coerce.number().int().min(0).default(0),
});

