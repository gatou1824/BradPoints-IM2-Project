import express from 'express';
import db from '../db.js';
import { verifyToken } from '../middleware/authMiddleware.js';
import { nanoid } from 'nanoid';

const router = express.Router();

router.get('/progress', verifyToken, (req, res) => {
  const userId = req.user.id;
const getProgress = `
  SELECT r.id, r.name, r.required_points, f.name AS food_name, u.points,
         EXISTS (
           SELECT 1 FROM reward_claims rc
           WHERE rc.customer_id = u.id
           AND rc.reward_id = r.id
           AND rc.created_at >= NOW() - INTERVAL 24 HOUR
         ) AS claimed_recently
  FROM rewards r
  JOIN food f ON r.food_id = f.id
  JOIN users u ON u.id = ?
`;


  db.query(getProgress, [userId], (err, results) => {
    if (err) return res.status(500).json({ message: 'Failed to fetch progress' });

    const formatted = results.map(row => ({
        reward_id: row.id,
        reward_name: row.name,
        food_name: row.food_name,
        required_points: row.required_points,
        current_points: row.points,
        progress: `${row.points}/${row.required_points}`,
        can_claim: row.points >= row.required_points && !row.claimed_recently,
        claimed_recently: !!row.claimed_recently
    }));


    res.json(formatted);
  });
});


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

    // Check if already claimed in the past 24 hours
    const checkExistingClaim = `
      SELECT * FROM reward_claims
      WHERE customer_id = ? AND reward_id = ? AND created_at >= NOW() - INTERVAL 24 HOUR
    `;

    db.query(checkExistingClaim, [userId, rewardId], (err2, existing) => {
      if (err2) return res.status(500).json({ message: 'Error checking previous claim' });
      if (existing.length > 0) return res.status(400).json({ message: 'Already claimed in the last 24 hours' });

      const code = nanoid(10);
      const insertClaim = `
        INSERT INTO reward_claims (customer_id, reward_id, code)
        VALUES (?, ?, ?)
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


export default router;
