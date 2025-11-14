import { z } from 'zod';

export const createEventSchema = z.object({
  title: z.string().min(1).max(200),
  description: z.string().min(1).max(2000),
  sport: z.string().min(1),
  location: z.string().min(1),
  address: z.string().optional(),
  latitude: z.number().optional(),
  longitude: z.number().optional(),
  date: z.string().datetime(), // ISO 8601 format
  time: z.string().regex(/^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/), // HH:mm format
  minParticipants: z.number().int().min(1).default(2),
  maxParticipants: z.number().int().min(1).default(10),
  isPublic: z.boolean().default(true),
  price: z.number().positive().optional(),
  priceCurrency: z.string().default('EUR'),
  difficultyLevel: z.string().optional(),
  tags: z.array(z.string()).default([]),
  imageUrl: z.string().url().optional(),
});

export const updateEventSchema = createEventSchema.partial();

export const joinEventSchema = z.object({
  eventId: z.string().cuid(),
});

export const leaveEventSchema = z.object({
  eventId: z.string().cuid(),
});

export const getEventsQuerySchema = z.object({
  sport: z.string().optional(),
  status: z.enum(['UPCOMING', 'ONGOING', 'COMPLETED', 'CANCELLED']).optional(),
  limit: z.coerce.number().int().min(1).max(100).default(20),
  offset: z.coerce.number().int().min(0).default(0),
  latitude: z.coerce.number().optional(),
  longitude: z.coerce.number().optional(),
  radius: z.coerce.number().positive().optional(), // in km
});

