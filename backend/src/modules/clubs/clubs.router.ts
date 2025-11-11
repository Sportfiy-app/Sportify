import { Router } from 'express';

import { ClubsService } from './clubs.service';

const router = Router();
const clubsService = new ClubsService();

router.get('/', async (_req, res, next) => {
  try {
    const clubs = await clubsService.findAll();
    res.json(clubs);
  } catch (error) {
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
  } catch (error) {
    next(error);
  }
});

export default router;

