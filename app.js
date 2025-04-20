const express = require('express');
const session = require('express-session');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const path = require('path');
const fs = require('fs');
const mime = require('mime-types');
const {handleSQLInjection } = require('./sqlinj')
const { login, verifyJWT , getProfile , getMaps} = require('./auth');
const { updateProfile , getComments, addComment, searchOceans} = require('./auth');
  // Importing the login and JWT verify functions
const serveIndex = require('serve-index');
const app = express();
const PORT = 3000;

// Set up EJS as the view engine
app.set('view engine', 'ejs');
app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use('/test', express.static('test'), serveIndex('test', { icons: true }));
app.use(express.urlencoded({ extended: true }));

// Set up session handling
app.use(session({
  secret: 'vulnsecret',
  resave: false,
  saveUninitialized: true
}));

app.use((req, res, next) => {
  res.setHeader('Server', 'nodejs');
  next();
});

app.use((req, res, next) => {
  res.setHeader('Cache-Control', 'no-store, no-cache, must-revalidate, proxy-revalidate');
  res.setHeader('Pragma', 'no-cache'); // For HTTP/1.0 compatibility
  res.setHeader('Expires', '0'); // Ensure the resource expires immediately
  next();
});

// Routes for the app
// Login page (GET route)
app.get('/', (req, res) => {
  res.render('login', { msg: null });
});

// Login submission (POST route)
app.post('/api/login', login);

// Home page (protected)
app.get('/home', (req, res) => {
  res.render('home');
});

// Add a new API to get user info using JWT
app.get('/api/userinfo', verifyJWT, (req, res) => {
  res.json({ username: req.user.username });
});

// Serve secure.ejs (which will fetch /api/userinfo using JWT)
app.get('/secure', (req, res) => {
  res.render('secure'); // Don't verify here, let client-side fetch do it
});
// Profile page (protected)
// Profile page (protected)
app.get('/profile', (req, res) => {
  res.render('profile');  // Render the profile page when accessed
});

// Fetch profile data using JWT
// Fetch profile data using JWT
app.get('/api/profile', verifyJWT, getProfile);

app.get('/edit-profile', (req, res) => {
  res.render('edit-profile');
});

app.post('/api/profile/update', verifyJWT, updateProfile);

// Comments page (protected)
app.get('/comments', (req, res) => {
  res.render('comments');  // Render the comments page
});

app.get('/map-wins', getMaps);
// Fetch comments (API)
app.get('/api/comments', verifyJWT, getComments); // Protect the comments API with JWT verification
// Add Comment route (protected, vulnerable to stored XSS)
app.post('/api/comments/add', verifyJWT, addComment); 
app.get('/api/search', searchOceans);
// Map page (public)
app.get('/maps', (req, res) => {
  res.render('map');
});

// Vulnerable route: Allows access to arbitrary files
// Vulnerable route: Allows access to arbitrary files (LFI or Image Rendering)
app.get('/file-disclosure', (req, res) => {
  const filePath = req.query.file;
  const absolutePath = path.resolve(__dirname, filePath); // Resolves to absolute path

  // Check if the file exists
  fs.exists(absolutePath, (exists) => {
    if (!exists) {
      return res.status(404).send('File not found!');
    }

    // Get the MIME type of the file
    const mimeType = mime.lookup(absolutePath); // Get the mime type using mime-types module

    // Read the file
    fs.readFile(absolutePath, (err, data) => {
      if (err) {
        return res.status(500).send('Error reading the file');
      }

      if (mimeType && mimeType.startsWith('image/')) {
        // Serve image
        res.setHeader('Content-Type', mimeType);
        res.send(data); // Serve the image directly
      } else if (mimeType === 'text/html' || mimeType === 'application/javascript') {
        // Serve HTML or JS (for inclusion in HTML files, LFI use case)
        res.setHeader('Content-Type', mimeType);
        res.send(data); // Serve the file content (HTML/JS)
      } else if (mimeType === 'text/plain') {
        // Serve text files
        res.setHeader('Content-Type', mimeType);
        res.send(`<pre>${data}</pre>`); // Display text files inside <pre> tags
      } else {
        // For other file types (unknown, binary), send as generic stream
        res.setHeader('Content-Type', 'application/octet-stream');
        res.send(data);
      }
    });
  });
});

app.get('/env/.env', (req, res) => {
  const fs = require('fs');
  fs.readFile('.env', 'utf8', (err, data) => {
    if (err) {
      return res.status(500).send('Error loading environment variables.');
    }
    res.set('Content-Type', 'text/plain');
    res.send(data); // ⚠️ Exposes sensitive data like SECRET, DB_PASS, etc.
  });
});

app.get('/robots.txt', (req, res) => {
  res.type('text/plain');
  res.sendFile(__dirname + '/robots.txt');
});

app.get('/sqli', (req, res) => {
  res.render('sqli'); // Make sure the EJS page exists
});

app.get('/sqli/search', (req, res) => {
  const term = req.query.q; // The vulnerable input parameter

  // Use the function from sqlinj.js to handle the SQL injection
  handleSQLInjection(term, res);
});


// Logout (clears session)
function logout() {
  localStorage.removeItem("jwt");
  window.location.href = "/";
}


// Start server
app.listen(PORT, () => {
  console.log(`🚀 App running at http://localhost:${PORT}`);
});
