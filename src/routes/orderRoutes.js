import express from 'express';
import db from '../db.js';
import { verifyToken } from '../middleware/authMiddleware.js';

const router = express.Router();

router.post('/confirm', verifyToken, (req, res) => {
  const { customer_id, food_ids, redeem_points } = req.body;
  const staff_id = req.user.id;

  if (!customer_id || !Array.isArray(food_ids) || food_ids.length === 0) {
    return res.status(400).json({ message: 'Invalid order data' });
  }

  const foodIdsOnly = food_ids.map(item => item.id);
  const getFoodData = 'SELECT id, points, price FROM food WHERE id IN (?)';

  db.query(getFoodData, [foodIdsOnly], (err, foodResults) => {
    if (err) return res.status(500).json({ message: 'Failed to fetch food data' });

    let totalPoints = 0;
    let totalPrice = 0;

    foodResults.forEach(food => {
      const item = food_ids.find(f => f.id === food.id);
      if (item) {
        totalPoints += food.points * item.quantity;
        totalPrice += food.price * item.quantity;
      }
    });

    // If redeeming, check customer points first
    if (redeem_points) {
      const getUserPoints = 'SELECT points FROM users WHERE id = ?';
      db.query(getUserPoints, [customer_id], (err, result) => {
        if (err) return res.status(500).json({ message: 'Failed to fetch user points' });

        const currentPoints = result[0].points;
        if (currentPoints < totalPrice) {
          return res.status(400).json({ message: 'Insufficient points for redemption' });
        }

        // ✅ Now safe to create order
        createOrderAndItems({
          staff_id,
          customer_id,
          food_ids,
          pointsChange: -totalPrice,
          res
        });
      });

    } else {
      // Not redeeming, add points
      createOrderAndItems({
        staff_id,
        customer_id,
        food_ids,
        pointsChange: totalPoints,
        res
      });
    }
  });
});

// ✅ Helper function to create order only if validation passed
function createOrderAndItems({ staff_id, customer_id, food_ids, pointsChange, res }) {
  const createOrder = 'INSERT INTO orders (staff_id, customer_id) VALUES (?, ?)';
  db.query(createOrder, [staff_id, customer_id], (err, result) => {
    if (err) return res.status(500).json({ message: 'Error creating order' });

    const orderId = result.insertId;
    const values = food_ids.map(item => [orderId, item.id, item.quantity]);
    const insertItems = 'INSERT INTO order_items (order_id, food_id, quantity) VALUES ?';

    db.query(insertItems, [values], (err) => {
      if (err) return res.status(500).json({ message: 'Failed to add items' });

      const updateUser = `
        UPDATE users 
        SET points = points + ?, visit_count = visit_count + 1 
        WHERE id = ?
      `;
      db.query(updateUser, [pointsChange, customer_id], () => {
        res.json({ order_id: orderId });
      });
    });
  });
}



router.get('/today', verifyToken, (req, res) => {
  const query = `
    SELECT o.id, u.username AS customer_name, o.status, o.created_at
    FROM orders o
    JOIN users u ON o.customer_id = u.id
    WHERE DATE(o.created_at) = CURDATE()
    ORDER BY o.created_at DESC
  `;
  db.query(query, (err, results) => {
    if (err) return res.status(500).json({ message: 'Error fetching orders' });
    res.json(results);
  });
});

// GET /orders/recent
router.get('/orders/recent', verifyToken, (req, res) => {
  const userId = req.user.id;

  const query = `
    SELECT o.id
    FROM orders o
    WHERE o.customer_id = ? AND DATE(o.created_at) = CURDATE()
    ORDER BY o.created_at DESC
    LIMIT 1
  `;

  db.query(query, [userId], (err, results) => {
    if (err) return res.status(500).json({ message: 'Error checking recent orders' });

    if (results.length === 0) return res.json({ ordered_today: false });

    const orderId = results[0].id;

    // Now check if feedback exists for this order
    const feedbackQuery = `SELECT id FROM feedback WHERE order_id = ?`;
    db.query(feedbackQuery, [orderId], (err2, feedbackResults) => {
      if (err2) return res.status(500).json({ message: 'Error checking feedback' });

      const feedbackGiven = feedbackResults.length > 0;

      res.json({ ordered_today: true, feedback_given: feedbackGiven });
    });
  });
});



export default router;
