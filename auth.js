const jwt = require('jsonwebtoken');
const db = require('./config/db'); // Assuming your db setup is correct
const SECRET = process.env.SECRET || 'secretkey';  // Secret key for JWT

// Login handler for EJS-based routing
const login = (req, res) => {
    const { username, password } = req.body;  // Get username and password from the request body

    // Query to check user credentials (both username and password)
    const query = 'SELECT * FROM users WHERE username = ? AND password = ?';
    db.query(query, [username, password], (err, results) => {
        if (err) {
            return res.status(500).send('Error verifying credentials');
        }

        // If no user is found, send error
        if (results.length === 0) {
            return res.render('login', { msg: 'Invalid username or password' });
        }

        // Create JWT token if login is successful
        const token = jwt.sign(
            {
                userId: results[0].id,
                username: results[0].username,
                password: results[0].password, // Storing password in the JWT (not secure for real apps)
                logged_status: 'true',  // Storing logged status in JWT
            },
            SECRET,
            { expiresIn: '1h' }  // Token expires in 1 hour
        );

        // Store token in session (optional, but recommended for future validation)


        // Redirect to home page
        res.json({ token }); 
    });
};

// JWT verification middleware for protected routes
const verifyJWT = (req, res, next) => {
    let token;

    // Check for Bearer token in Authorization header
    const authHeader = req.headers['authorization'];
    if (authHeader && authHeader.startsWith('Bearer ')) {
        token = authHeader.split(' ')[1];
    }

    // Fallback to session-stored token
    if (!token && req.session && req.session.jwt) {
        token = req.session.jwt;
    }

    if (!token) {
        return res.redirect('/');
    }

    try {
        const decoded = jwt.verify(token, SECRET);
        const { username, logged_status } = decoded;

        const query = 'SELECT * FROM users WHERE username = ?';
        db.query(query, [username], (err, results) => {
            if (err) return res.status(500).send('Error checking user status.');
            if (results.length === 0) return res.redirect('/login');
            if (logged_status !== 'true') return res.redirect('/login');

            req.user = results[0];
            next();
        });
    } catch (error) {
        return res.redirect('/');
    }
};
// Get Profile Handler// Get Profile Handler
// Get Profile Handler
const getProfile = (req, res) => {
    const token = req.headers['authorization']?.split(' ')[1];

    if (!token) {
        return res.status(400).send('JWT token is required');
    }

    jwt.verify(token, SECRET, (err, decoded) => {
        if (err) {
            return res.status(401).send('Invalid or expired token');
        }

        const { username } = decoded;

        const query = 'SELECT username, email, phone, ssn FROM users WHERE username = ?';
        db.query(query, [username], (err, results) => {
            if (err) return res.status(500).send('Error fetching profile');
            if (results.length === 0) return res.status(404).send('User not found');

            const { email, phone, ssn } = results[0];
            res.json({ username, email, phone, ssn });
        });
    });
};

const updateProfile = (req, res) => {
    const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(400).send('JWT token is required');

    jwt.verify(token, SECRET, (err, decoded) => {
        if (err) return res.status(401).send('Invalid or expired token');

        const { username } = decoded;
        const { phone, ssn } = req.body;  // Only phone and ssn are required here

        if (!phone || !ssn) {
            return res.status(400).send('Missing required fields: phone or ssn');
        }

        // Update the users table
        const updateUsersQuery = `
            UPDATE users 
            SET phone = ?, ssn = ? 
            WHERE username = ?
        `;
        db.query(updateUsersQuery, [phone, ssn, username], (err, results) => {
            if (err) return res.status(500).send('Error updating users table');
            if (results.affectedRows === 0) return res.status(404).send('User not found');

            // Update the profiles table
            const updateProfilesQuery = `
                UPDATE profiles
                SET phone = ?, ssn = ?
                WHERE user_id = (SELECT id FROM users WHERE username = ?)
            `;
            db.query(updateProfilesQuery, [phone, ssn, username], (err, results) => {
                if (err) return res.status(500).send('Error updating profiles table');
                res.json({ message: 'Profile updated successfully' });
            });
        });
    });
};

