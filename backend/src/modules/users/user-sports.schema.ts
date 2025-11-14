import { z } from 'zod';

export const addUserSportSchema = z.object({
  sport: z.string().min(1).max(100),
  level: z.string().max(50).optional(),
  ranking: z.string().max(200).optional(),
});

export const updateUserSportSchema = addUserSportSchema.partial();

