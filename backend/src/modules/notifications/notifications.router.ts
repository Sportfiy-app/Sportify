import { Router } from 'express';

import { authenticate } from '../../middleware/auth';

import { NotificationsService } from './notifications.service';

const router = Router();
const notificationsService = new NotificationsService();

router.get('/', authenticate(), async (req, res, next) => {
  try {
    const notifications = await notificationsService.findForUser(req.user!.sub);
    res.json(notifications);
  } catch (error) {
    next(error);
  }
});

export default router;

