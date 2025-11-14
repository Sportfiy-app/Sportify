import { EventStatus, ParticipationStatus } from '@prisma/client';

import { prisma } from '../../db/prisma';

import { EventsService } from './events.service';

jest.mock('../../db/prisma', () => ({
  prisma: {
    event: {
      create: jest.fn(),
      findUnique: jest.fn(),
      findMany: jest.fn(),
      update: jest.fn(),
      delete: jest.fn(),
    },
    eventParticipation: {
      create: jest.fn(),
      findUnique: jest.fn(),
      findFirst: jest.fn(),
      findMany: jest.fn(),
      delete: jest.fn(),
      updateMany: jest.fn(),
    },
  },
}));

describe('EventsService', () => {
  let eventsService: EventsService;

  beforeEach(() => {
    eventsService = new EventsService();
    jest.clearAllMocks();
  });

  describe('createEvent', () => {
    it('should create a new event', async () => {
      const eventData = {
        title: 'Football Match',
        description: 'A friendly football match',
        sport: 'FOOTBALL',
        location: 'Paris',
        date: '2024-12-25',
        time: '14:00',
        minParticipants: 10,
        maxParticipants: 22,
        isPublic: true,
        price: 0,
        priceCurrency: 'EUR',
        tags: [],
      };

      const createdEvent = {
        id: 'event-123',
        ...eventData,
        currentParticipants: 0,
        status: EventStatus.UPCOMING,
        createdAt: new Date(),
      };

      (prisma.event.create as jest.Mock).mockResolvedValue(createdEvent);

      const result = await eventsService.createEvent('user-123', eventData);

      expect(result).toEqual(createdEvent);
      expect(prisma.event.create).toHaveBeenCalledWith({
        data: expect.objectContaining({
          title: eventData.title,
          organizerId: 'user-123',
        }),
        include: expect.any(Object),
      });
    });
  });

  describe('getEventById', () => {
    it('should return event by id', async () => {
      const eventId = 'event-123';
      const mockEvent = {
        id: eventId,
        title: 'Football Match',
        organizer: {
          id: 'user-123',
          firstName: 'John',
          lastName: 'Doe',
        },
        participations: [],
      };

      (prisma.event.findUnique as jest.Mock).mockResolvedValue(mockEvent);
      (prisma.eventParticipation.findUnique as jest.Mock).mockResolvedValue(null);

      const result = await eventsService.getEventById(eventId);

      expect(result).toEqual({
        ...mockEvent,
        participants: [],
        waitingList: [],
        isUserJoined: false,
        isUserInWaitingList: false,
        userParticipationId: undefined,
      });
    });

    it('should throw error if event not found', async () => {
      (prisma.event.findUnique as jest.Mock).mockResolvedValue(null);

      await expect(eventsService.getEventById('nonexistent-id')).rejects.toThrow('Event not found');
    });
  });

  describe('joinEvent', () => {
    it('should join an event successfully', async () => {
      const eventId = 'event-123';
      const userId = 'user-456';
      const mockEvent = {
        id: eventId,
        maxParticipants: 22,
        currentParticipants: 10,
        participations: [],
      };

      (prisma.event.findUnique as jest.Mock).mockResolvedValue(mockEvent);
      (prisma.eventParticipation.findUnique as jest.Mock).mockResolvedValue(null);
      (prisma.eventParticipation.create as jest.Mock).mockResolvedValue({
        id: 'participation-123',
        eventId,
        userId,
        status: ParticipationStatus.JOINED,
      });
      (prisma.event.update as jest.Mock).mockResolvedValue({
        ...mockEvent,
        currentParticipants: 11,
      });

      const result = await eventsService.joinEvent(eventId, userId);

      expect(result).toHaveProperty('id');
      expect(prisma.eventParticipation.create).toHaveBeenCalled();
      expect(prisma.event.update).toHaveBeenCalledWith({
        where: { id: eventId },
        data: { currentParticipants: { increment: 1 } },
      });
    });

    it('should add to waiting list if event is full', async () => {
      const eventId = 'event-123';
      const userId = 'user-456';
      const mockEvent = {
        id: eventId,
        maxParticipants: 22,
        currentParticipants: 22,
        participations: [],
      };

      (prisma.event.findUnique as jest.Mock).mockResolvedValue(mockEvent);
      (prisma.eventParticipation.findUnique as jest.Mock).mockResolvedValue(null);
      (prisma.eventParticipation.findMany as jest.Mock).mockResolvedValue([]);
      (prisma.eventParticipation.create as jest.Mock).mockResolvedValue({
        id: 'participation-123',
        eventId,
        userId,
        status: ParticipationStatus.WAITING_LIST,
        position: 1,
      });

      const result = await eventsService.joinEvent(eventId, userId);

      expect(result.isWaitingList).toBe(true);
      expect(result.participation.status).toBe(ParticipationStatus.WAITING_LIST);
    });
  });

  describe('leaveEvent', () => {
    it('should leave an event successfully', async () => {
      const eventId = 'event-123';
      const userId = 'user-456';

      (prisma.eventParticipation.findFirst as jest.Mock).mockResolvedValue({
        id: 'participation-123',
        eventId,
        userId,
        status: ParticipationStatus.JOINED,
      });
      (prisma.eventParticipation.delete as jest.Mock).mockResolvedValue({});
      (prisma.event.update as jest.Mock).mockResolvedValue({});

      await eventsService.leaveEvent(eventId, userId);

      expect(prisma.eventParticipation.delete).toHaveBeenCalled();
    });
  });
});

