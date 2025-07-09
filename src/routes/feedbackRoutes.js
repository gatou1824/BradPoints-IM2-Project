import express from 'express';
import { verifyToken } from '../middleware/authMiddleware.js';
// import bcrypt, { hash } from 'bcryptjs'
import db from '../db.js';

const router = express.Router();

router.post('/sendFeedback', verifyToken, (req, res) => {
  const { message } = req.body;
  const user_id = req.user.id;

  if (!message || message.trim() === '') {
    return res.status(400).json({ message: 'Feedback cannot be empty' });
  }

  const query = 'INSERT INTO feedback (user_id, message) VALUES (?, ?)';
  db.query(query, [user_id, message], (err, result) => {
    if (err) return res.status(500).json({ message: 'Error saving feedback' });
    res.json({ message: 'Feedback submitted successfully' });
  });
});


export default router;
