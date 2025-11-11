"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.BookingsService = void 0;
const http_errors_1 = __importDefault(require("http-errors"));
const prisma_1 = require("../../db/prisma");
class BookingsService {
    async create(params) {
        if (params.endsAt <= params.startsAt) {
            throw (0, http_errors_1.default)(400, 'Invalid booking date range');
        }
        return prisma_1.prisma.booking.create({
            data: {
                userId: params.userId,
                clubId: params.clubId,
                startsAt: params.startsAt,
                endsAt: params.endsAt,
            },
        });
    }
    async findMine(userId) {
        return prisma_1.prisma.booking.findMany({
            where: { userId },
            include: {
                club: true,
                payment: true,
            },
            orderBy: { startsAt: 'desc' },
        });
    }
}
exports.BookingsService = BookingsService;
