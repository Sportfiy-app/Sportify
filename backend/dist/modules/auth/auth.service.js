"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthService = void 0;
const bcrypt_1 = __importDefault(require("bcrypt"));
const http_errors_1 = __importDefault(require("http-errors"));
const prisma_1 = require("../../db/prisma");
const jwt_1 = require("../../utils/jwt");
const auth_schema_1 = require("./auth.schema");
class AuthService {
    async register(rawData) {
        const data = auth_schema_1.registerSchema.parse(rawData);
        const existing = await prisma_1.prisma.user.findUnique({ where: { email: data.email } });
        if (existing) {
            throw (0, http_errors_1.default)(409, 'Email already registered');
        }
        const passwordHash = await bcrypt_1.default.hash(data.password, 10);
        const user = await prisma_1.prisma.user.create({
            data: {
                email: data.email,
                phone: data.phone,
                passwordHash,
                role: data.role ?? 'USER',
                firstName: data.firstName,
                lastName: data.lastName,
            },
        });
        return this.generateTokens(user);
    }
    async login(rawData) {
        const data = auth_schema_1.loginSchema.parse(rawData);
        const user = await prisma_1.prisma.user.findUnique({ where: { email: data.email } });
        if (!user) {
            throw (0, http_errors_1.default)(401, 'Invalid credentials');
        }
        const isValid = await bcrypt_1.default.compare(data.password, user.passwordHash);
        if (!isValid) {
            throw (0, http_errors_1.default)(401, 'Invalid credentials');
        }
        return this.generateTokens(user);
    }
    async refresh(refreshToken) {
        const payload = (0, jwt_1.verifyRefreshToken)(refreshToken);
        const user = await prisma_1.prisma.user.findUnique({ where: { id: payload.sub } });
        if (!user || !user.refreshTokenHash) {
            throw (0, http_errors_1.default)(401, 'Invalid refresh token');
        }
        const matches = await bcrypt_1.default.compare(refreshToken, user.refreshTokenHash);
        if (!matches) {
            throw (0, http_errors_1.default)(401, 'Invalid refresh token');
        }
        return this.generateTokens(user);
    }
    async logout(userId) {
        await prisma_1.prisma.user.update({
            where: { id: userId },
            data: { refreshTokenHash: null },
        });
        return { success: true };
    }
    async generateTokens(user) {
        const payload = { sub: user.id, email: user.email, role: user.role };
        const accessToken = (0, jwt_1.signAccessToken)(payload);
        const refreshToken = (0, jwt_1.signRefreshToken)(payload);
        const refreshTokenHash = await bcrypt_1.default.hash(refreshToken, 10);
        await prisma_1.prisma.user.update({
            where: { id: user.id },
            data: { refreshTokenHash },
        });
        return { accessToken, refreshToken };
    }
}
exports.AuthService = AuthService;
