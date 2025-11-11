import { prisma } from '../../db/prisma';

interface CreatePaymentParams {
  bookingId: string;
  userId: string;
  stripeIntentId: string;
  amount: number;
  currency?: string;
}

export class PaymentsService {
  create(params: CreatePaymentParams) {
    return prisma.payment.create({
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

