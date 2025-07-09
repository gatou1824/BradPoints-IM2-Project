import mysql from 'mysql2';

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'bradpoints'
});

db.connect(err => {
    if (err) return err;
    console.log('Connected to MySQL');
});



export default db;
