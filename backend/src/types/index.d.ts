import 'express';

export interface JwtUser {
  sub: string;
  email: string;
  role: 'USER' | 'CLUB_MANAGER' | 'ADMIN';
}

declare module 'express-serve-static-core' {
  interface Request {
    user?: JwtUser;
  }
}

