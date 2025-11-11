"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ReviewsService = void 0;
const prisma_1 = require("../../db/prisma");
class ReviewsService {
    create(params) {
        return prisma_1.prisma.review.create({
            data: params,
        });
    }
    findForClub(clubId) {
        return prisma_1.prisma.review.findMany({
            where: { clubId },
            orderBy: { createdAt: 'desc' },
            include: { user: { select: { id: true, firstName: true, lastName: true } } },
        });
    }
}
exports.ReviewsService = ReviewsService;
