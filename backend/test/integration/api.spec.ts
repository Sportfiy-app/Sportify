import request from 'supertest';
import { createApp } from '../../src/app';
import { prisma } from '../../src/db/prisma';
import bcrypt from 'bcrypt';

const app = createApp();

// Mock Prisma for integration tests
jest.mock('../../src/db/prisma', () => ({
  prisma: {
    user: {
      create: jest.fn(),
      findUnique: jest.fn(),
      update: jest.fn(),
    },
    event: {
      create: jest.fn(),
      findUnique: jest.fn(),
      findMany: jest.fn(),
    },
    post: {
      create: jest.fn(),
      findMany: jest.fn(),
    },
  },
}));

describe('API Integration Tests', () => {
  let accessToken: string;
  let userId: string;

  beforeAll(async () => {
    // Setup test user
    userId = 'test-user-123';
    const hashedPassword = await bcrypt.hash('password123', 10);

    (prisma.user.findUnique as jest.Mock).mockResolvedValue({
      id: userId,
      email: 'test@example.com',
      password: hashedPassword,
      firstName: 'Test',
      lastName: 'User',
    });
  });

  describe('POST /api/auth/register', () => {
    it('should register a new user', async () => {
      const userData = {
        email: 'newuser@example.com',
        password: 'password123',
        firstName: 'New',
        lastName: 'User',
        phone: '+33612345678',
      };

      (prisma.user.findUnique as jest.Mock).mockResolvedValue(null);
      (prisma.user.create as jest.Mock).mockResolvedValue({
        id: 'new-user-id',
        ...userData,
        password: 'hashed',
        role: 'USER',
      });

      const response = await request(app)
        .post('/api/auth/register')
        .send(userData)
        .expect(201);

      expect(response.body).toHaveProperty('accessToken');
      expect(response.body).toHaveProperty('refreshToken');
    });

    it('should return 400 for invalid email', async () => {
      const userData = {
        email: 'invalid-email',
        password: 'password123',
      };

      await request(app)
        .post('/api/auth/register')
        .send(userData)
        .expect(400);
    });
  });

  describe('POST /api/auth/login', () => {
    it('should login with correct credentials', async () => {
      const loginData = {
        email: 'test@example.com',
        password: 'password123',
      };

      const response = await request(app)
        .post('/api/auth/login')
        .send(loginData)
        .expect(200);

      expect(response.body).toHaveProperty('accessToken');
      accessToken = response.body.accessToken;
    });

    it('should return 401 for incorrect password', async () => {
      const loginData = {
        email: 'test@example.com',
        password: 'wrongpassword',
      };

      await request(app)
        .post('/api/auth/login')
        .send(loginData)
        .expect(401);
    });
  });

  describe('GET /api/users/me', () => {
    it('should get current user profile', async () => {
      (prisma.user.findUnique as jest.Mock).mockResolvedValue({
        id: userId,
        email: 'test@example.com',
        firstName: 'Test',
        lastName: 'User',
      });

      const response = await request(app)
        .get('/api/users/me')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(response.body).toHaveProperty('email');
      expect(response.body).toHaveProperty('firstName');
    });

    it('should return 401 without token', async () => {
      await request(app)
        .get('/api/users/me')
        .expect(401);
    });
  });

  describe('POST /api/events', () => {
    it('should create a new event', async () => {
      const eventData = {
        title: 'Test Event',
        description: 'Test Description',
        sport: 'FOOTBALL',
        location: 'Paris',
        date: '2024-12-25T00:00:00.000Z',
        time: '14:00',
        minParticipants: 10,
        maxParticipants: 22,
        isPublic: true,
        price: 0,
        priceCurrency: 'EUR',
      };

      (prisma.event.create as jest.Mock).mockResolvedValue({
        id: 'event-123',
        ...eventData,
        organizerId: userId,
        currentParticipants: 0,
        status: 'UPCOMING',
      });

      const response = await request(app)
        .post('/api/events')
        .set('Authorization', `Bearer ${accessToken}`)
        .send(eventData)
        .expect(201);

      expect(response.body).toHaveProperty('id');
      expect(response.body.title).toBe(eventData.title);
    });
  });

  describe('POST /api/posts', () => {
    it('should create a new post', async () => {
      const postData = {
        type: 'TEXT',
        content: 'This is a test post',
        sport: 'FOOTBALL',
      };

      (prisma.post.create as jest.Mock).mockResolvedValue({
        id: 'post-123',
        ...postData,
        authorId: userId,
        createdAt: new Date(),
      });

      const response = await request(app)
        .post('/api/posts')
        .set('Authorization', `Bearer ${accessToken}`)
        .send(postData)
        .expect(201);

      expect(response.body).toHaveProperty('id');
      expect(response.body.content).toBe(postData.content);
    });
  });
});

