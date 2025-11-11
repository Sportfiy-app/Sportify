import jwt from 'jsonwebtoken';

import { config } from '../config';
import { JwtUser } from '../types';

export function signAccessToken(payload: JwtUser): string {
  return jwt.sign(payload, config.jwt.accessSecret, { expiresIn: config.jwt.accessTtl });
}

export function signRefreshToken(payload: JwtUser): string {
  return jwt.sign(payload, config.jwt.refreshSecret, { expiresIn: config.jwt.refreshTtl });
}

export function verifyRefreshToken(token: string): JwtUser {
  return jwt.verify(token, config.jwt.refreshSecret) as JwtUser;
}

