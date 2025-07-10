import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import path, { dirname } from 'path'
import { fileURLToPath } from 'url'
import authRoutes from './routes/authRoutes.js'
import customerRoutes from './routes/customerRoutes.js'
import dashboardRoutes from './routes/dashboardRoutes.js'
import profileRoutes from './routes/profileRoutes.js'
import foodRoutes from './routes/foodRoutes.js'
import orderRoutes from './routes/orderRoutes.js';
import feedbackRoutes from './routes/feedbackRoutes.js'
import rewardRoutes from './routes/rewardRoutes.js'

dotenv.config();

const app = express();
const PORT = process.env.PORT; // Pick an allowed port between 51540 - 51549

app.use(cors());
app.use(express.json())

app.use('/auth', authRoutes)
app.use('/customers', customerRoutes)
app.use('/dashboard', dashboardRoutes)
app.use('/profile', profileRoutes)
app.use('/foods', foodRoutes)
app.use('/orders', orderRoutes);
app.use('/feedback', feedbackRoutes);
app.use('/rewards', rewardRoutes);


//Get the file path from the URL of the current module
const __filename = fileURLToPath(import.meta.url)
//get the directory from the file path
const __dirname = dirname(__filename)
app.use(express.static(path.join(__dirname, '../public')))

// serving up the HTML file from the public direcotory
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../public', 'index.html'))
})

app.listen(51540, '0.0.0.0', () => {
  console.log('Server running on http://10.16.207.202:51540');
});