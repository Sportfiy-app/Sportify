"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.refreshSchema = exports.loginSchema = exports.registerSchema = void 0;
const zod_1 = require("zod");
exports.registerSchema = zod_1.z.object({
    email: zod_1.z.string().email(),
    phone: zod_1.z.string().regex(/^\+?[0-9\s\-]{7,}$/).optional(),
    password: zod_1.z.string().min(8),
    role: zod_1.z.enum(['USER', 'CLUB_MANAGER', 'ADMIN']).optional(),
    firstName: zod_1.z.string().max(100).optional(),
    lastName: zod_1.z.string().max(100).optional(),
    dateOfBirth: zod_1.z.string().datetime().optional(),
    gender: zod_1.z.string().max(50).optional(),
    city: zod_1.z.string().max(100).optional(),
});
exports.loginSchema = zod_1.z.object({
    email: zod_1.z.string().email(),
    password: zod_1.z.string().min(8),
});
exports.refreshSchema = zod_1.z.object({
    refreshToken: zod_1.z.string().min(20),
});
