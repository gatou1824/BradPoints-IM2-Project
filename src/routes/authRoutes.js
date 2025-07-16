import express from 'express';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import db from '../db.js';
import nodemailer from 'nodemailer';
import { body, validationResult } from 'express-validator'; // ✅ Required for validation

const router = express.Router();

// ✅ Generates user code like BRDX-ABCD1234
function generateUserCode() {
  return 'BRDX-' + Math.random().toString(36).substring(2, 10).toUpperCase();
}

// ✅ Nodemailer setup
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS
  }
});

console.log('USER:', process.env.EMAIL_USER);
console.log('PASS:', process.env.EMAIL_PASS);

// ✅ REGISTER ROUTE
router.post(
  '/register',
  [
    body('username').notEmpty().withMessage('Username is required'),
    body('email').isEmail().withMessage('Invalid email'),
    body('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters')
  ],
  (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { username, email, password, points = 0 } = req.body;
    const hashedPassword = bcrypt.hashSync(password, 8);
    const user_code = generateUserCode();

    const insertUserQuery =
      'INSERT INTO users (user_code, username, email, password, points) VALUES (?, ?, ?, ?, ?)';
        db.query(insertUserQuery, [user_code, username, email, hashedPassword, points], (err, result) => {
        if (err) {
        console.error('❌ DB ERROR:', err);
        
        if (err.code === 'ER_DUP_ENTRY') {
            return res.status(409).send({ message: 'Email is already registered' });
        }

        return res.status(503).send({ message: 'Registration failed' });
        }



      const userId = result.insertId;

      // ✅ Generate email verification token
      const emailToken = jwt.sign(
        { id: userId, email },
        process.env.JWT_EMAIL_SECRET,
        { expiresIn: '1d' }
      );

      const verificationLink = `http://localhost:51540/auth/verify-email?token=${emailToken}`;

      const mailOptions = {
        from: `"Braddex" <${process.env.EMAIL_USER}>`,
        to: email,
        subject: 'Verify your email - Braddex',
        html: `<h3>Hello ${username},</h3><p>Click the link below to verify your email:</p><a href="${verificationLink}">${verificationLink}</a>`
      };

      transporter.sendMail(mailOptions, (err, info) => {
        if (err) {
          console.error(err.message);
          return res.status(500).send({ message: 'Email not sent' });
        }

        console.log('Verification email sent:', info.response);
        res.status(200).send({ message: 'Registration successful, please verify your email.' });
      });
    });
  }
);

// ✅ EMAIL VERIFICATION
router.get('/verify-email', (req, res) => {
  const token = req.query.token;

  try {
    const decoded = jwt.verify(token, process.env.JWT_EMAIL_SECRET);
    const userId = decoded.id;

    const updateQuery = 'UPDATE users SET is_verified = 1 WHERE id = ?';
    db.query(updateQuery, [userId], (err) => {
      if (err) return res.status(500).send({ message: 'Database error' });

      res.send({ message: 'Email successfully verified!' });
    });
  } catch (err) {
    res.status(400).send({ message: 'Invalid or expired token' });
  }
});

// ✅ LOGIN ROUTE
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

    if (!user.is_verified) {
      return res.status(403).send({ message: 'Please verify your email before logging in.' });
    }

    const token = jwt.sign(
      { id: user.id, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: '24h' }
    );

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
