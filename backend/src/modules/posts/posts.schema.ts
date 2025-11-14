import { z } from 'zod';

export const createPostSchema = z.object({
  content: z.string().min(1).max(2000),
  type: z.enum(['TEXT', 'IMAGE', 'EVENT']).default('TEXT'),
  imageUrl: z.string().url().optional(),
  sport: z.string().optional(),
  location: z.string().optional(),
  latitude: z.number().optional(),
  longitude: z.number().optional(),
  eventId: z.string().cuid().optional(),
});

export const updatePostSchema = createPostSchema.partial();

export const likePostSchema = z.object({
  postId: z.string().cuid(),
});

export const createCommentSchema = z.object({
  content: z.string().min(1).max(500),
});

export const getPostsQuerySchema = z.object({
  sport: z.string().optional(),
  type: z.enum(['TEXT', 'IMAGE', 'EVENT']).optional(),
  authorId: z.string().cuid().optional(),
  limit: z.coerce.number().int().min(1).max(100).default(20),
  offset: z.coerce.number().int().min(0).default(0),
  latitude: z.coerce.number().optional(),
  longitude: z.coerce.number().optional(),
  radius: z.coerce.number().positive().optional(), // in km
});

