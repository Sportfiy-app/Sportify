"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ClubsService = void 0;
const prisma_1 = require("../../db/prisma");
class ClubsService {
    findAll() {
        return prisma_1.prisma.club.findMany({
            include: {
                reviews: {
                    take: 5,
                    orderBy: { createdAt: 'desc' },
                },
            },
        });
    }
    findById(id) {
        return prisma_1.prisma.club.findUnique({
            where: { id },
            include: {
                reviews: {
                    orderBy: { createdAt: 'desc' },
                    include: { user: { select: { id: true, firstName: true, lastName: true } } },
                },
            },
        });
    }
}
exports.ClubsService = ClubsService;
