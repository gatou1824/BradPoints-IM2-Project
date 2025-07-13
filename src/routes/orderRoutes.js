import express from 'express';
import db from '../db.js';
import { verifyToken } from '../middleware/authMiddleware.js';

const router = express.Router();

router.post('/confirm', verifyToken, (req, res) => {
  const { customer_id, food_ids, reward_code } = req.body;
  const staff_id = req.user.id;

  const hasFoods = Array.isArray(food_ids) && food_ids.length > 0;

  // ✅ Reward-only redemption (no food items but has a valid code)
  if (!hasFoods && reward_code) {
    const rewardQuery = `
      SELECT rc.id, rc.reward_id, rc.redeemed, rc.created_at, r.required_points, r.food_id, u.points
      FROM reward_claims rc
      JOIN rewards r ON rc.reward_id = r.id
      JOIN users u ON rc.customer_id = u.id
      WHERE rc.code = ? AND rc.customer_id = ? AND rc.redeemed = 0
    `;

    db.query(rewardQuery, [reward_code, customer_id], (err2, result) => {
      if (err2) return res.status(500).json({ message: 'Error checking reward code' });
      if (result.length === 0) return res.status(400).json({ message: 'Invalid or already used reward code' });

      const reward = result[0];
      const claimedAt = new Date(reward.created_at);
      const now = new Date();
      if (now - claimedAt > 24 * 60 * 60 * 1000) {
        return res.status(400).json({ message: 'Reward code has expired' });
      }

      if (reward.points < reward.required_points) {
        return res.status(400).json({ message: 'Not enough points to redeem reward' });
      }

      // Proceed to create order with only the reward
      createOrderAndItems({
        staff_id,
        customer_id,
        food_ids: [{ id: reward.food_id, quantity: 1 }],
        reward,
        pointsChange: -reward.required_points,
        res
      });
    });

    return; // ❗Exit early, don’t proceed to food query
  }

  // ❌ No foods and no reward code — invalid
  if (!hasFoods) {
    return res.status(400).json({ message: 'No food items selected and no reward code provided' });
  }

  // ✅ If we reach here, it's a normal or food + reward order
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

    if (reward_code) {
      // Check and apply reward if present
      const rewardQuery = `
        SELECT rc.id, rc.reward_id, rc.redeemed, rc.created_at, r.required_points, r.food_id, u.points
        FROM reward_claims rc
        JOIN rewards r ON rc.reward_id = r.id
        JOIN users u ON rc.customer_id = u.id
        WHERE rc.code = ? AND rc.customer_id = ? AND rc.redeemed = 0
      `;

      db.query(rewardQuery, [reward_code, customer_id], (err2, result) => {
        if (err2) return res.status(500).json({ message: 'Error checking reward code' });
        if (result.length === 0) return res.status(400).json({ message: 'Invalid or already used reward code' });

        const reward = result[0];
        const claimedAt = new Date(reward.created_at);
        const now = new Date();
        if (now - claimedAt > 24 * 60 * 60 * 1000) {
          return res.status(400).json({ message: 'Reward code has expired' });
        }

        if (reward.points < reward.required_points) {
          return res.status(400).json({ message: 'Not enough points to redeem reward' });
        }

        createOrderAndItems({
          staff_id,
          customer_id,
          food_ids,
          reward,
          pointsChange: totalPoints - reward.required_points,
          res
        });
      });
    } else {
      // No reward, just create normal order
      createOrderAndItems({
        staff_id,
        customer_id,
        food_ids,
        reward: null,
        pointsChange: totalPoints,
        res
      });
    }
  });
});



