import express from 'express';
import db from '../db.js';
import { verifyToken } from '../middleware/authMiddleware.js';
import { nanoid } from 'nanoid';

const router = express.Router();

router.get('/progress', verifyToken, (req, res) => {
  const userId = req.user.id;

// const getRewardsProgress = `
//   SELECT
//     r.id AS reward_id,
//     r.name AS reward_name,
//     r.required_points,
//     u.points AS user_points,
//     rc.code,
//     rc.created_at AS claimed_at,
//     rc.redeemed
//   FROM rewards r
//   LEFT JOIN users u ON u.id = ?
//   LEFT JOIN reward_claims rc ON rc.customer_id = ? AND rc.reward_id = r.id
//   GROUP BY r.id
// `;

const getRewardsProgress = `
  SELECT
    r.id AS reward_id,
    r.name AS reward_name,
    r.required_points,
    u.points AS user_points,
    rc.code,
    rc.created_at AS claimed_at,
    rc.redeemed
  FROM rewards r
  LEFT JOIN users u ON u.id = ?
  LEFT JOIN reward_claims rc ON rc.id = (
    SELECT rc2.id
    FROM reward_claims rc2
    WHERE rc2.customer_id = ? AND rc2.reward_id = r.id
    ORDER BY rc2.created_at DESC
    LIMIT 1
  )
  WHERE r.is_deleted = 0
`;

db.query(getRewardsProgress, [userId, userId], (err, results) => {
  if (err) return res.status(500).json({ message: 'Failed to fetch progress' });

  const formatted = results.map(row => {
    const now = new Date();
    const claimedAt = row.claimed_at ? new Date(row.claimed_at) : null;
    const expired = claimedAt && ((now - claimedAt) / 1000 > 86400); // 24 hours
    // const expired = claimedAt && ((now - claimedAt) / 1000 > 120); // 60 seconds = 2 minute
    const claimedRecently = claimedAt && !expired && !row.redeemed;

    return {
      reward_id: row.reward_id,
      reward_name: row.reward_name,
      required_points: row.required_points,
      progress: row.user_points || 0,
      code: !expired && !row.redeemed ? row.code : null,
      redeemed: !!row.redeemed,
      claimed_recently: claimedRecently,
      can_claim: (row.user_points >= row.required_points) && (!claimedRecently),
    };
  });

  res.json(formatted);
});

});

function isRecent(date) {
  const claimedDate = new Date(date);
  const now = new Date();
  const diff = now - claimedDate;
  return diff <= 24 * 60 * 60 * 1000; // within 24 hours
}



router.post('/claim/:id', verifyToken, (req, res) => {
  const userId = req.user.id;
  const rewardId = req.params.id;

  const checkPoints = `
    SELECT u.points, r.required_points
    FROM users u, rewards r
    WHERE u.id = ? AND r.id = ?
  `;

  db.query(checkPoints, [userId, rewardId], (err, result) => {
    if (err) return res.status(500).json({ message: 'Error checking eligibility' });
    if (result.length === 0) return res.status(404).json({ message: 'Reward not found' });

    const { points, required_points } = result[0];
    if (points < required_points) return res.status(400).json({ message: 'Not enough points' });

    // ✅ Check if this user already claimed this reward in the last 24 hours
    const checkExistingClaim = `
      SELECT * FROM reward_claims
      WHERE customer_id = ? AND reward_id = ? AND created_at >= NOW() - INTERVAL 24 HOUR
    `;

    db.query(checkExistingClaim, [userId, rewardId], (err2, existing) => {
      if (err2) return res.status(500).json({ message: 'Error checking previous claim' });

      if (existing.length > 0) {
        // Already claimed in last 24 hours — return the same code
        return res.json({ 
          message: 'Already claimed within 24 hours',
          code: existing[0].code 
        });
      }

      // ✅ Otherwise, create a new claim for this user
      const code = nanoid(10);
      const insertClaim = `
        INSERT INTO reward_claims (customer_id, reward_id, code, created_at, redeemed)
        VALUES (?, ?, ?, NOW(), 0)
      `;

      db.query(insertClaim, [userId, rewardId, code], (err3) => {
        if (err3) return res.status(500).json({ message: 'Error inserting claim' });
        res.json({ message: 'Reward claimed!', code });
      });
    });
  });
});


