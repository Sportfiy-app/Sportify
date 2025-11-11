import { Router } from 'express';
import { z } from 'zod';

import { authenticate } from '../../middleware/auth';
import { validateBody } from '../../middleware/validate';

import { ReviewsService } from './reviews.service';

const router = Router();
const reviewsService = new ReviewsService();

const createReviewSchema = z.object({
  clubId: z.string().cuid(),
  rating: z.number().int().min(1).max(5),
  comment: z.string().max(500).optional(),
});

router.post('/', authenticate(), validateBody(createReviewSchema), async (req, res, next) => {
  try {
    const review = await reviewsService.create({
      userId: req.user!.sub,
      ...req.body,
    });
    res.status(201).json(review);
  } catch (error) {
    next(error);
  }
});

router.get('/club/:id', async (req, res, next) => {
  try {
    const reviews = await reviewsService.findForClub(req.params.id);
    res.json(reviews);
  } catch (error) {
    next(error);
  }
});

export default router;

