import express from 'express';
import { verifyToken } from '../middleware/authMiddleware.js';
// import bcrypt, { hash } from 'bcryptjs'
import db from '../db.js';

//admin sidee

const router = express.Router();

// Get all customers
router.get('/', verifyToken, (req, res) => {

    const getUsersQuery = 'SELECT * FROM users'; // Hide passwords

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


//maybe able to add customer but not now

// router.post('/', verifyToken, (req, res) => {
//     const { username, password } = req.body;
//     const hashedPassword = bcrypt.hashSync(password, 8);

//     const insertUserQuery = 'INSERT INTO users (username, password) VALUES (?, ?)';
//     db.query(insertUserQuery, [username, hashedPassword], (err, result) => {
//         if (err) {
//             console.error(err.message);
//             return res.sendStatus(503);
//         }

//         res.status(201).json({ message: 'Customer created', customerId: result.insertId });
//     });
// });

export default router;
