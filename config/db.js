const mysql = require('mysql');

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root', // or your custom user
  password: '1234567890', // your MySQL password
  database: 'pirate_app'
});

db.connect((err) => {
  if (err) throw err;
  console.log('✅ MySQL Connected...');
});

module.exports = db;
