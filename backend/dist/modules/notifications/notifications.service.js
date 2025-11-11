"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.NotificationsService = void 0;
const prisma_1 = require("../../db/prisma");
class NotificationsService {
    findForUser(userId) {
        return prisma_1.prisma.notification.findMany({
            where: { userId },
            orderBy: { createdAt: 'desc' },
        });
    }
}
exports.NotificationsService = NotificationsService;
