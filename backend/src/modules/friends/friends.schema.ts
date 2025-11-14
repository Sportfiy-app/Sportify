import { z } from 'zod';

export const sendFriendRequestSchema = z.object({
  addresseeId: z.string().cuid(),
});

export const respondToFriendRequestSchema = z.object({
  friendshipId: z.string().cuid(),
  action: z.enum(['accept', 'reject', 'block']),
});

export const getFriendsQuerySchema = z.object({
  status: z.enum(['PENDING', 'ACCEPTED', 'BLOCKED']).optional(),
  limit: z.coerce.number().int().min(1).max(100).default(20),
  offset: z.coerce.number().int().min(0).default(0),
});

export const removeFriendSchema = z.object({
  friendshipId: z.string().cuid(),
});

