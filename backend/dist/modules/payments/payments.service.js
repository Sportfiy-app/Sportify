"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PaymentsService = void 0;
const prisma_1 = require("../../db/prisma");
class PaymentsService {
    create(params) {
        return prisma_1.prisma.payment.create({
            data: {
                bookingId: params.bookingId,
                userId: params.userId,
                stripeIntentId: params.stripeIntentId,
                amount: params.amount,
                currency: params.currency ?? 'eur',
            },
        });
    }
}
exports.PaymentsService = PaymentsService;
