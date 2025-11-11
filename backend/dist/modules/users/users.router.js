"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const zod_1 = require("zod");
const auth_1 = require("../../middleware/auth");
const validate_1 = require("../../middleware/validate");
const users_service_1 = require("./users.service");
const router = (0, express_1.Router)();
const usersService = new users_service_1.UsersService();
const updateProfileSchema = zod_1.z.object({
    firstName: zod_1.z.string().max(100).optional(),
    lastName: zod_1.z.string().max(100).optional(),
    phone: zod_1.z.string().regex(/^\+?[0-9\s\-]{7,}$/).optional(),
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
router.put('/profile', (0, auth_1.authenticate)(), (0, validate_1.validateBody)(updateProfileSchema), async (req, res, next) => {
    try {
        const updated = await usersService.updateProfile(req.user.sub, req.body);
        res.json(updated);
    }
    catch (error) {
        next(error);
    }
});
exports.default = router;
