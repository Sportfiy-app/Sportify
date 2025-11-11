import { Router } from 'express';
import { z } from 'zod';

import { authenticate } from '../../middleware/auth';
import { validateBody } from '../../middleware/validate';
import { UsersService } from './users.service';

const router = Router();
const usersService = new UsersService();

const updateProfileSchema = z.object({
  firstName: z.string().max(100).optional(),
  lastName: z.string().max(100).optional(),
  phone: z.string().regex(/^\+?[0-9\s\-]{7,}$/).optional(),
});

router.get('/me', authenticate(), async (req, res, next) => {
  try {
    const profile = await usersService.findById(req.user!.sub);
    res.json(profile);
  } catch (error) {
    next(error);
  }
});

router.put(
  '/profile',
  authenticate(),
  validateBody(updateProfileSchema),
  async (req, res, next) => {
    try {
      const updated = await usersService.updateProfile(req.user!.sub, req.body);
      res.json(updated);
    } catch (error) {
      next(error);
    }
  },
);

export default router;

