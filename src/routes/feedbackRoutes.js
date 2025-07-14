import express from 'express';
import { verifyToken } from '../middleware/authMiddleware.js';
// import bcrypt, { hash } from 'bcryptjs'
import db from '../db.js';

const router = express.Router();
router.post('/sendFeedback', verifyToken, (req, res) => {
  const { message, order_id } = req.body;
  const user_id = req.user.id;

  if (!message || message.trim() === '') {
    return res.status(400).json({ message: 'Feedback cannot be empty' });
  }

  if (!order_id) {
    return res.status(400).json({ message: 'Missing order ID' });
  }

  // Step 1: Insert feedback
  const query = 'INSERT INTO feedback (user_id, order_id, message) VALUES (?, ?, ?)';
  db.query(query, [user_id, order_id, message], (err, result) => {
    if (err) return res.status(500).json({ message: 'Error saving feedback' });

    // ✅ Step 2: Update orders table to mark as given
    const updateQuery = `UPDATE orders SET feedback_given = TRUE WHERE id = ? AND customer_id = ?`;
    db.query(updateQuery, [order_id, user_id], (updateErr, updateResult) => {
      if (updateErr) {
        console.error('Failed to update feedback_given:', updateErr);
        return res.status(500).json({ message: 'Feedback saved but failed to update order' });
      }

      res.json({ message: 'Feedback submitted successfully' });
    });
  });
});


// POST /feedback/dismiss
router.post('/dismissFeedback/:orderId', verifyToken, (req, res) => {
  const orderId = req.params.orderId;
  const userId = req.user.id;

  const query = `UPDATE orders SET feedback_dismissed = TRUE WHERE id = ? AND customer_id = ?`;

  db.query(query, [orderId, userId], (err, result) => {
    if (err) {
      console.error('DB error:', err);
      return res.status(500).json({ message: 'Failed to dismiss feedback' });
    }

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'Order not found or not authorized' });
    }

    res.json({ message: 'Feedback dismissed successfully' });
  });
});




export default router;
