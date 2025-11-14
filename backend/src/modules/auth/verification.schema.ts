import { z } from 'zod';

export const sendSmsCodeSchema = z.object({
  phone: z.string().regex(/^\+?[0-9\s\-]{7,}$/),
});

export const verifySmsCodeSchema = z.object({
  phone: z.string().regex(/^\+?[0-9\s\-]{7,}$/),
  code: z.string().length(6, 'Code must be 6 digits'),
});

export const sendEmailVerificationSchema = z.object({
  email: z.string().email(),
});

export const verifyEmailSchema = z.object({
  token: z.string().min(1),
});

