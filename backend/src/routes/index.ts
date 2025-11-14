import { Router } from 'express';

import authRouter from '../modules/auth/auth.router';
import homeRouter from '../modules/home/home.router';
import bookingsRouter from '../modules/bookings/bookings.router';
import clubsRouter from '../modules/clubs/clubs.router';
import notificationsRouter from '../modules/notifications/notifications.router';
import paymentsRouter from '../modules/payments/payments.router';
import reviewsRouter from '../modules/reviews/reviews.router';
import usersRouter from '../modules/users/users.router';
import eventsRouter from '../modules/events/events.router';
import postsRouter from '../modules/posts/posts.router';
import subscriptionsRouter from '../modules/subscriptions/subscriptions.router';

const router = Router();

router.use('/auth', authRouter);
router.use('/home', homeRouter);
router.use('/users', usersRouter);
router.use('/clubs', clubsRouter);
router.use('/bookings', bookingsRouter);
router.use('/payments', paymentsRouter);
router.use('/notifications', notificationsRouter);
router.use('/reviews', reviewsRouter);
router.use('/events', eventsRouter);
router.use('/posts', postsRouter);
router.use('/subscriptions', subscriptionsRouter);

export default router;

