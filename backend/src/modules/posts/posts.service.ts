import { PrismaClient } from '@prisma/client';
import createHttpError from 'http-errors';

import { prisma } from '../../db/prisma';

export class PostsService {
  private db: PrismaClient;

  constructor() {
    this.db = prisma;
  }

  async createPost(userId: string, data: {
    content: string;
    type: 'TEXT' | 'IMAGE' | 'EVENT';
    imageUrl?: string;
    sport?: string;
    location?: string;
    latitude?: number;
    longitude?: number;
    eventId?: string;
  }) {
    const post = await this.db.post.create({
      data: {
        authorId: userId,
        content: data.content,
        type: data.type,
        imageUrl: data.imageUrl,
        sport: data.sport,
        location: data.location,
        latitude: data.latitude,
        longitude: data.longitude,
        eventId: data.eventId,
      },
      include: {
        author: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
            email: true,
          },
        },
        _count: {
          select: {
            likes: true,
            comments: true,
          },
        },
      },
    });

    return post;
  }

  async getPostById(postId: string, userId?: string) {
    const post = await this.db.post.findUnique({
      where: { id: postId },
      include: {
        author: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
          },
        },
        likes: userId ? {
          where: { userId },
          take: 1,
        } : false,
        comments: {
          take: 10,
          orderBy: { createdAt: 'desc' },
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
        _count: {
          select: {
            likes: true,
            comments: true,
          },
        },
      },
    });

    if (!post) {
      throw createHttpError(404, 'Post not found');
    }

    const likesArray = 'likes' in post && Array.isArray(post.likes) ? post.likes : [];
    return {
      ...post,
      isLiked: userId ? likesArray.length > 0 : false,
    };
  }

  async getPosts(filters: {
    sport?: string;
    type?: 'TEXT' | 'IMAGE' | 'EVENT';
    authorId?: string;
    limit: number;
    offset: number;
    latitude?: number;
    longitude?: number;
    radius?: number;
  }, userId?: string) {
    const where: any = {};

    if (filters.sport) {
      where.sport = filters.sport;
    }

    if (filters.type) {
      where.type = filters.type;
    }

    if (filters.authorId) {
      where.authorId = filters.authorId;
    }

    const posts = await this.db.post.findMany({
      where,
      include: {
        author: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
          },
        },
        likes: userId ? {
          where: { userId },
          take: 1,
        } : false,
        _count: {
          select: {
            likes: true,
            comments: true,
          },
        },
      },
      orderBy: { createdAt: 'desc' },
      take: filters.limit,
      skip: filters.offset,
    });

    const total = await this.db.post.count({ where });

    const postsWithLikes = posts.map((post: any) => {
      const likesArray = 'likes' in post && Array.isArray(post.likes) ? post.likes : [];
      return {
        ...post,
        isLiked: userId ? likesArray.length > 0 : false,
      };
    });

    return {
      posts: postsWithLikes,
      total,
      limit: filters.limit,
      offset: filters.offset,
    };
  }

  async updatePost(postId: string, userId: string, data: Partial<{
    content: string;
    imageUrl: string;
    sport: string;
    location: string;
  }>) {
    // Check if user is the author
    const post = await this.db.post.findUnique({
      where: { id: postId },
    });

    if (!post) {
      throw createHttpError(404, 'Post not found');
    }

    if (post.authorId !== userId) {
      throw createHttpError(403, 'Only the author can update the post');
    }

    const updated = await this.db.post.update({
      where: { id: postId },
      data,
      include: {
        author: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatarUrl: true,
          },
        },
        _count: {
          select: {
            likes: true,
            comments: true,
          },
        },
      },
    });

    return updated;
  }

  async deletePost(postId: string, userId: string) {
    const post = await this.db.post.findUnique({
      where: { id: postId },
    });

    if (!post) {
      throw createHttpError(404, 'Post not found');
    }

    if (post.authorId !== userId) {
      throw createHttpError(403, 'Only the author can delete the post');
    }

    await this.db.post.delete({
      where: { id: postId },
    });

    return { success: true };
  }

  async likePost(postId: string, userId: string) {
    // Check if post exists
    const post = await this.db.post.findUnique({
      where: { id: postId },
    });

    if (!post) {
      throw createHttpError(404, 'Post not found');
    }

    // Check if already liked
    const existingLike = await this.db.postLike.findUnique({
      where: {
        postId_userId: {
          postId,
          userId,
        },
      },
    });

    if (existingLike) {
      throw createHttpError(400, 'Post is already liked');
    }

    const like = await this.db.postLike.create({
      data: {
        postId,
        userId,
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

    return like;
  }

  async unlikePost(postId: string, userId: string) {
    const like = await this.db.postLike.findUnique({
      where: {
        postId_userId: {
          postId,
          userId,
        },
      },
    });

    if (!like) {
      throw createHttpError(404, 'Like not found');
    }

    await this.db.postLike.delete({
      where: {
        id: like.id,
      },
    });

    return { success: true };
  }

  async createComment(postId: string, userId: string, content: string) {
    // Check if post exists
    const post = await this.db.post.findUnique({
      where: { id: postId },
    });

    if (!post) {
      throw createHttpError(404, 'Post not found');
    }

    const comment = await this.db.postComment.create({
      data: {
        postId,
        userId,
        content,
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

    return comment;
  }

  async getComments(postId: string, limit: number = 20, offset: number = 0) {
    const comments = await this.db.postComment.findMany({
      where: { postId },
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
      orderBy: { createdAt: 'desc' },
      take: limit,
      skip: offset,
    });

    const total = await this.db.postComment.count({
      where: { postId },
    });

    return {
      comments,
      total,
      limit,
      offset,
    };
  }

  async deleteComment(commentId: string, userId: string) {
    const comment = await this.db.postComment.findUnique({
      where: { id: commentId },
    });

    if (!comment) {
      throw createHttpError(404, 'Comment not found');
    }

    if (comment.userId !== userId) {
      throw createHttpError(403, 'Only the author can delete the comment');
    }

    await this.db.postComment.delete({
      where: { id: commentId },
    });

    return { success: true };
  }
}

