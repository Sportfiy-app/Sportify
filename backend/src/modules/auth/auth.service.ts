import bcrypt from 'bcrypt';
import createHttpError from 'http-errors';

import { prisma } from '../../db/prisma';
import { JwtUser } from '../../types';
import { signAccessToken, signRefreshToken, verifyRefreshToken } from '../../utils/jwt';

import { registerSchema, loginSchema } from './auth.schema';

export class AuthService {
  async register(rawData: unknown) {
    const data = registerSchema.parse(rawData);
    const existing = await prisma.user.findUnique({ where: { email: data.email } });
    if (existing) {
      throw createHttpError(409, 'Email already registered');
    }

    const passwordHash = await bcrypt.hash(data.password, 10);
    
    // Parse dateOfBirth if provided
    let dateOfBirth: Date | undefined;
    if (data.dateOfBirth) {
      dateOfBirth = new Date(data.dateOfBirth);
    }
    
    const user = await prisma.user.create({
      data: {
        email: data.email,
        phone: data.phone,
        passwordHash,
        role: data.role ?? 'USER',
        firstName: data.firstName,
        lastName: data.lastName,
        dateOfBirth,
        gender: data.gender,
        city: data.city,
      },
    });

    return this.generateTokens(user);
  }

  async login(rawData: unknown) {
    const data = loginSchema.parse(rawData);
    const user = await prisma.user.findUnique({ where: { email: data.email } });
    if (!user) {
      throw createHttpError(401, 'Invalid credentials');
    }

    const isValid = await bcrypt.compare(data.password, user.passwordHash);
    if (!isValid) {
      throw createHttpError(401, 'Invalid credentials');
    }

    return this.generateTokens(user);
  }

  async refresh(refreshToken: string) {
    const payload = verifyRefreshToken(refreshToken);
    const user = await prisma.user.findUnique({ where: { id: payload.sub } });
    if (!user || !user.refreshTokenHash) {
      throw createHttpError(401, 'Invalid refresh token');
    }

    const matches = await bcrypt.compare(refreshToken, user.refreshTokenHash);
    if (!matches) {
      throw createHttpError(401, 'Invalid refresh token');
    }

    return this.generateTokens(user);
  }

  async logout(userId: string) {
    await prisma.user.update({
      where: { id: userId },
      data: { refreshTokenHash: null },
    });
    return { success: true };
  }

  private async generateTokens(user: { id: string; email: string; role: string }) {
    const payload: JwtUser = { sub: user.id, email: user.email, role: user.role as JwtUser['role'] };
    const accessToken = signAccessToken(payload);
    const refreshToken = signRefreshToken(payload);

    const refreshTokenHash = await bcrypt.hash(refreshToken, 10);
    await prisma.user.update({
      where: { id: user.id },
      data: { refreshTokenHash },
    });

    return { accessToken, refreshToken };
  }
}

