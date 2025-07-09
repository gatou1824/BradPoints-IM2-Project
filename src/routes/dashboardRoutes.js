import express from 'express';
import cors from 'cors';
import path, { dirname } from 'path';
import { fileURLToPath } from 'url';
import { verifyToken } from '../middleware/authMiddleware.js';


const router = express.Router();
router.use(cors());

// Get __dirname
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Serve dashboard.html only if token is valid
router.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '..', '../public', 'dashboard.html'));

})

router.get('/customer', (req, res) => {
    res.sendFile(path.join(__dirname, '..', '../public', 'customerDashboard.html'));
})
export default router;