"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const zod_1 = require("zod");
const auth_1 = require("../../middleware/auth");
const validate_1 = require("../../middleware/validate");
const reviews_service_1 = require("./reviews.service");
const router = (0, express_1.Router)();
const reviewsService = new reviews_service_1.ReviewsService();
const createReviewSchema = zod_1.z.object({
    clubId: zod_1.z.string().cuid(),
    rating: zod_1.z.number().int().min(1).max(5),
    comment: zod_1.z.string().max(500).optional(),
});
router.post('/', (0, auth_1.authenticate)(), (0, validate_1.validateBody)(createReviewSchema), async (req, res, next) => {
    try {
        const review = await reviewsService.create({
            userId: req.user.sub,
            ...req.body,
        });
        res.status(201).json(review);
    }
    catch (error) {
        next(error);
    }
});
router.get('/club/:id', async (req, res, next) => {
    try {
        const reviews = await reviewsService.findForClub(req.params.id);
        res.json(reviews);
    }
    catch (error) {
        next(error);
    }
});
exports.default = router;
