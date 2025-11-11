import { z } from 'zod';

export const registerSchema = z.object({
  email: z.string().email(),
  phone: z.string().regex(/^\+?[0-9\s\-]{7,}$/).optional(),
  password: z.string().min(8),
  role: z.enum(['USER', 'CLUB_MANAGER', 'ADMIN']).optional(),
  firstName: z.string().max(100).optional(),
  lastName: z.string().max(100).optional(),
});

export const loginSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
});

export const refreshSchema = z.object({
  refreshToken: z.string().min(20),
});

