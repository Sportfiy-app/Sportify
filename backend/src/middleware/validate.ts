import { NextFunction, Request, Response } from 'express';
import createHttpError from 'http-errors';
import { AnyZodObject } from 'zod';

export function validateBody(schema: AnyZodObject) {
  return (req: Request, _res: Response, next: NextFunction) => {
    try {
      req.body = schema.parse(req.body);
      next();
    } catch (error: any) {
      // Log validation errors for debugging
      console.error('Validation errors:', JSON.stringify(error.errors || error, null, 2));
      console.error('Request body:', JSON.stringify(req.body, null, 2));
      
      // Format Zod errors for better error messages
      let errorMessage = 'Invalid request body';
      if (error.errors && Array.isArray(error.errors) && error.errors.length > 0) {
        const firstError = error.errors[0];
        if (firstError.path && firstError.message) {
          errorMessage = `${firstError.path.join('.')}: ${firstError.message}`;
        } else if (firstError.message) {
          errorMessage = firstError.message;
        }
      }
      
      next(createHttpError(400, errorMessage, { 
        cause: error,
        errors: error.errors || [],
      }));
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

