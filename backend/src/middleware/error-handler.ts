import { NextFunction, Request, Response } from 'express';
import createHttpError, { HttpError } from 'http-errors';

export function notFoundHandler(req: Request, _res: Response, next: NextFunction) {
  next(createHttpError(404, `Route ${req.originalUrl} not found`));
}

export function errorHandler(
  err: Error | HttpError,
  _req: Request,
  res: Response,
  _next: NextFunction,
) {
  const httpError = createHttpError(err);
  const status = httpError.status ?? 500;
  const response = {
    status,
    message: httpError.message,
    ...(process.env.NODE_ENV === 'development' && { stack: err.stack }),
  };
  res.status(status).json(response);
}

