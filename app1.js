const express = require('express');
const session = require('express-session');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const jwt = require('jsonwebtoken');
const db = require('./config/db');
const fs = require('fs');
const path = require('path');
const app = express();
const serveIndex = require('serve-index');

const SECRET = 'pirateSecret';
const PORT = 3000;

app.set('view engine', 'ejs');
app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());

app.use('/test', express.static('test'), serveIndex('test', { icons: true }));

// Insecure session (unused now that we use JWT)
app.use(session({
  secret: SECRET,
  resave: false,
  saveUninitialized: true
}));

app.use((req, res, next) => {
  res.setHeader('X-Powered-By', 'Express');
  next();
});

app.get('/', (req, res) => {
  res.redirect('/home');
});

// Home page with search functionality
app.get('/home', (req, res) => {
  const searchTerm = req.query.q || '';
  const orderBy = req.query.order || 'id';

  if (searchTerm.includes("'") || searchTerm.toLowerCase().includes('select')) {
    return res.send(`SELECT * FROM treasure WHERE name LIKE '%${searchTerm}%' ORDER BY ${orderBy}`);
  }

  const query = `SELECT * FROM treasure WHERE name LIKE '%${searchTerm}%' ORDER BY ${orderBy}`;
  db.query(query, (err, results) => {
    if (err) return res.render('home', { results: [], searchTerm, error: 'Error occurred' });
    res.render('home', { results, searchTerm });
  });
});

app.get('/login', (req, res) => {
  res.render('login', { msg: null });
});

// SQLi in password field
app.post('/login', (req, res) => {
  const { username, password } = req.body;
  const query = `SELECT * FROM users WHERE username = '${username}' AND password = '${password}'`;
  db.query(query, (err, results) => {
    if (err) return res.send('SQL Error: ' + err.sqlMessage);
    if (results.length > 0) {
      let token = jwt.sign({ username, password, loggedIn: false }, SECRET);
      res.cookie('auth', token);
      res.redirect('/bypass');
    } else {
      res.render('login', { msg: 'Invalid credentials' });
    }
  });
});

// JWT Auth Bypass
app.get('/bypass', (req, res) => {
  let token = req.cookies.auth;
  if (!token) return res.redirect('/login');

  try {
    const data = jwt.verify(token, SECRET);
    if (data.loggedIn === true) {
      return res.redirect(`/profile?user=${data.username}`);
    } else {
      res.send('JWT exists but not logged in. Try editing the token.');
    }
  } catch (e) {
    res.redirect('/login');
  }
});

// IDOR in profile view
app.get('/profile', (req, res) => {
  const user = req.query.user;
  const query = `SELECT * FROM users WHERE username = '${user}'`;
  db.query(query, (err, results) => {
    if (err || results.length === 0) return res.send('User not found');
    res.render('profile', { user: results[0] });
  });
});

// Access Control Issue in update
app.post('/update-profile', (req, res) => {
  const { username, phone, email, ssn } = req.body;
  const query = `UPDATE users SET phone='${phone}', email='${email}', ssn='${ssn}' WHERE username='${username}'`;
  db.query(query, (err) => {
    if (err) return res.send('Error updating profile');
    res.redirect(`/profile?user=${username}`);
  });
});

// Stored XSS
app.get('/comment', (req, res) => {
  res.render('comment');
});

app.post('/comment', (req, res) => {
  const { comment } = req.body;
  const query = `INSERT INTO comments (content) VALUES ('${comment}')`;
  db.query(query, () => {
    res.redirect('/comments');
  });
});

app.get('/comments', (req, res) => {
  db.query('SELECT * FROM comments', (err, results) => {
    res.render('comments', { comments: results });
  });
});

// IDOR on /user/:id
app.get('/user/:id', (req, res) => {
  const userId = req.params.id;
  const query = `SELECT * FROM users WHERE id = ${userId}`;
  db.query(query, (err, results) => {
    res.json(results);
  });
});

// For reflected XSS test
app.get('/check-user', (req, res) => {
  const username = req.query.username;
  const query = `SELECT * FROM users WHERE username = '${username}' AND password = 'password'`;
  db.query(query, (err, results) => {
    if (results?.length) res.send('User exists');
    else res.send('Invalid user');
  });
});

// Help file render
app.get('/help', (req, res) => {
  const page = req.query.page || 'about';
  const filePath = path.join(__dirname, 'helpfiles', page + '.txt');
  fs.readFile(filePath, 'utf8', (err, data) => {
    if (err) return res.render('help', { content: 'Error loading file!', filePath });
    res.render('help', { content: data, filePath });
  });
});

// Blind SQLi Challenge (search)
app.get('/blind', (req, res) => {
  const q = req.query.q || '';
  const query = `SELECT * FROM treasure WHERE name LIKE '%${q}%'`;
  if (q.includes("updatexml")) {
    db.query(query, (err, results) => {
      if (err) return res.send(err.sqlMessage);
      res.send('Try a better payload.');
    });
  } else {
    res.send('Only updatexml-based payloads work here.');
  }
});

// Hidden URL in footer
app.get('/hidden', (req, res) => {
  res.send(`<footer style="background-color: #111; color: #111">http://localhost:3000/super-secret</footer>`);
});

app.listen(PORT, () => {
  console.log(`\u{1F680} Vuln Pirates app running at http://localhost:${PORT}`);
});