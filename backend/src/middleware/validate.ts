import { NextFunction, Request, Response } from 'express';
import { AnyZodObject } from 'zod';
import createHttpError from 'http-errors';

export function validateBody(schema: AnyZodObject) {
  return (req: Request, _res: Response, next: NextFunction) => {
    try {
      req.body = schema.parse(req.body);
      next();
    } catch (error) {
      next(createHttpError(400, 'Invalid request body', { cause: error }));
    }
  };
}

export function validateQuery(schema: AnyZodObject) {
  return (req: Request, _res: Response, next: NextFunction) => {
    try {
      req.query = schema.parse(req.query);
      next();
    } catch (error) {
      next(createHttpError(400, 'Invalid query parameters', { cause: error }));
    }
  };
}

