import { z } from 'zod';

export const uploadAvatarSchema = z.object({
  imageUrl: z.string().url(),
});

