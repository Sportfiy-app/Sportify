import { Router } from 'express';
import { z } from 'zod';

import { authenticate } from '../../middleware/auth';
import { validateBody } from '../../middleware/validate';
import { PaymentsService } from './payments.service';

const router = Router();
const paymentsService = new PaymentsService();

const createPaymentSchema = z.object({
  bookingId: z.string().cuid(),
  stripeIntentId: z.string().min(3),
  amount: z.number().int().positive(),
  currency: z.string().length(3).optional(),
});

router.post('/', authenticate(), validateBody(createPaymentSchema), async (req, res, next) => {
  try {
    const payment = await paymentsService.create({
      ...req.body,
      userId: req.user!.sub,
    });
    res.status(201).json(payment);
  } catch (error) {
    next(error);
  }
});

export default router;

