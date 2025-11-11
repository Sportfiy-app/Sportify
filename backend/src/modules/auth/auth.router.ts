import { Router } from 'express';

import { authenticate } from '../../middleware/auth';
import { validateBody } from '../../middleware/validate';

import { loginSchema, refreshSchema, registerSchema } from './auth.schema';
import { AuthService } from './auth.service';


const router = Router();
const authService = new AuthService();

router.post('/register', validateBody(registerSchema), async (req, res, next) => {
  try {
    const tokens = await authService.register(req.body);
    res.status(201).json(tokens);
  } catch (error) {
    next(error);
  }
});

router.post('/login', validateBody(loginSchema), async (req, res, next) => {
  try {
    const tokens = await authService.login(req.body);
    res.json(tokens);
  } catch (error) {
    next(error);
  }
});

router.post('/refresh', validateBody(refreshSchema), async (req, res, next) => {
  try {
    const tokens = await authService.refresh(req.body.refreshToken);
    res.json(tokens);
  } catch (error) {
    next(error);
  }
});

router.post('/logout', authenticate(), async (req, res, next) => {
  try {
    await authService.logout(req.user!.sub);
    res.json({ success: true });
  } catch (error) {
    next(error);
  }
});

export default router;

