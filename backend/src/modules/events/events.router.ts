import { Router } from 'express';

import { authenticate } from '../../middleware/auth';
import { validateBody, validateQuery } from '../../middleware/validate';

import {
  createEventSchema,
  updateEventSchema,
  getEventsQuerySchema,
} from './events.schema';
import { EventsService } from './events.service';

const router = Router();
const eventsService = new EventsService();

// Create event
router.post(
  '/',
  authenticate(),
  validateBody(createEventSchema),
  async (req, res, next) => {
    try {
      const userId = req.user!.sub;
      const event = await eventsService.createEvent(userId, req.body);
      res.status(201).json(event);
    } catch (error) {
      next(error);
    }
  },
);

// Get events list
router.get(
  '/',
  validateQuery(getEventsQuerySchema),
  async (req, res, next) => {
    try {
      const result = await eventsService.getEvents({
        sport: req.query.sport as string | undefined,
        status: req.query.status as any,
        limit: Number(req.query.limit) || 20,
        offset: Number(req.query.offset) || 0,
        latitude: req.query.latitude ? Number(req.query.latitude) : undefined,
        longitude: req.query.longitude ? Number(req.query.longitude) : undefined,
        radius: req.query.radius ? Number(req.query.radius) : undefined,
      });
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

// Get event by ID
router.get(
  '/:id',
  async (req, res, next) => {
    try {
      const userId = req.user?.sub;
      const event = await eventsService.getEventById(req.params.id, userId);
      res.json(event);
    } catch (error) {
      next(error);
    }
  },
);

// Update event
router.patch(
  '/:id',
  authenticate(),
  validateBody(updateEventSchema),
  async (req, res, next) => {
    try {
      const userId = req.user!.sub;
      const event = await eventsService.updateEvent(req.params.id, userId, req.body);
      res.json(event);
    } catch (error) {
      next(error);
    }
  },
);

// Delete event
router.delete(
  '/:id',
  authenticate(),
  async (req, res, next) => {
    try {
      const userId = req.user!.sub;
      const result = await eventsService.deleteEvent(req.params.id, userId);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

// Join event
router.post(
  '/:id/join',
  authenticate(),
  async (req, res, next) => {
    try {
      const userId = req.user!.sub;
      const result = await eventsService.joinEvent(req.params.id, userId);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

// Leave event
router.post(
  '/:id/leave',
  authenticate(),
  async (req, res, next) => {
    try {
      const userId = req.user!.sub;
      const result = await eventsService.leaveEvent(req.params.id, userId);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

export default router;
