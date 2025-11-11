import { Router } from 'express';
import { z } from 'zod';

import { authenticate } from '../../middleware/auth';
import { validateBody } from '../../middleware/validate';
import { BookingsService } from './bookings.service';

const router = Router();
const bookingsService = new BookingsService();

const createBookingSchema = z.object({
  clubId: z.string().cuid(),
  startsAt: z.coerce.date(),
  endsAt: z.coerce.date(),
});

router.post(
  '/',
  authenticate(),
  validateBody(createBookingSchema),
  async (req, res, next) => {
    try {
      const booking = await bookingsService.create({
        userId: req.user!.sub,
        clubId: req.body.clubId,
        startsAt: req.body.startsAt,
        endsAt: req.body.endsAt,
      });
      res.status(201).json(booking);
    } catch (error) {
      next(error);
    }
  },
);

router.get('/me', authenticate(), async (req, res, next) => {
  try {
    const bookings = await bookingsService.findMine(req.user!.sub);
    res.json(bookings);
  } catch (error) {
    next(error);
  }
});

export default router;

