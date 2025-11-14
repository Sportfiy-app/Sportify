"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const zod_1 = require("zod");
const auth_1 = require("../../middleware/auth");
const validate_1 = require("../../middleware/validate");
const upload_schema_1 = require("./upload.schema");
const user_sports_schema_1 = require("./user-sports.schema");
const user_sports_service_1 = require("./user-sports.service");
const users_service_1 = require("./users.service");
const router = (0, express_1.Router)();
const usersService = new users_service_1.UsersService();
const userSportsService = new user_sports_service_1.UserSportsService();
const updateProfileSchema = zod_1.z.object({
    firstName: zod_1.z.string().max(100).optional(),
    lastName: zod_1.z.string().max(100).optional(),
    phone: zod_1.z.string().regex(/^\+?[0-9\s\-]{7,}$/).optional(),
    avatarUrl: zod_1.z.string().url().optional(),
    dateOfBirth: zod_1.z.string().datetime().optional(),
    gender: zod_1.z.string().max(50).optional(),
    city: zod_1.z.string().max(100).optional(),
});
router.get('/me', (0, auth_1.authenticate)(), async (req, res, next) => {
    try {
        const profile = await usersService.findById(req.user.sub);
        res.json(profile);
    }
    catch (error) {
        next(error);
    }
});
router.patch('/profile', (0, auth_1.authenticate)(), (0, validate_1.validateBody)(updateProfileSchema), async (req, res, next) => {
    try {
        const updated = await usersService.updateProfile(req.user.sub, req.body);
        res.json(updated);
    }
    catch (error) {
        next(error);
    }
});
// User Sports routes
router.get('/sports', (0, auth_1.authenticate)(), async (req, res, next) => {
    try {
        const sports = await userSportsService.getUserSports(req.user.sub);
        res.json({ sports });
    }
    catch (error) {
        next(error);
    }
});
router.post('/sports', (0, auth_1.authenticate)(), (0, validate_1.validateBody)(user_sports_schema_1.addUserSportSchema), async (req, res, next) => {
    try {
        const sport = await userSportsService.addSport(req.user.sub, req.body);
        res.status(201).json(sport);
    }
    catch (error) {
        next(error);
    }
});
router.patch('/sports/:sportId', (0, auth_1.authenticate)(), (0, validate_1.validateBody)(user_sports_schema_1.updateUserSportSchema), async (req, res, next) => {
    try {
        const sport = await userSportsService.updateSport(req.user.sub, req.params.sportId, req.body);
        res.json(sport);
    }
    catch (error) {
        next(error);
    }
});
router.delete('/sports/:sportId', (0, auth_1.authenticate)(), async (req, res, next) => {
    try {
        const result = await userSportsService.removeSport(req.user.sub, req.params.sportId);
        res.json(result);
    }
    catch (error) {
        next(error);
    }
});
// Upload avatar
router.post('/avatar', (0, auth_1.authenticate)(), (0, validate_1.validateBody)(upload_schema_1.uploadAvatarSchema), async (req, res, next) => {
    try {
        const updated = await usersService.uploadAvatar(req.user.sub, req.body.imageUrl);
        res.json(updated);
    }
    catch (error) {
        next(error);
    }
});
exports.default = router;