router.post('/redeem', verifyToken, (req, res) => {
  const { customer_id, code } = req.body;

  const query = `
    SELECT rc.id, rc.reward_id, rc.code, rc.redeemed, rc.created_at, r.required_points, u.points
    FROM reward_claims rc
    JOIN rewards r ON rc.reward_id = r.id
    JOIN users u ON rc.customer_id = u.id
    WHERE rc.code = ? AND rc.customer_id = ?
  `;

  db.query(query, [code, customer_id], (err, results) => {
    if (err) return res.status(500).json({ success: false, message: 'Error checking reward code' });
    if (results.length === 0) return res.status(400).json({ success: false, message: 'Invalid or mismatched reward code' });

    const reward = results[0];

    // Check if already redeemed
    if (reward.redeemed) {
      return res.status(400).json({ success: false, message: 'Code already redeemed' });
    }

    // Check if expired (more than 24 hours old)
    const claimedAt = new Date(reward.created_at);
    const now = new Date();
    const diffMs = now - claimedAt;
    if (diffMs > 24 * 60 * 60 * 1000) {
      return res.status(400).json({ success: false, message: 'Code has expired' });
    }

    // Deduct points and mark as redeemed
    const updatePoints = `
      UPDATE users SET points = points - ? WHERE id = ?
    `;
    const markRedeemed = `
      UPDATE reward_claims SET redeemed = 1 WHERE id = ?
    `;

    db.query(updatePoints, [reward.required_points, customer_id], (err1) => {
      if (err1) return res.status(500).json({ success: false, message: 'Error deducting points' });

      db.query(markRedeemed, [reward.id], (err2) => {
        if (err2) return res.status(500).json({ success: false, message: 'Error marking as redeemed' });

        res.json({ success: true, message: 'Reward successfully redeemed!' });
      });
    });
  });
});

router.get('/history', verifyToken, (req, res) => {
  const userId = req.user.id;

const query = 
`  SELECT 
    o.id AS id,
    GROUP_CONCAT(f.name SEPARATOR ', ') AS item,
    NULL AS code,
    o.created_at AS date,
    'Order' AS type,
    NULL AS redeemed
  FROM orders o
  JOIN order_items oi ON o.id = oi.order_id
  JOIN food f ON oi.food_id = f.id
  WHERE o.customer_id = ?
  GROUP BY o.id

  UNION ALL

  SELECT 
    rc.id AS id,
    r.name AS item,
    rc.code AS code,
    rc.created_at AS date,
    'Reward' AS type,
    rc.redeemed AS redeemed
  FROM reward_claims rc
  JOIN rewards r ON rc.reward_id = r.id
  WHERE rc.customer_id = ?

  ORDER BY date DESC`
;


  db.query(query, [userId, userId], (err, results) => {
    if (err) {
      console.error('Error fetching full history:', err.sqlMessage || err.message || err);
      return res.status(500).json({ message: 'Failed to fetch full history' });
    }

    res.json(results);
  });
});

router.get('/validate/:code', (req, res) => {
  const code = req.params.code;

  // Adjust your table/column names as needed
  const query = `
    SELECT rc.id AS reward_claim_id, f.id AS food_id, f.name
    FROM reward_claims rc
    JOIN rewards r ON rc.reward_id = r.id
    JOIN food f ON r.food_id = f.id
    WHERE rc.code = ? AND rc.redeemed = 0
  `;

  db.query(query, [code], (err, results) => {
    if (err) return res.status(500).json({ message: 'DB error' });
    if (results.length === 0) return res.status(404).json({ message: 'Invalid or already claimed code' });

    const reward = results[0];
    return res.json({
      reward_id: reward.reward_id,
      food: {
        id: reward.food_id,
        name: reward.name
      }
    });
  });
});

