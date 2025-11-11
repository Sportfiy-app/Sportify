"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const zod_1 = require("zod");
const auth_1 = require("../../middleware/auth");
const validate_1 = require("../../middleware/validate");
const payments_service_1 = require("./payments.service");
const router = (0, express_1.Router)();
const paymentsService = new payments_service_1.PaymentsService();
const createPaymentSchema = zod_1.z.object({
    bookingId: zod_1.z.string().cuid(),
    stripeIntentId: zod_1.z.string().min(3),
    amount: zod_1.z.number().int().positive(),
    currency: zod_1.z.string().length(3).optional(),
});
router.post('/', (0, auth_1.authenticate)(), (0, validate_1.validateBody)(createPaymentSchema), async (req, res, next) => {
    try {
        const payment = await paymentsService.create({
            ...req.body,
            userId: req.user.sub,
        });
        res.status(201).json(payment);
    }
    catch (error) {
        next(error);
    }
});
exports.default = router;
