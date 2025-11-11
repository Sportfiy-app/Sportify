import express from 'express';
import helmet from 'helmet';
import cors from 'cors';
import morgan from 'morgan';

import routes from './routes';
import { notFoundHandler, errorHandler } from './middleware/error-handler';

export function createApp() {
  const app = express();

  app.use(helmet());
  app.use(
    cors({
      origin: '*',
    }),
  );
  app.use(express.json());
  app.use(express.urlencoded({ extended: true }));
  app.use(morgan('dev'));

  app.get('/health', (_req, res) => {
    res.json({ status: 'ok' });
  });

  app.use('/api', routes);

  app.use(notFoundHandler);
  app.use(errorHandler);

  return app;
}

