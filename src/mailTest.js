import dotenv from 'dotenv';
dotenv.config( {path: '../.env'}); // ✅ This must come first

import nodemailer from 'nodemailer';

const transporter = nodemailer.createTransport({
  host: 'smtp.gmail.com',
  port: 587,
  secure: false, // TLS
  auth: {
    user: 'lancelarnoco@gmail.com',
    pass: 'qpzxrlnlhomuatjt'
  },
  tls: {
    rejectUnauthorized: false
  }
});


const mailOptions = {
  from: `"Braddex Test" <${process.env.EMAIL_USER}>`,
  to: 'kirayoshikagebtd@gmail.com',
  subject: 'Test Email',
  html: `<p>This is a test email from Braddex.</p>`
};

console.log('USER:', process.env.EMAIL_USER);
console.log('PASS:', process.env.EMAIL_PASS);

transporter.sendMail(mailOptions, (err, info) => {
  if (err) {
    console.error('❌ Email error:', err);
  } else {
    console.log('✅ Email sent:', info.response);
  }
});