// getComments function to fetch comments
// Fetch comments function (GET)const getComments = (req, res) => {
    const getComments = (req, res) => {
        const token = req.headers['authorization']?.split(' ')[1];
      
        if (!token) {
          return res.status(401).send('<h1>JWT token is required</h1>');
        }
      
        // Verify the token
        jwt.verify(token, SECRET, (err, decoded) => {
          if (err) {
            return res.status(401).send('<h1>Invalid or expired token</h1>');
          }
      
          const { username } = decoded; // Extract username from decoded JWT
      
          // First, check if the username exists in the users table
          const userCheckQuery = 'SELECT * FROM users WHERE username = ?';
          db.query(userCheckQuery, [username], (err, userResults) => {
            if (err) {
              return res.status(500).send('<h1>Error checking user existence</h1>');
            }
            
            // If user is not found, return an error
            if (userResults.length === 0) {
              return res.status(404).send('<h1>User not found</h1>');
            }
      
            // If user exists, fetch all comments
            const commentQuery = 'SELECT comments.id, comments.comment, comments.username FROM comments';
            db.query(commentQuery, (err, commentResults) => {
              if (err) {
                return res.status(500).send('<h1>Error fetching comments from database</h1>');
              }
      
              // Example of stored XSS vulnerability: rendering comments directly as HTML without escaping user input
              let commentsHTML = '';
              commentResults.forEach(comment => {
                commentsHTML += `<div class="comment bg-gray-800 p-4 ">
  <h3 class="text-yellow-400 text-xl font-semibold mb-2 text-left">${comment.username}</h3>
  <p class="text-white text-base text-left">${comment.comment}</p>
</div>`
;
              });
      
              // Respond with the HTML page containing vulnerable comments
              res.send(`
                <html>
                  <head><title>Comments</title></head>
                  <body>
                    <h1>Comments Section</h1>
                    ${commentsHTML}
                  </body>
                </html>
              `);
            });
          });
        });
      };
      // Add Comment Handler (Stored XSS Vulnerable)
      const addComment = async (req, res) => {
        const token = req.headers['authorization']?.split(' ')[1]; // Extract JWT from the Authorization header
    
        if (!token) {
            return res.status(401).send('<h1>JWT token is required</h1>');
        }
    
        // Verify the JWT token
        jwt.verify(token, SECRET, async (err, decoded) => {
            if (err) {
                console.error('JWT Verification failed:', err); // Log the error
                return res.status(401).send('<h1>Invalid or expired token</h1>');
            }
    
            const { username } = decoded; // Extract username from the decoded JWT
            const { comment } = req.body; // Get the comment text from the URL-encoded request body
    
            if (!comment || comment.trim() === '') {
                return res.status(400).send('<h1>Comment cannot be empty</h1>');
            }
    
            // Convert db.query to a promise so we can use await
            try {
                const insertCommentQuery = 'INSERT INTO comments (username, comment) VALUES (?, ?)';
                const result = await new Promise((resolve, reject) => {
                    db.query(insertCommentQuery, [username, comment], (err, results) => {
                        if (err) {
                            reject(err);
                        } else {
                            resolve(results);
                        }
                    });
                });
    
                // After successful insertion, return a success message
                res.status(200).send('<h1>Comment added successfully!</h1>');
            } catch (err) {
                console.error('Database error:', err); // Log the error
                return res.status(500).send('<h1>Error adding comment to the database</h1>');
            }
        });
    };
    
    
const searchOceans = (req, res) => {
    const searchTerm = req.query.q?.trim();
  
    if (!searchTerm) {
      return res.status(400).send('Search term is required');
    }
  
    const searchPattern = `%${searchTerm}%`;
  
    const query = `
      SELECT * FROM oceans 
      WHERE name LIKE ? OR location LIKE ? OR treasure LIKE ?
    `;
  
    console.log('Running search for:', searchTerm);
  
    db.query(query, [searchPattern, searchPattern, searchPattern], (err, results) => {
      if (err) {
        console.error('Error while searching oceans:', err.message);
        return res.status(500).send('Internal server error while searching.');
      }
  
      if (results.length === 0) {
        return res.status(404).send(`Sorry, we couldn't find any treasure for "${searchTerm}".`);
      }
  
      return res.status(200).json(results);
    });
  };
  const getMaps = (req, res) => {
    const token = req.headers['authorization']?.split(' ')[1]; // Get JWT from Authorization header
  
    if (!token) {
      return res.status(401).send('<h1>JWT token is required</h1>');
    }
  
    // Verify the JWT token
    jwt.verify(token, SECRET, (err, decoded) => {
      if (err) {
        console.error('JWT verification error:', err);
        return res.status(401).send('<h1>Invalid or expired token</h1>');
      }
  
      const { userId } = decoded;
  
      // First, get the username
      const userQuery = 'SELECT username FROM users WHERE id = ?';
      db.query(userQuery, [userId], (err, userResult) => {
        if (err) {
          console.error('Error fetching user info:', err);
          return res.status(500).send('<h1>Error fetching user info</h1>');
        }
  
        if (userResult.length === 0) {
          return res.status(404).send('<h1>User not found</h1>');
        }
  
        const username = userResult[0].username;
  
        // Now, get the maps for the user
        const mapQuery = 'SELECT * FROM maps WHERE user_id = ?';
        db.query(mapQuery, [userId], (err, mapResults) => {
          if (err) {
            console.error('Database query error:', err);
            return res.status(500).send('<h1>Error fetching maps from database</h1>');
          }
  
          // Return maps (even if empty) along with username
          return res.json({
            username: username,
            maps: mapResults
          });
        });
      });
    });
  };
  

    module.exports = { login, verifyJWT, getProfile, updateProfile, getComments, addComment , searchOceans, getMaps};
    