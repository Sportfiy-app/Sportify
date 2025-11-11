"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const auth_1 = require("../../middleware/auth");
const notifications_service_1 = require("./notifications.service");
const router = (0, express_1.Router)();
const notificationsService = new notifications_service_1.NotificationsService();
router.get('/', (0, auth_1.authenticate)(), async (req, res, next) => {
    try {
        const notifications = await notificationsService.findForUser(req.user.sub);
        res.json(notifications);
    }
    catch (error) {
        next(error);
    }
});
exports.default = router;
