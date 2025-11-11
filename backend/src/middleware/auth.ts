import { NextFunction, Request, Response } from 'express';
import createHttpError from 'http-errors';
import jwt from 'jsonwebtoken';

import { config } from '../config';
import { JwtUser } from '../types';

export function authenticate(required = true) {
  return (req: Request, _res: Response, next: NextFunction) => {
    const authorization = req.headers.authorization;
    if (!authorization) {
      if (!required) {
        return next();
      }
      return next(createHttpError(401, 'Authorization header missing'));
    }

    const token = authorization.replace(/Bearer\s+/i, '').trim();
    try {
      const payload = jwt.verify(token, config.jwt.accessSecret) as JwtUser;
      req.user = payload;
      return next();
    } catch (error) {
      return next(createHttpError(401, 'Invalid or expired token'));
    }
  };
}

