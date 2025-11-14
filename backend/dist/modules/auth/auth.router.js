"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const auth_1 = require("../../middleware/auth");
const validate_1 = require("../../middleware/validate");
const auth_schema_1 = require("./auth.schema");
const verification_schema_1 = require("./verification.schema");
const auth_service_1 = require("./auth.service");
const verification_service_1 = require("./verification.service");
const router = (0, express_1.Router)();
const authService = new auth_service_1.AuthService();
const verificationService = new verification_service_1.VerificationService();
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
// SMS Verification routes
router.post('/verification/sms/send', (0, auth_1.authenticate)(), (0, validate_1.validateBody)(verification_schema_1.sendSmsCodeSchema), async (req, res, next) => {
    try {
        const result = await verificationService.sendSmsCode(req.body.phone, req.user.sub);
        res.json(result);
    }
    catch (error) {
        next(error);
    }
});
router.post('/verification/sms/verify', (0, auth_1.authenticate)(), (0, validate_1.validateBody)(verification_schema_1.verifySmsCodeSchema), async (req, res, next) => {
    try {
        const result = await verificationService.verifySmsCode(req.body.phone, req.body.code, req.user.sub);
        res.json(result);
    }
    catch (error) {
        next(error);
    }
});
// Email Verification routes
router.post('/verification/email/send', (0, auth_1.authenticate)(), (0, validate_1.validateBody)(verification_schema_1.sendEmailVerificationSchema), async (req, res, next) => {
    try {
        const result = await verificationService.sendEmailVerification(req.body.email, req.user.sub);
        res.json(result);
    }
    catch (error) {
        next(error);
    }
});
router.post('/verification/email/verify', (0, validate_1.validateBody)(verification_schema_1.verifyEmailSchema), async (req, res, next) => {
    try {
        const result = await verificationService.verifyEmail(req.body.token);
        res.json(result);
    }
    catch (error) {
        next(error);
    }
});
exports.default = router;
