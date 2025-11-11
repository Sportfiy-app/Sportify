import 'express';
import type { JwtUser } from './index';

declare module 'express-serve-static-core' {
  interface Request {
    user?: JwtUser;
  }
}

