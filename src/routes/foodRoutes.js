import express from 'express';
import { verifyToken } from '../middleware/authMiddleware.js';
// import bcrypt, { hash } from 'bcryptjs'
import db from '../db.js';

//admin sidee

const router = express.Router();

// Get all customers
router.get('/', verifyToken, (req, res) => {

    const getUsersQuery = 'SELECT * FROM food'; // Hide passwords

    db.query(getUsersQuery, (err, results) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(500);
        }

        res.json(results);
    });
});

export default router;
