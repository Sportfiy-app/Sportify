import { PostType } from '@prisma/client';

import { prisma } from '../../db/prisma';

import { PostsService } from './posts.service';

jest.mock('../../db/prisma', () => ({
  prisma: {
    post: {
      create: jest.fn(),
      findUnique: jest.fn(),
      findMany: jest.fn(),
      update: jest.fn(),
      delete: jest.fn(),
    },
    postLike: {
      create: jest.fn(),
      findUnique: jest.fn(),
      findFirst: jest.fn(),
      delete: jest.fn(),
    },
    postComment: {
      create: jest.fn(),
      findMany: jest.fn(),
      delete: jest.fn(),
    },
  },
}));

describe('PostsService', () => {
  let postsService: PostsService;

  beforeEach(() => {
    postsService = new PostsService();
    jest.clearAllMocks();
  });

  describe('createPost', () => {
    it('should create a new text post', async () => {
      const postData = {
        type: PostType.TEXT,
        content: 'This is a test post',
        sport: 'FOOTBALL',
      };

      const createdPost = {
        id: 'post-123',
        ...postData,
        createdAt: new Date(),
        author: {
          id: 'user-123',
          firstName: 'John',
          lastName: 'Doe',
        },
        likes: [],
        comments: [],
      };

      (prisma.post.create as jest.Mock).mockResolvedValue(createdPost);

      const result = await postsService.createPost('user-123', postData);

      expect(result).toEqual(createdPost);
      expect(prisma.post.create).toHaveBeenCalledWith({
        data: expect.objectContaining({
          authorId: 'user-123',
          type: postData.type,
          content: postData.content,
        }),
        include: expect.any(Object),
      });
    });

    it('should create a new image post', async () => {
      const postData = {
        type: PostType.IMAGE,
        content: 'Check out this image!',
        imageUrl: 'https://example.com/image.jpg',
        sport: 'BASKETBALL',
      };

      const createdPost = {
        id: 'post-123',
        ...postData,
        createdAt: new Date(),
      };

      (prisma.post.create as jest.Mock).mockResolvedValue(createdPost);

      const result = await postsService.createPost('user-123', postData);

      expect(result).toEqual(createdPost);
      expect(prisma.post.create).toHaveBeenCalledWith({
        data: expect.objectContaining({
          imageUrl: postData.imageUrl,
        }),
        include: expect.any(Object),
      });
    });
  });

  describe('getPostById', () => {
    it('should return post by id', async () => {
      const postId = 'post-123';
      const mockPost = {
        id: postId,
        content: 'Test post',
        author: {
          id: 'user-123',
          firstName: 'John',
        },
        likes: [],
        comments: [],
      };

      (prisma.post.findUnique as jest.Mock).mockResolvedValue(mockPost);
      (prisma.postLike.findUnique as jest.Mock).mockResolvedValue(null);

      const result = await postsService.getPostById(postId);

      expect(result).toEqual({
        ...mockPost,
        isLiked: false,
      });
    });
  });

  describe('likePost', () => {
    it('should like a post', async () => {
      const postId = 'post-123';
      const userId = 'user-456';

      (prisma.postLike.findUnique as jest.Mock).mockResolvedValue(null);
      (prisma.postLike.create as jest.Mock).mockResolvedValue({
        id: 'like-123',
        postId,
        userId,
      });

      const result = await postsService.likePost(postId, userId);

      expect(result).toHaveProperty('id');
      expect(prisma.postLike.create).toHaveBeenCalledWith({
        data: { postId, userId },
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
    });

    it('should throw error if post is already liked', async () => {
      const postId = 'post-123';
      const userId = 'user-456';

      (prisma.post.findUnique as jest.Mock).mockResolvedValue({ id: postId });
      (prisma.postLike.findUnique as jest.Mock).mockResolvedValue({
        id: 'like-123',
        postId,
        userId,
      });

      await expect(postsService.likePost(postId, userId)).rejects.toThrow('Post is already liked');
      expect(prisma.postLike.create).not.toHaveBeenCalled();
    });
  });

  describe('addComment', () => {
    it('should add a comment to a post', async () => {
      const postId = 'post-123';
      const userId = 'user-456';
      const content = 'Great post!';

      const createdComment = {
        id: 'comment-123',
        postId,
        userId,
        content,
        createdAt: new Date(),
        user: {
          id: userId,
          firstName: 'Jane',
          lastName: 'Smith',
        },
      };

      (prisma.postComment.create as jest.Mock).mockResolvedValue(createdComment);

      const result = await postsService.createComment(postId, userId, content);

      expect(result).toEqual(createdComment);
      expect(prisma.postComment.create).toHaveBeenCalledWith({
        data: { postId, userId, content },
        include: expect.any(Object),
      });
    });
  });
});

