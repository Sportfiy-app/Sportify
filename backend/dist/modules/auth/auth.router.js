"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const auth_1 = require("../../middleware/auth");
const validate_1 = require("../../middleware/validate");
const auth_schema_1 = require("./auth.schema");
const auth_service_1 = require("./auth.service");
const router = (0, express_1.Router)();
const authService = new auth_service_1.AuthService();
router.post('/register', (0, validate_1.validateBody)(auth_schema_1.registerSchema), async (req, res, next) => {
    try {
        const tokens = await authService.register(req.body);
        res.status(201).json(tokens);
    }
    catch (error) {
        next(error);
    }
});
router.post('/login', (0, validate_1.validateBody)(auth_schema_1.loginSchema), async (req, res, next) => {
    try {
        const tokens = await authService.login(req.body);
        res.json(tokens);
    }
    catch (error) {
        next(error);
    }
});
router.post('/refresh', (0, validate_1.validateBody)(auth_schema_1.refreshSchema), async (req, res, next) => {
    try {
        const tokens = await authService.refresh(req.body.refreshToken);
        res.json(tokens);
    }
    catch (error) {
        next(error);
    }
});
router.post('/logout', (0, auth_1.authenticate)(), async (req, res, next) => {
    try {
        await authService.logout(req.user.sub);
        res.json({ success: true });
    }
    catch (error) {
        next(error);
    }
});
exports.default = router;
