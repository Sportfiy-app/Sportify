import { PrismaClient, FriendshipStatus } from '@prisma/client';
import createHttpError from 'http-errors';

import { prisma } from '../../db/prisma';

export class FriendsService {
  private db: PrismaClient;

  constructor() {
    this.db = prisma;
  }

  async sendFriendRequest(requesterId: string, addresseeId: string) {
    if (requesterId === addresseeId) {
      throw createHttpError(400, 'Cannot send friend request to yourself');
    }

    // Check if users exist
    const [requester, addressee] = await Promise.all([
      this.db.user.findUnique({ where: { id: requesterId } }),
      this.db.user.findUnique({ where: { id: addresseeId } }),
    ]);

    if (!requester || !addressee) {
      throw createHttpError(404, 'User not found');
    }

    // Check if friendship already exists
    const existingFriendship = await this.db.friendship.findFirst({
      where: {
        OR: [
          { requesterId, addresseeId },
          { requesterId: addresseeId, addresseeId: requesterId },
        ],
      },
    });

    if (existingFriendship) {
      if (existingFriendship.status === FriendshipStatus.ACCEPTED) {
        throw createHttpError(409, 'Already friends');
      }
      if (existingFriendship.status === FriendshipStatus.BLOCKED) {
        throw createHttpError(403, 'Cannot send friend request to blocked user');
      }
      if (existingFriendship.status === FriendshipStatus.PENDING) {
        throw createHttpError(409, 'Friend request already pending');
      }
    }

    const friendship = await this.db.friendship.create({
      data: {
        requesterId,
        addresseeId,
        status: FriendshipStatus.PENDING,
      },
      include: {
        requester: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
            email: true,
          },
        },
        addressee: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
            email: true,
          },
        },
      },
    });

    // Create notification for addressee
    await this.db.notification.create({
      data: {
        userId: addresseeId,
        type: 'FRIEND_REQUEST',
        message: `${requester.firstName || 'Someone'} ${requester.lastName || ''} vous a envoyé une demande d'ami`,
      },
    });

    return friendship;
  }

  async respondToFriendRequest(userId: string, friendshipId: string, action: 'accept' | 'reject' | 'block') {
    const friendship = await this.db.friendship.findUnique({
      where: { id: friendshipId },
      include: {
        requester: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
          },
        },
        addressee: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
          },
        },
      },
    });

    if (!friendship) {
      throw createHttpError(404, 'Friend request not found');
    }

    // Only addressee can respond
    if (friendship.addresseeId !== userId) {
      throw createHttpError(403, 'Only the recipient can respond to friend requests');
    }

    if (friendship.status !== FriendshipStatus.PENDING) {
      throw createHttpError(400, 'Friend request is not pending');
    }

    if (action === 'accept') {
      const updated = await this.db.friendship.update({
        where: { id: friendshipId },
        data: { status: FriendshipStatus.ACCEPTED },
        include: {
          requester: {
            select: {
              id: true,
              firstName: true,
              lastName: true,
              avatarUrl: true,
              email: true,
            },
          },
          addressee: {
            select: {
              id: true,
              firstName: true,
              lastName: true,
              avatarUrl: true,
              email: true,
            },
          },
        },
      });

      // Create notification for requester
      await this.db.notification.create({
        data: {
          userId: friendship.requesterId,
          type: 'FRIEND_REQUEST_ACCEPTED',
          message: `${friendship.addressee.firstName || 'Someone'} ${friendship.addressee.lastName || ''} a accepté votre demande d'ami`,
        },
      });

      return updated;
    } else if (action === 'reject') {
      await this.db.friendship.delete({
        where: { id: friendshipId },
      });
      return { deleted: true };
    } else if (action === 'block') {
      const updated = await this.db.friendship.update({
        where: { id: friendshipId },
        data: { status: FriendshipStatus.BLOCKED },
        include: {
          requester: {
            select: {
              id: true,
              firstName: true,
              lastName: true,
              avatarUrl: true,
              email: true,
            },
          },
          addressee: {
            select: {
              id: true,
              firstName: true,
              lastName: true,
              avatarUrl: true,
              email: true,
            },
          },
        },
      });
      return updated;
    }

    throw createHttpError(400, 'Invalid action');
  }

  async getFriends(userId: string, status?: FriendshipStatus, limit = 20, offset = 0) {
    const where: any = {
      OR: [
        { requesterId: userId },
        { addresseeId: userId },
      ],
    };

    if (status) {
      where.status = status;
    } else {
      // Default to accepted friends
      where.status = FriendshipStatus.ACCEPTED;
    }

    const [friendships, total] = await Promise.all([
      this.db.friendship.findMany({
        where,
        include: {
          requester: {
            select: {
              id: true,
              firstName: true,
              lastName: true,
              avatarUrl: true,
              email: true,
              city: true,
            },
          },
          addressee: {
            select: {
              id: true,
              firstName: true,
              lastName: true,
              avatarUrl: true,
              email: true,
              city: true,
            },
          },
        },
        orderBy: { createdAt: 'desc' },
        take: limit,
        skip: offset,
      }),
      this.db.friendship.count({ where }),
    ]);

    // Map friendships to friend objects (the other user)
    const friends = friendships.map((friendship) => {
      const friend = friendship.requesterId === userId
        ? friendship.addressee
        : friendship.requester;
      return {
        ...friend,
        friendshipId: friendship.id,
        status: friendship.status,
        createdAt: friendship.createdAt,
      };
    });

    return {
      friends,
      total,
      limit,
      offset,
    };
  }

  async getFriendRequests(userId: string, type: 'sent' | 'received' = 'received') {
    const where: any = {
      status: FriendshipStatus.PENDING,
    };

    if (type === 'sent') {
      where.requesterId = userId;
    } else {
      where.addresseeId = userId;
    }

    const requests = await this.db.friendship.findMany({
      where,
      include: {
        requester: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
            email: true,
          },
        },
        addressee: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
            email: true,
          },
        },
      },
      orderBy: { createdAt: 'desc' },
    });

    return requests;
  }

  async removeFriend(userId: string, friendshipId: string) {
    const friendship = await this.db.friendship.findUnique({
      where: { id: friendshipId },
    });

    if (!friendship) {
      throw createHttpError(404, 'Friendship not found');
    }

    // Only participants can remove
    if (friendship.requesterId !== userId && friendship.addresseeId !== userId) {
      throw createHttpError(403, 'Not authorized to remove this friendship');
    }

    await this.db.friendship.delete({
      where: { id: friendshipId },
    });

    return { deleted: true };
  }

  async cancelFriendRequest(userId: string, friendshipId: string) {
    const friendship = await this.db.friendship.findUnique({
      where: { id: friendshipId },
    });

    if (!friendship) {
      throw createHttpError(404, 'Friend request not found');
    }

    // Only requester can cancel their own request
    if (friendship.requesterId !== userId) {
      throw createHttpError(403, 'Only the requester can cancel their friend request');
    }

    if (friendship.status !== FriendshipStatus.PENDING) {
      throw createHttpError(400, 'Can only cancel pending friend requests');
    }

    await this.db.friendship.delete({
      where: { id: friendshipId },
    });

    return { deleted: true };
  }

  async getFriendshipStatus(userId: string, otherUserId: string) {
    if (userId === otherUserId) {
      return { status: 'self' };
    }

    const friendship = await this.db.friendship.findFirst({
      where: {
        OR: [
          { requesterId: userId, addresseeId: otherUserId },
          { requesterId: otherUserId, addresseeId: userId },
        ],
      },
    });

    if (!friendship) {
      return { status: 'none' };
    }

    return {
      status: friendship.status,
      friendshipId: friendship.id,
      isRequester: friendship.requesterId === userId,
    };
  }
}

