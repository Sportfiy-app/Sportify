import { PrismaClient, FriendshipStatus } from '@prisma/client';
import createHttpError from 'http-errors';

import { prisma } from '../../db/prisma';

export class MessagesService {
  private db: PrismaClient;

  constructor() {
    this.db = prisma;
  }

  async sendMessage(senderId: string, receiverId: string, content: string) {
    if (senderId === receiverId) {
      throw createHttpError(400, 'Cannot send message to yourself');
    }

    // Check if users exist
    const [sender, receiver] = await Promise.all([
      this.db.user.findUnique({ where: { id: senderId } }),
      this.db.user.findUnique({ where: { id: receiverId } }),
    ]);

    if (!sender || !receiver) {
      throw createHttpError(404, 'User not found');
    }

    // Check if users are friends (optional - can be removed if messaging is open to all)
    const friendship = await this.db.friendship.findFirst({
      where: {
        OR: [
          { requesterId: senderId, addresseeId: receiverId },
          { requesterId: receiverId, addresseeId: senderId },
        ],
        status: FriendshipStatus.ACCEPTED,
      },
    });

    // Allow messaging even if not friends (can be changed to require friendship)
    // if (!friendship) {
    //   throw createHttpError(403, 'Can only message friends');
    // }

    const message = await this.db.message.create({
      data: {
        senderId,
        receiverId,
        content,
      },
      include: {
        sender: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
            email: true,
          },
        },
        receiver: {
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

    // Create notification for receiver
    await this.db.notification.create({
      data: {
        userId: receiverId,
        type: 'MESSAGE',
        message: `${sender.firstName || 'Someone'} ${sender.lastName || ''} vous a envoyé un message`,
      },
    });

    return message;
  }

  async getMessages(userId: string, otherUserId?: string, limit = 50, offset = 0) {
    const where: any = {
      OR: [
        { senderId: userId },
        { receiverId: userId },
      ],
    };

    // Filter by conversation with specific user
    if (otherUserId) {
      where.OR = [
        { senderId: userId, receiverId: otherUserId },
        { senderId: otherUserId, receiverId: userId },
      ];
    }

    const [messages, total] = await Promise.all([
      this.db.message.findMany({
        where,
        include: {
          sender: {
            select: {
              id: true,
              firstName: true,
              lastName: true,
              avatarUrl: true,
            },
          },
          receiver: {
            select: {
              id: true,
              firstName: true,
              lastName: true,
              avatarUrl: true,
            },
          },
        },
        orderBy: { createdAt: 'desc' },
        take: limit,
        skip: offset,
      }),
      this.db.message.count({ where }),
    ]);

    return {
      messages: messages.reverse(), // Reverse to show oldest first
      total,
      limit,
      offset,
    };
  }

  async getConversations(userId: string, limit = 20, offset = 0) {
    // Get all unique conversations (users who have sent/received messages)
    const messages = await this.db.message.findMany({
      where: {
        OR: [
          { senderId: userId },
          { receiverId: userId },
        ],
      },
      include: {
        sender: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
          },
        },
        receiver: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
          },
        },
      },
      orderBy: { createdAt: 'desc' },
    });

    // Group by conversation partner
    const conversationsMap = new Map<string, any>();

    for (const message of messages) {
      const partnerId = message.senderId === userId ? message.receiverId : message.senderId;
      const partner = message.senderId === userId ? message.receiver : message.sender;

      if (!conversationsMap.has(partnerId)) {
        conversationsMap.set(partnerId, {
          userId: partnerId,
          user: partner,
          lastMessage: message,
          unreadCount: 0,
        });
      } else {
        const conversation = conversationsMap.get(partnerId)!;
        // Update unread count if message is unread and receiver is current user
        if (!message.read && message.receiverId === userId) {
          conversation.unreadCount += 1;
        }
      }
    }

    const conversations = Array.from(conversationsMap.values())
      .sort((a, b) => {
        // Sort by last message date
        return new Date(b.lastMessage.createdAt).getTime() - new Date(a.lastMessage.createdAt).getTime();
      })
      .slice(offset, offset + limit);

    return {
      conversations,
      total: conversationsMap.size,
      limit,
      offset,
    };
  }

  async markAsRead(userId: string, messageIds: string[]) {
    const updated = await this.db.message.updateMany({
      where: {
        id: { in: messageIds },
        receiverId: userId,
        read: false,
      },
      data: {
        read: true,
        readAt: new Date(),
      },
    });

    return { updated: updated.count };
  }

  async getUnreadCount(userId: string) {
    const count = await this.db.message.count({
      where: {
        receiverId: userId,
        read: false,
      },
    });

    return { unreadCount: count };
  }

  async deleteMessage(userId: string, messageId: string) {
    const message = await this.db.message.findUnique({
      where: { id: messageId },
    });

    if (!message) {
      throw createHttpError(404, 'Message not found');
    }

    // Only sender can delete
    if (message.senderId !== userId) {
      throw createHttpError(403, 'Not authorized to delete this message');
    }

    await this.db.message.delete({
      where: { id: messageId },
    });

    return { deleted: true };
  }
}