// ✅ Helper function to create order only if validation passed
function createOrderAndItems({ staff_id, customer_id, food_ids, pointsChange, reward, res }) {
  const createOrder = 'INSERT INTO orders (staff_id, customer_id) VALUES (?, ?)';
  db.query(createOrder, [staff_id, customer_id], (err, result) => {
    if (err) return res.status(500).json({ message: 'Error creating order' });

    const orderId = result.insertId;
    const values = food_ids.map(item => [orderId, item.id, item.quantity]);
    const insertItems = 'INSERT INTO order_items (order_id, food_id, quantity) VALUES ?';

    db.query(insertItems, [values], (err) => {
      if (err) return res.status(500).json({ message: 'Failed to add items' });

      // Add reward item if applicable
      const addRewardItem = reward
        ? new Promise((resolve, reject) => {
            const rewardInsert = `
              INSERT INTO order_items (order_id, food_id, quantity) VALUES (?, ?, 1)
            `;
            db.query(rewardInsert, [orderId, reward.food_id], (err2) => {
              if (err2) return reject('Failed to add reward item');
              resolve();
            });
          })
        : Promise.resolve();

      addRewardItem
        .then(() => {
          const updateUser = `
            UPDATE users SET points = points + ?, visit_count = visit_count + 1 WHERE id = ?
          `;
          db.query(updateUser, [pointsChange, customer_id], (err3) => {
            if (err3) return res.status(500).json({ message: 'Failed to update user' });

            if (reward) {
              const markUsed = 'UPDATE reward_claims SET redeemed = 1 WHERE id = ?';
              db.query(markUsed, [reward.id], (err4) => {
                if (err4) return res.status(500).json({ message: 'Failed to mark reward as used' });

                res.json({ message: 'Order placed with reward!', order_id: orderId });
              });
            } else {
              res.json({ message: 'Order placed successfully!', order_id: orderId });
            }
          });
        })
        .catch((e) => {
          return res.status(500).json({ message: e });
        });
    });
  });
}


router.post('/redeem', verifyToken, (req, res) => {
  const { customer_id, code } = req.body;
  const staff_id = req.user.id;

  const query = `
    SELECT rc.id, rc.reward_id, rc.used, r.food_id
    FROM reward_claims rc
    JOIN rewards r ON rc.reward_id = r.id
    WHERE rc.code = ? AND rc.customer_id = ?
  `;

  db.query(query, [code, customer_id], (err, result) => {
    if (err) return res.status(500).json({ message: 'DB error' });
    if (result.length === 0 || result[0].used)
      return res.status(400).json({ message: 'Invalid or already used code' });

    const reward = result[0];
    const orderQuery = 'INSERT INTO orders (staff_id, customer_id) VALUES (?, ?)';
    
    db.query(orderQuery, [staff_id, customer_id], (err, result2) => {
      if (err) return res.status(500).json({ message: 'Error creating order' });

      const orderId = result2.insertId;
      const itemInsert = `
        INSERT INTO order_items (order_id, food_id, quantity)
        VALUES (?, ?, 1)
      `;

      db.query(itemInsert, [orderId, reward.food_id], () => {
        const markUsed = 'UPDATE reward_claims SET used = 1 WHERE id = ?';
        db.query(markUsed, [reward.id]);
        res.json({ message: 'Redeemed successfully!', order_id: orderId });
      });
    });
  });
});

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
router.get('/recent', verifyToken, (req, res) => {
  const userId = req.user.id;

  const query = `
    SELECT o.id
    FROM orders o
    WHERE o.customer_id = ? 
      AND NOT EXISTS (
        SELECT 1 FROM feedback f WHERE f.order_id = o.id
      )
    ORDER BY o.created_at DESC
    LIMIT 1
  `;

  db.query(query, [userId], (err, results) => {
    if (err) return res.status(500).json({ message: 'Error checking recent orders' });

    if (results.length === 0) {
      return res.json({ pending_feedback: false });
    }

    res.json({
      pending_feedback: true,
      order_id: results[0].id
    });
  });
});

router.get('/pending-feedback', verifyToken, (req, res) => {
  const userId = req.user.id;

  const query = `
    SELECT o.id, o.created_at
    FROM orders o
    WHERE o.customer_id = ? 
      AND NOT EXISTS (
        SELECT 1 FROM feedback f WHERE f.order_id = o.id
      )
    ORDER BY o.created_at DESC
  `;

  db.query(query, [userId], (err, results) => {
    if (err) return res.status(500).json({ message: 'Database error' });
    res.json(results); // returns all orders without feedback
  });
});

// GET /orders/:id/details
router.get('/:id/details', verifyToken, (req, res) => {
  const orderId = req.params.id;
  const query = `
    SELECT f.name, oi.quantity
    FROM order_items oi
    JOIN food f ON oi.food_id = f.id
    WHERE oi.order_id = ?
  `;
  db.query(query, [orderId], (err, results) => {
    if (err) return res.status(500).json({ message: 'Error fetching order items' });
    res.json(results);
  });
});

export default router;
