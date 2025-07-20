import express from 'express';
import cors from 'cors';
import path, { dirname } from 'path';
import { fileURLToPath } from 'url';
import { verifyToken } from '../middleware/authMiddleware.js';
import db from '../db.js';


const router = express.Router();
router.use(cors());

// Get __dirname
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Serve dashboard.html only if token is valid
router.get('/home', (req, res) => {
    res.sendFile(path.join(__dirname, '..', '../public', 'includes/admindash.html'));
})

router.get('/users', (req, res) => {
    res.sendFile(path.join(__dirname, '..', '../public', 'includes/profmgt.html'));
})

router.get('/feedbacks', (req, res) => {
    res.sendFile(path.join(__dirname, '..', '../public', 'includes/reports.html'));
})

router.get('/rewards', (req, res) => {
    res.sendFile(path.join(__dirname, '..', '../public', 'includes/incents.html'));
})

router.get('/', verifyToken, (req, res) => {

    const getUsersQuery = 'SELECT * FROM users WHERE role = "admin" AND is_deleted = 0';
    db.query(getUsersQuery, (err, results) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(500);
        }

        res.json(results);
    });
});

router.get('/:limit', verifyToken, (req, res) => {
    const limit = req.params.limit ? parseInt(req.params.limit) : null;

    if (isNaN(limit)) {
        return res.status(400).json({ error: 'Invalid limit parameter' });
    }

const getUsersQuery = limit ? 
  'SELECT * FROM users WHERE role = "admin" AND is_deleted = 0 ORDER BY id LIMIT ?' :
  'SELECT * FROM users WHERE role = "admin" ORDER BY id';

    db.query(getUsersQuery, limit ? [limit] : [], (err, results) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(500);
        }

        res.json(results);
    });
});
export default router;