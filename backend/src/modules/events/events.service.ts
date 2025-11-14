import { PrismaClient, EventStatus, ParticipationStatus } from '@prisma/client';
import createHttpError from 'http-errors';

import { prisma } from '../../db/prisma';

export class EventsService {
  private db: PrismaClient;

  constructor() {
    this.db = prisma;
  }

  async createEvent(userId: string, data: {
    title: string;
    description: string;
    sport: string;
    location: string;
    address?: string;
    latitude?: number;
    longitude?: number;
    date: string;
    time: string;
    minParticipants: number;
    maxParticipants: number;
    isPublic: boolean;
    price?: number;
    priceCurrency: string;
    difficultyLevel?: string;
    tags: string[];
    imageUrl?: string;
  }) {
    const eventDate = new Date(data.date);
    const [hours, minutes] = data.time.split(':').map(Number);
    eventDate.setHours(hours, minutes, 0, 0);

    const event = await this.db.event.create({
      data: {
        title: data.title,
        description: data.description,
        sport: data.sport,
        location: data.location,
        address: data.address,
        latitude: data.latitude,
        longitude: data.longitude,
        date: eventDate,
        time: data.time,
        organizerId: userId,
        minParticipants: data.minParticipants,
        maxParticipants: data.maxParticipants,
        isPublic: data.isPublic,
        price: data.price,
        priceCurrency: data.priceCurrency,
        difficultyLevel: data.difficultyLevel,
        tags: data.tags,
        imageUrl: data.imageUrl,
        status: EventStatus.UPCOMING,
      },
      include: {
        organizer: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
            email: true,
          },
        },
        participations: {
          where: { status: ParticipationStatus.JOINED },
          include: {
            user: {
              select: {
                id: true,
                firstName: true,
                lastName: true,
                avatarUrl: true,
              },
            },
          },
        },
      },
    });

    return event;
  }

  async getEventById(eventId: string, userId?: string) {
    const event = await this.db.event.findUnique({
      where: { id: eventId },
      include: {
        organizer: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
            email: true,
          },
        },
        participations: {
          include: {
            user: {
              select: {
                id: true,
                firstName: true,
                lastName: true,
                avatarUrl: true,
              },
            },
          },
          orderBy: [
            { status: 'asc' },
            { createdAt: 'asc' },
          ],
        },
      },
    });

    if (!event) {
      throw createHttpError(404, 'Event not found');
    }

    // Check if user is participating
    let userParticipation = null;
    if (userId) {
      userParticipation = await this.db.eventParticipation.findUnique({
        where: {
          eventId_userId: {
            eventId,
            userId,
          },
        },
      });
    }

    const joinedParticipants = event.participations.filter(p => p.status === ParticipationStatus.JOINED);
    const waitingList = event.participations
      .filter(p => p.status === ParticipationStatus.WAITING_LIST)
      .sort((a, b) => (a.position || 0) - (b.position || 0));

    return {
      ...event,
      participants: joinedParticipants,
      waitingList,
      isUserJoined: userParticipation?.status === ParticipationStatus.JOINED,
      isUserInWaitingList: userParticipation?.status === ParticipationStatus.WAITING_LIST,
      userParticipationId: userParticipation?.id,
    };
  }

  async getEvents(filters: {
    sport?: string;
    status?: EventStatus;
    limit: number;
    offset: number;
    latitude?: number;
    longitude?: number;
    radius?: number;
  }) {
    const where: any = {};

    if (filters.sport) {
      where.sport = filters.sport;
    }

    if (filters.status) {
      where.status = filters.status;
    }

    const events = await this.db.event.findMany({
      where,
      include: {
        organizer: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
          },
        },
        participations: {
          where: { status: ParticipationStatus.JOINED },
          take: 5, // Limit participants in list
        },
      },
      orderBy: { date: 'asc' },
      take: filters.limit,
      skip: filters.offset,
    });

    const total = await this.db.event.count({ where });

    return {
      events,
      total,
      limit: filters.limit,
      offset: filters.offset,
    };
  }

  async joinEvent(eventId: string, userId: string) {
    // Check if event exists
    const event = await this.db.event.findUnique({
      where: { id: eventId },
      include: {
        participations: {
          where: { status: ParticipationStatus.JOINED },
        },
      },
    });

    if (!event) {
      throw createHttpError(404, 'Event not found');
    }

    // Check if event is full
    const isFull = event.participations.length >= event.maxParticipants;

    // Check if user is already participating
    const existingParticipation = await this.db.eventParticipation.findUnique({
      where: {
        eventId_userId: {
          eventId,
          userId,
        },
      },
    });

    if (existingParticipation) {
      if (existingParticipation.status === ParticipationStatus.JOINED) {
        throw createHttpError(400, 'User is already joined to this event');
      }
      if (existingParticipation.status === ParticipationStatus.WAITING_LIST) {
        throw createHttpError(400, 'User is already in waiting list');
      }
    }

    if (isFull) {
      // Add to waiting list
      const waitingListCount = await this.db.eventParticipation.count({
        where: {
          eventId,
          status: ParticipationStatus.WAITING_LIST,
        },
      });

      const participation = await this.db.eventParticipation.create({
        data: {
          eventId,
          userId,
          status: ParticipationStatus.WAITING_LIST,
          position: waitingListCount + 1,
        },
        include: {
          user: {
            select: {
              id: true,
              firstName: true,
              lastName: true,
              avatarUrl: true,
            },
          },
        },
      });

      return { participation, isWaitingList: true };
    } else {
      // Join directly
      const participation = await this.db.eventParticipation.create({
        data: {
          eventId,
          userId,
          status: ParticipationStatus.JOINED,
        },
        include: {
          user: {
            select: {
              id: true,
              firstName: true,
              lastName: true,
              avatarUrl: true,
            },
          },
        },
      });

      // Update current participants count
      await this.db.event.update({
        where: { id: eventId },
        data: {
          currentParticipants: {
            increment: 1,
          },
        },
      });

      return { participation, isWaitingList: false };
    }
  }

  async leaveEvent(eventId: string, userId: string) {
    const participation = await this.db.eventParticipation.findUnique({
      where: {
        eventId_userId: {
          eventId,
          userId,
        },
      },
    });

    if (!participation) {
      throw createHttpError(404, 'Participation not found');
    }

    const wasJoined = participation.status === ParticipationStatus.JOINED;

    // Delete participation
    await this.db.eventParticipation.delete({
      where: {
        id: participation.id,
      },
    });

    if (wasJoined) {
      // Update current participants count
      await this.db.event.update({
        where: { id: eventId },
        data: {
          currentParticipants: {
            decrement: 1,
          },
        },
      });

      // Promote first person from waiting list if any
      const firstWaiting = await this.db.eventParticipation.findFirst({
        where: {
          eventId,
          status: ParticipationStatus.WAITING_LIST,
        },
        orderBy: {
          position: 'asc',
        },
      });

      if (firstWaiting) {
        // Promote to joined
        await this.db.eventParticipation.update({
          where: { id: firstWaiting.id },
          data: {
            status: ParticipationStatus.JOINED,
            position: null,
          },
        });

        // Update positions of remaining waiting list
        const remainingWaiting = await this.db.eventParticipation.findMany({
          where: {
            eventId,
            status: ParticipationStatus.WAITING_LIST,
            position: {
              gt: firstWaiting.position || 0,
            },
          },
        });

        for (const waiting of remainingWaiting) {
          await this.db.eventParticipation.update({
            where: { id: waiting.id },
            data: {
              position: (waiting.position || 0) - 1,
            },
          });
        }

        // Update current participants count
        await this.db.event.update({
          where: { id: eventId },
          data: {
            currentParticipants: {
              increment: 1,
            },
          },
        });

        return { promoted: true, promotedUserId: firstWaiting.userId };
      }
    } else {
      // User was in waiting list, update positions
      const position = participation.position || 0;
      const remainingWaiting = await this.db.eventParticipation.findMany({
        where: {
          eventId,
          status: ParticipationStatus.WAITING_LIST,
          position: {
            gt: position,
          },
        },
      });

      for (const waiting of remainingWaiting) {
        await this.db.eventParticipation.update({
          where: { id: waiting.id },
          data: {
            position: (waiting.position || 0) - 1,
          },
        });
      }
    }

    return { promoted: false };
  }

  async updateEvent(eventId: string, userId: string, data: Partial<{
    title: string;
    description: string;
    sport: string;
    location: string;
    address: string;
    latitude: number;
    longitude: number;
    date: string;
    time: string;
    minParticipants: number;
    maxParticipants: number;
    isPublic: boolean;
    price: number;
    priceCurrency: string;
    difficultyLevel: string;
    tags: string[];
    imageUrl: string;
  }>) {
    // Check if user is the organizer
    const event = await this.db.event.findUnique({
      where: { id: eventId },
    });

    if (!event) {
      throw createHttpError(404, 'Event not found');
    }

    if (event.organizerId !== userId) {
      throw createHttpError(403, 'Only the organizer can update the event');
    }

    const updateData: any = { ...data };

    if (data.date && data.time) {
      const eventDate = new Date(data.date);
      const [hours, minutes] = data.time.split(':').map(Number);
      eventDate.setHours(hours, minutes, 0, 0);
      updateData.date = eventDate;
    }

    const updated = await this.db.event.update({
      where: { id: eventId },
      data: updateData,
      include: {
        organizer: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
          },
        },
      },
    });

    return updated;
  }

  async deleteEvent(eventId: string, userId: string) {
    const event = await this.db.event.findUnique({
      where: { id: eventId },
    });

    if (!event) {
      throw createHttpError(404, 'Event not found');
    }

    if (event.organizerId !== userId) {
      throw createHttpError(403, 'Only the organizer can delete the event');
    }

    await this.db.event.delete({
      where: { id: eventId },
    });

    return { success: true };
  }
}

