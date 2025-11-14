import { Router } from 'express';

import { authenticate } from '../../middleware/auth';
import { HomeService } from './home.service';

const router = Router();
const homeService = new HomeService();

router.get('/', authenticate(false), async (req, res, next) => {
  try {
    const userId = req.user?.sub;
    const payload = await homeService.getHomeFeed(userId);
    res.json(payload);
  } catch (error) {
    next(error);
  }
});

export default router;
