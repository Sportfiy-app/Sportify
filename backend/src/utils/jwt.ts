import jwt, { SignOptions } from 'jsonwebtoken';

import { config } from '../config';
import { JwtUser } from '../types';

export function signAccessToken(payload: JwtUser): string {
  const options: SignOptions = { expiresIn: config.jwt.accessTtl as SignOptions['expiresIn'] };
  return jwt.sign(payload, config.jwt.accessSecret, options);
}

export function signRefreshToken(payload: JwtUser): string {
  const options: SignOptions = { expiresIn: config.jwt.refreshTtl as SignOptions['expiresIn'] };
  return jwt.sign(payload, config.jwt.refreshSecret, options);
}

export function verifyRefreshToken(token: string): JwtUser {
  return jwt.verify(token, config.jwt.refreshSecret) as JwtUser;
}

