import { Router } from 'express';

import { authenticate } from '../../middleware/auth';
import { validateBody, validateQuery } from '../../middleware/validate';
import {
  createPostSchema,
  updatePostSchema,
  createCommentSchema,
  getPostsQuerySchema,
} from './posts.schema';
import { PostsService } from './posts.service';

const router = Router();
const postsService = new PostsService();

// Create post
router.post(
  '/',
  authenticate(),
  validateBody(createPostSchema),
  async (req, res, next) => {
    try {
      const userId = req.user!.sub;
      const post = await postsService.createPost(userId, req.body);
      res.status(201).json(post);
    } catch (error) {
      next(error);
    }
  },
);

// Get posts list
router.get(
  '/',
  validateQuery(getPostsQuerySchema),
  async (req, res, next) => {
    try {
      const userId = req.user?.sub;
      const result = await postsService.getPosts({
        sport: req.query.sport as string | undefined,
        type: req.query.type as any,
        authorId: req.query.authorId as string | undefined,
        limit: Number(req.query.limit) || 20,
        offset: Number(req.query.offset) || 0,
        latitude: req.query.latitude ? Number(req.query.latitude) : undefined,
        longitude: req.query.longitude ? Number(req.query.longitude) : undefined,
        radius: req.query.radius ? Number(req.query.radius) : undefined,
      }, userId);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

// Get post by ID
router.get(
  '/:id',
  async (req, res, next) => {
    try {
      const userId = req.user?.sub;
      const post = await postsService.getPostById(req.params.id, userId);
      res.json(post);
    } catch (error) {
      next(error);
    }
  },
);

// Update post
router.patch(
  '/:id',
  authenticate(),
  validateBody(updatePostSchema),
  async (req, res, next) => {
    try {
      const userId = req.user!.sub;
      const post = await postsService.updatePost(req.params.id, userId, req.body);
      res.json(post);
    } catch (error) {
      next(error);
    }
  },
);

// Delete post
router.delete(
  '/:id',
  authenticate(),
  async (req, res, next) => {
    try {
      const userId = req.user!.sub;
      const result = await postsService.deletePost(req.params.id, userId);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

// Like post
router.post(
  '/:id/like',
  authenticate(),
  async (req, res, next) => {
    try {
      const userId = req.user!.sub;
      const like = await postsService.likePost(req.params.id, userId);
      res.json(like);
    } catch (error) {
      next(error);
    }
  },
);

// Unlike post
router.delete(
  '/:id/like',
  authenticate(),
  async (req, res, next) => {
    try {
      const userId = req.user!.sub;
      const result = await postsService.unlikePost(req.params.id, userId);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

// Create comment
router.post(
  '/:id/comments',
  authenticate(),
  validateBody(createCommentSchema),
  async (req, res, next) => {
    try {
      const userId = req.user!.sub;
      const comment = await postsService.createComment(req.params.id, userId, req.body.content);
      res.status(201).json(comment);
    } catch (error) {
      next(error);
    }
  },
);

// Get comments
router.get(
  '/:id/comments',
  validateQuery(getPostsQuerySchema.pick({ limit: true, offset: true })),
  async (req, res, next) => {
    try {
      const result = await postsService.getComments(
        req.params.id,
        Number(req.query.limit) || 20,
        Number(req.query.offset) || 0,
      );
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

// Delete comment
router.delete(
  '/comments/:commentId',
  authenticate(),
  async (req, res, next) => {
    try {
      const userId = req.user!.sub;
      const result = await postsService.deleteComment(req.params.commentId, userId);
      res.json(result);
    } catch (error) {
      next(error);
    }
  },
);

export default router;

