import express from 'express';
import { verifyToken } from '../middleware/authMiddleware.js';
// import bcrypt, { hash } from 'bcryptjs'
import db from '../db.js';

//admin sidee

const router = express.Router();

// Get all customers

router.get('/', verifyToken, (req, res) => {

    const getUsersQuery = 'SELECT * FROM users WHERE role = "staff" AND is_deleted = 0';
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
  'SELECT * FROM users WHERE role = "staff" AND is_deleted = 0 ORDER BY id LIMIT ?' :
  'SELECT * FROM users WHERE role = "staff" ORDER BY id';

    db.query(getUsersQuery, limit ? [limit] : [], (err, results) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(500);
        }

        res.json(results);
    });
});

router.put('/update/:id', verifyToken, (req, res) => {
  const { username, email } = req.body;
  const userId = req.params.id;

  const updateQuery = 'UPDATE users SET username = ?, email = ? WHERE id = ?';
  const values = [username, email, userId];

  db.query(updateQuery, values, (err, result) => {
    if (err) {
      console.error(err.message);
      return res.sendStatus(500);
    }

    res.json({ username, email });
  });
});

router.put('/delete/:id', verifyToken, (req, res) => {
  const userId = req.params.id;

  const softDeleteQuery = 'UPDATE users SET is_deleted = TRUE WHERE id = ?';

  db.query(softDeleteQuery, [userId], (err, result) => {
    if (err) {
      console.error(err.message);
      return res.sendStatus(500);
    }

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'User not found or already deleted' });
    }

    res.json({ message: 'User soft deleted successfully' });
  });
});


export default router;
