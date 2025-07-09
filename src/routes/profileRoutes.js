import express from 'express';
import { verifyToken } from '../middleware/authMiddleware.js';
import db from '../db.js';

const router = express.Router();

router.get('/', verifyToken, (req, res) => {
    const userId = req.user.id;
    console.log(userId)
    const sql = "SELECT * FROM users WHERE id = ?";

    db.query(sql, [userId], (err, results) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(500);
        }

        if (results.length === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        res.send(results[0])

        // res.json(results[0]); // Return single user object
    });
});

export default router;
