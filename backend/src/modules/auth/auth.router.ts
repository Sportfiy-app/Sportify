import { Router } from 'express';
import type { NextFunction, Request, Response } from 'express';

import { authenticate } from '../../middleware/auth';
import { validateBody } from '../../middleware/validate';

import { loginSchema, refreshSchema, registerSchema } from './auth.schema';
import { AuthService } from './auth.service';
import { sendSmsCodeSchema, verifySmsCodeSchema, sendEmailVerificationSchema, verifyEmailSchema } from './verification.schema';
import { VerificationService } from './verification.service';

const router = Router();
const authService = new AuthService();
const verificationService = new VerificationService();

router.post(
  '/register',
  validateBody(registerSchema),
  async (req: Request, res: Response, next: NextFunction) => {
  try {
    const tokens = await authService.register(req.body);
    res.status(201).json(tokens);
  } catch (error) {
    next(error);
  }
  },
);

router.post(
  '/login',
  validateBody(loginSchema),
  async (req: Request, res: Response, next: NextFunction) => {
  try {
    const tokens = await authService.login(req.body);
    res.json(tokens);
  } catch (error) {
    next(error);
  }
  },
);

router.post(
  '/refresh',
  validateBody(refreshSchema),
  async (req: Request, res: Response, next: NextFunction) => {
  try {
    const tokens = await authService.refresh(req.body.refreshToken);
    res.json(tokens);
  } catch (error) {
    next(error);
  }
  },
);

router.post(
  '/logout',
  authenticate(),
  async (req: Request, res: Response, next: NextFunction) => {
  try {
    await authService.logout(req.user!.sub);
    res.json({ success: true });
  } catch (error) {
    next(error);
  }
  },
);

// SMS Verification routes
router.post(
  '/verification/sms/send',
  authenticate(),
  validateBody(sendSmsCodeSchema),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const result = await verificationService.sendSmsCode(req.body.phone, req.user!.sub);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

router.post(
  '/verification/sms/verify',
  authenticate(),
  validateBody(verifySmsCodeSchema),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const result = await verificationService.verifySmsCode(req.body.phone, req.body.code, req.user!.sub);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

// Email Verification routes
router.post(
  '/verification/email/send',
  authenticate(),
  validateBody(sendEmailVerificationSchema),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const result = await verificationService.sendEmailVerification(req.body.email, req.user!.sub);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

router.post(
  '/verification/email/verify',
  validateBody(verifyEmailSchema),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const result = await verificationService.verifyEmail(req.body.token);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

export default router;

