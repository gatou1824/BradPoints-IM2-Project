import express from 'express';
import bcrypt, { hash } from 'bcryptjs'
import jwt from 'jsonwebtoken';
import db from '../db.js';

const router = express.Router();

function generateUserCode() {
  return 'BRDX-' + Math.random().toString(36).substring(2, 10).toUpperCase();
}

router.post('/register', (req, res) => {
    const { username, email, password, points = 0} = req.body;
    const hashedPassword = bcrypt.hashSync(password, 8);
    const user_code = generateUserCode()

    const insertUserQuery = 'INSERT INTO users (user_code, username, email, password, points) VALUES (?, ?, ?, ?, ?)';
    db.query(insertUserQuery, [user_code, username, email, hashedPassword, points], (err, result) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(503);
        }

        const userId = result.insertId;

        // Send token right after successful registration
        const token = jwt.sign({ id: userId}, process.env.JWT_SECRET, { expiresIn: '24h' });
        res.json({ token });
    }); 
});

router.post('/login', (req, res) => {
    const { email, password } = req.body;

    const getUserQuery = 'SELECT * FROM users WHERE email = ?';
    db.query(getUserQuery, [email], (err, results) => {
        if (err) {
            console.error(err.message);
            return res.sendStatus(500);
        }

        if (results.length === 0) {
            return res.status(404).send({ message: 'User not found' });
        }

        const user = results[0];
        const passwordIsValid = bcrypt.compareSync(password, user.password);

        if (!passwordIsValid) {
            return res.status(401).send({ message: 'Invalid Password' });
        }

        const token = jwt.sign({ id: user.id, role: user.role }, process.env.JWT_SECRET, { expiresIn: '24h' });
        res.send({
            token,
            user: {
                id: user.id,
                username: user.username,
                email: user.email,
                role: user.role,
                points: user.points,
                user_code: user.user_code
            }
        });

    });
});

export default router;