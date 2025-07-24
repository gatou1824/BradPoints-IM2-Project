import express from 'express';
import { verifyToken } from '../middleware/authMiddleware.js';
import bcrypt, { hash } from 'bcryptjs'
import db from '../db.js';

//admin sidee

const router = express.Router();

// Get all customers
router.get('/top', verifyToken, (req, res) => {

    const getUsersQuery = 'SELECT * FROM users WHERE is_deleted = 0 AND role = "customer" ORDER BY points DESC LIMIT 5';

    db.query(getUsersQuery, (err, results) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(500);
        }

        res.json(results);
    });
});

// Get all customers
router.get('/recent', verifyToken, (req, res) => {

    const getUsersQuery = 'SELECT username, email, created_at FROM users ORDER BY created_at DESC LIMIT 5';

    db.query(getUsersQuery, (err, results) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(500);
        }

        res.json(results);
    });
});

// Get all customers count
router.get('/count', verifyToken, (req, res) => {

    const getUsersQuery = 'SELECT COUNT(*) AS totalCustCount FROM users WHERE role = "customer" AND is_deleted = 0';

    db.query(getUsersQuery, (err, results) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(500);
        }

        res.json(results);
    });
});

// Get all customers count where user is verified
router.get('/verfied/count', verifyToken, (req, res) => {

    const getUsersQuery = 'SELECT COUNT(*) AS totalCustCount FROM users WHERE role = "customer" AND is_verified = 1';

    db.query(getUsersQuery, (err, results) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(500);
        }

        res.json(results);
    });
});

// Get all customers count where user isn't verified
router.get('/unverified/count', verifyToken, (req, res) => {

    const getUsersQuery = 'SELECT COUNT(*) AS totalCustCount FROM users WHERE role = "customer" AND is_verified = 0';

    db.query(getUsersQuery, (err, results) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(500);
        }

        res.json(results);
    });
});

// Get all customers count where user isn't verified
router.get('/deleted/count', verifyToken, (req, res) => {

    const getUsersQuery = 'SELECT COUNT(*) AS totalCustCount FROM users WHERE role = "customer" AND is_deleted = 1';

    db.query(getUsersQuery, (err, results) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(500);
        }

        res.json(results);
    });
});

// Get customer profile
router.get('/:user_code', verifyToken, (req, res) => {
  const { user_code } = req.params;

  const getUsersQuery = `SELECT * FROM users WHERE user_code = ?`;

  db.query(getUsersQuery, [user_code], (err, results) => {
    if (err) {
      console.error(err.message);
      return res.sendStatus(500);
    }

    if (results.length === 0) {
      return res.status(404).json({ message: 'User not found' });
    }

    res.json(results[0]);
  });
});

// Get all customers
router.get('/', verifyToken, (req, res) => {

    const getUsersQuery = 'SELECT username, points FROM users';

    db.query(getUsersQuery, (err, results) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(500);
        }

        res.json(results);
    });
});

router.get('/cust/:limit', verifyToken, (req, res) => {
    const limit = req.params.limit ? parseInt(req.params.limit) : null;

    if (isNaN(limit)) {
        return res.status(400).json({ error: 'Invalid limit parameter' });
    }

const getUsersQuery = limit ? 
  'SELECT * FROM users WHERE role = "customer" ORDER BY id LIMIT ?' :
  'SELECT * FROM users WHERE role = "customer" ORDER BY id';

    db.query(getUsersQuery, limit ? [limit] : [], (err, results) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(500);
        }

        res.json(results);
    });
});

router.get('/customer/allCust', verifyToken, (req, res) => {

const getUsersQuery = 'SELECT * FROM users WHERE role = "customer" AND is_deleted = 0 ORDER BY id';

    db.query(getUsersQuery, (err, results) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(500);
        }

        res.json(results);
    });
});

router.put('/update/:id', verifyToken, async (req, res) => {
  const { username, email, points, password, is_verified } = req.body;
  const userId = req.params.id;

  try {
    let updateQuery = 'UPDATE users SET username = ?, email = ?, points = ?, is_verified = ?';
    const values = [username, email, points, is_verified];

    // If a password is provided, hash it and include it in the update
    if (password && password.trim() !== '') {
      const hashedPassword = await bcrypt.hash(password, 10);
      updateQuery += ', password = ?';
      values.push(hashedPassword);
    }

    updateQuery += ' WHERE id = ?';
    values.push(userId);

    db.query(updateQuery, values, (err, result) => {
      if (err) {
        console.error(err.message);
        return res.sendStatus(500);
      }

      res.json({ username, email, points, is_verified });
    });
  } catch (err) {
    console.error('Password hash error:', err);
    res.sendStatus(500);
  }
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
