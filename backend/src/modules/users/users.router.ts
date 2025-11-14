import { Router } from 'express';
import { z } from 'zod';

import { authenticate } from '../../middleware/auth';
import { validateBody } from '../../middleware/validate';

import { uploadAvatarSchema } from './upload.schema';
import { addUserSportSchema, updateUserSportSchema } from './user-sports.schema';
import { UserSportsService } from './user-sports.service';
import { UsersService } from './users.service';

const router = Router();
const usersService = new UsersService();
const userSportsService = new UserSportsService();

const updateProfileSchema = z.object({
  firstName: z.string().max(100).optional(),
  lastName: z.string().max(100).optional(),
  phone: z.string().regex(/^\+?[0-9\s\-]{7,}$/).optional(),
  avatarUrl: z.string().url().optional(),
  dateOfBirth: z.string().datetime().optional(),
  gender: z.string().max(50).optional(),
  city: z.string().max(100).optional(),
});

router.get('/me', authenticate(), async (req, res, next) => {
  try {
    const profile = await usersService.findById(req.user!.sub);
    res.json(profile);
  } catch (error) {
    next(error);
  }
});

router.patch(
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

// User Sports routes
router.get(
  '/sports',
  authenticate(),
  async (req, res, next) => {
    try {
      const sports = await userSportsService.getUserSports(req.user!.sub);
      res.json({ sports });
    } catch (error) {
      next(error);
    }
  },
);

router.post(
  '/sports',
  authenticate(),
  validateBody(addUserSportSchema),
  async (req, res, next) => {
    try {
      const sport = await userSportsService.addSport(req.user!.sub, req.body);
      res.status(201).json(sport);
    } catch (error) {
      next(error);
    }
  },
);

router.patch(
  '/sports/:sportId',
  authenticate(),
  validateBody(updateUserSportSchema),
  async (req, res, next) => {
    try {
      const sport = await userSportsService.updateSport(req.user!.sub, req.params.sportId, req.body);
      res.json(sport);
    } catch (error) {
      next(error);
    }
  },
);

router.delete(
  '/sports/:sportId',
  authenticate(),
  async (req, res, next) => {
    try {
      const result = await userSportsService.removeSport(req.user!.sub, req.params.sportId);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

// Upload avatar
router.post(
  '/avatar',
  authenticate(),
  validateBody(uploadAvatarSchema),
  async (req, res, next) => {
    try {
      const updated = await usersService.uploadAvatar(req.user!.sub, req.body.imageUrl);
      res.json(updated);
    } catch (error) {
      next(error);
    }
  },
);

export default router;

