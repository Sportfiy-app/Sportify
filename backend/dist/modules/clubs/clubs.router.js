"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const clubs_service_1 = require("./clubs.service");
const router = (0, express_1.Router)();
const clubsService = new clubs_service_1.ClubsService();
router.get('/', async (_req, res, next) => {
    try {
        const clubs = await clubsService.findAll();
        res.json(clubs);
    }
    catch (error) {
        next(error);
    }
});
router.get('/:id', async (req, res, next) => {
    try {
        const club = await clubsService.findById(req.params.id);
        if (!club) {
            res.status(404).json({ message: 'Club not found' });
            return;
        }
        res.json(club);
    }
    catch (error) {
        next(error);
    }
});
exports.default = router;
