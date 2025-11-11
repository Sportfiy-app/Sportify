"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const zod_1 = require("zod");
const auth_1 = require("../../middleware/auth");
const validate_1 = require("../../middleware/validate");
const bookings_service_1 = require("./bookings.service");
const router = (0, express_1.Router)();
const bookingsService = new bookings_service_1.BookingsService();
const createBookingSchema = zod_1.z.object({
    clubId: zod_1.z.string().cuid(),
    startsAt: zod_1.z.coerce.date(),
    endsAt: zod_1.z.coerce.date(),
});
router.post('/', (0, auth_1.authenticate)(), (0, validate_1.validateBody)(createBookingSchema), async (req, res, next) => {
    try {
        const booking = await bookingsService.create({
            userId: req.user.sub,
            clubId: req.body.clubId,
            startsAt: req.body.startsAt,
            endsAt: req.body.endsAt,
        });
        res.status(201).json(booking);
    }
    catch (error) {
        next(error);
    }
});
router.get('/me', (0, auth_1.authenticate)(), async (req, res, next) => {
    try {
        const bookings = await bookingsService.findMine(req.user.sub);
        res.json(bookings);
    }
    catch (error) {
        next(error);
    }
});
exports.default = router;