router.get('/redemptions', verifyToken,(req, res) => {
  const query = `
SELECT 
  r.id,
  r.food_id,
  f.name AS food_name,
  r.name AS reward_name,
  r.is_deleted AS is_deleted,
  r.required_points,
  COUNT(rc.id) AS times_redeemed
  FROM rewards r
  LEFT JOIN food f ON r.food_id = f.id
  LEFT JOIN reward_claims rc ON rc.reward_id = r.id AND rc.redeemed = 1
  GROUP BY r.id, r.food_id, f.name, r.name, r.required_points
  ORDER BY times_redeemed DESC;
  `;
    db.query(query, (err, results) => {
    if (err) return res.status(500).json({ message: 'DB error' });
    if (results.length === 0) return res.status(404).json({ message: 'Invalid or already claimed code' });

    return res.json(results);
  });
});

router.put('/update/:id', verifyToken,(req, res) => {
  const {food_id, reward_name, required_points } = req.body
  const reward_id = req.params.id;

  try {
    let updateQuery = 'UPDATE rewards SET food_id = ?, name = ?, required_points = ?'

    // After successful reward creation
    const notificationQuery = `
    INSERT INTO notifications (user_id, message)
    VALUES (NULL, ?)
    `;
    const message = `A reward "${reward_name}" has been updated!`;

    const values = [food_id, reward_name, required_points];

    updateQuery += ' WHERE id = ?'
    values.push(reward_id)

    db.query(updateQuery, values, (err, result) => {
      if (err) {
        console.error(err.message);
        return res.sendStatus(500);
      }

      db.query(notificationQuery, [message]);

      res.json({ food_id, reward_name, required_points });
    })
  } catch (err) {
    console.error('Password hash error:', err);
    res.sendStatus(500);
  }
});


router.put('/delete/:id', verifyToken, (req, res) => {
  const rewardId = req.params.id;
  const reward_name = req.body.reward_name;

  const softDeleteQuery = 'UPDATE rewards SET is_deleted = 1 WHERE id = ?';

  const notificationQuery = `
    INSERT INTO notifications (user_id, message)
    VALUES (NULL, ?)
  `;

  const message = `A reward "${reward_name}" has been deleted!`;

  db.query(softDeleteQuery, [rewardId], (err, result) => {
    if (err) {
      console.error(err.message);
      return res.sendStatus(500);
    }

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'User not found or already deleted' });
    }

    db.query(notificationQuery, [message]);

    res.json({ message: 'User soft deleted successfully' });
  });
});

router.post('/create', verifyToken, (req, res) => {
  const { food_id, reward_name, required_points } = req.body;

  const insertQuery = `
    INSERT INTO rewards (food_id, name, required_points)
    VALUES (?, ?, ?)
  `;

  // After successful reward creation
  const notificationQuery = `
  INSERT INTO notifications (user_id, message)
  VALUES (NULL, ?)
  `;
  const message = `A new reward "${reward_name}" has been added!`;

  db.query(insertQuery, [food_id, reward_name, required_points], (err, result) => {
    if (err) return res.status(500).json({ message: 'Insert failed', error: err.message });
    res.status(201).json({ message: 'Reward added', id: result.insertId });

    db.query(notificationQuery, [message]);
    });
});

router.get('/notifications', verifyToken, (req, res) => {
  const query = `
    SELECT id, message, created_at, is_read
    FROM notifications
    WHERE (user_id IS NULL OR user_id = ?)
      AND created_at >= (
        SELECT created_at FROM users WHERE id = ?
      )
    ORDER BY created_at DESC
    LIMIT 50
  `;
  db.query(query, [req.user.id, req.user.id], (err, results) => {
    if (err) return res.status(500).json({ message: 'DB error' });
    res.json(results);
  });
});




export default router;
