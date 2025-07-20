import express from 'express';
import { verifyToken } from '../middleware/authMiddleware.js';
// import bcrypt, { hash } from 'bcryptjs'
import db from '../db.js';

const router = express.Router();

router.get('/', verifyToken, (req, res) => {
  const query = `
SELECT f.rating, f.message, f.created_at, u.username AS customer_name FROM feedback f JOIN users u ON f.user_id = u.id ORDER BY f.created_at DESC;
  `;

  db.query(query, (err, results) => {
    if (err) return res.status(500).json({ message: 'Error fetching feedbacks' });

    res.json({ feedbacks: results });
  });
});


router.post('/sendFeedback', verifyToken, (req, res) => {
  const { message, order_id, rating } = req.body;
  const user_id = req.user.id;

  if (!message || message.trim() === '') {
    return res.status(400).json({ message: 'Feedback cannot be empty' });
  }

  if (!order_id) {
    return res.status(400).json({ message: 'Missing order ID' });
  }

  // Step 1: Insert feedback
  const query = 'INSERT INTO feedback (user_id, order_id, message, rating) VALUES (?, ?, ?, ?)';
  db.query(query, [user_id, order_id, message, rating], (err, result) => {
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

// GET /feedback/recent/count
router.get('/recent/count', verifyToken, (req, res) => {
  const query = `SELECT COUNT(*) AS count FROM feedback WHERE created_at >= NOW() - INTERVAL 24 HOUR`;

  db.query(query, (err, result) => {
    if (err) {
      console.error('Error fetching recent feedback count:', err);
      return res.sendStatus(500);
    }

    res.json({ count: result[0].count });
  });
});

router.get('/star-distribution', verifyToken,(req, res) => {
  const query = `
    SELECT rating, COUNT(*) AS count
    FROM feedback
    WHERE rating IS NOT NULL
    GROUP BY rating
    ORDER BY rating ASC
  `;

  db.query(query, (err, results) => {
    if (err) return res.status(500).json({ message: 'Error fetching data' });

    // Initialize array of 5 zeroes (1–5 stars)
    const starCounts = [0, 0, 0, 0, 0];

    results.forEach(row => {
      const rating = row.rating; // should be 1–5
      const count = row.count;
      starCounts[rating - 1] = count; // store at index 0–4
    });

    res.json({ data: starCounts });
  });
});

router.get('/average', verifyToken, (req, res) => {
  const query = `SELECT AVG(rating) AS average_rating FROM feedback`;

  db.query(query, (err, results) => {
    if (err) return res.status(500).json({ message: 'Error fetching data' });
    const avg = parseFloat(results[0].average_rating).toFixed(2)
    res.json({ average: avg });
  });
});


export default router;
