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

router.get('/available', verifyToken, (req, res) => {

    const getUsersQuery = 'SELECT * FROM food WHERE is_available = 1'; // Hide passwords

    db.query(getUsersQuery, (err, results) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(500);
        }

        res.json(results);
    });
});


router.put('/update/:id', verifyToken, (req, res) => {
  const { name, points, is_available } = req.body;
  const id = req.params.id;

  try {
    const updateQuery = 'UPDATE food SET name = ?, points = ?, is_available = ? WHERE id = ?';
    const updateValues = [name, points, is_available, id]; // ✅ include id here

    const notificationQuery = `
      INSERT INTO notifications (user_id, message)
      VALUES (NULL, ?)
    `;
    const message = `A food "${name}" has been updated!`;

    db.query(updateQuery, updateValues, (err, result) => {
      if (err) {
        console.error('Update error:', err.message);
        return res.sendStatus(500);
      }

      db.query(notificationQuery, [message], (notifErr) => {
        if (notifErr) {
          console.error('Notification error:', notifErr.message);
        }
        res.json({ name, points, is_available });
      });
    });
  } catch (err) {
    console.error('Unexpected error:', err);
    res.sendStatus(500);
  }
});

router.put('/delete/:id', verifyToken, (req, res) => {
  const rewardId = req.params.id;
  const name = req.body.name;

  const softDeleteQuery = 'UPDATE food SET is_deleted = 1 WHERE id = ?';

  const notificationQuery = `
    INSERT INTO notifications (user_id, message)
    VALUES (NULL, ?)
  `;

  const message = `"${name}" has been deleted!`;

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
    const { name, points, is_available } = req.body;

  const insertQuery = `
    INSERT INTO food (name, points, is_available)
    VALUES (?, ?, ?)
  `;

  const notificationQuery = `
    INSERT INTO notifications (user_id, message)
    VALUES (NULL, ?)
  `;

  const message = `"${name}" has been added!`;

  db.query(insertQuery, [name, points, is_available], (err, result) => {
    if (err) {
      console.error('Insert error:', err.message);
      return res.status(500).json({ message: 'Insert failed', error: err.message });
    }

    db.query(notificationQuery, [message], (notifErr) => {
      if (notifErr) {
        console.error('Notification error:', notifErr.message);
      }
    });

    res.status(201).json({ message: 'Reward added', id: result.insertId });
  });
});


export default router;
