const jwt = require('jsonwebtoken');
const db = require('./config/db'); // Assuming your db setup is correct

function handleSQLInjection(term, res) {
  // Vulnerable query with SQL injection
  const query = `SELECT * FROM pirates WHERE name = '${term}'`; // ❌ Vulnerable to SQLi

  db.query(query, (err, results) => {
    if (err) {
      // Render error on the page
      return res.send(`
        <!DOCTYPE html>
        <html>
          <head>
            <title>🏴‍☠️ Error-based SQL Injection</title>
            <script src="https://cdn.tailwindcss.com"></script>
          </head>
          <body class="bg-black text-yellow-200 font-mono flex flex-col items-center mt-20">
            <h1 class="text-3xl mb-4">💀 Error-based SQL Injection </h1>

            <form action="/sqli/search" method="GET" class="space-x-4">
              <input type="text" name="q" placeholder="Search Pirate Name" class="p-2 rounded text-black" />
              <button type="submit" class="bg-yellow-400 text-black px-4 py-2 rounded">Search</button>
            </form>

            <div class="mt-8 w-full max-w-xl" id="result">
              <h3 class="text-red-500">💥 SQL Error:</h3>
              <pre>SQL Query: ${query}</pre>
              <pre>${err.sqlMessage}</pre>
            </div>
          </body>
        </html>
      `);
    }

    if (results.length === 0) {
      return res.send(`
        <!DOCTYPE html>
        <html>
          <head>
            <title>🏴‍☠️ Error-based SQL Injection</title>
            <script src="https://cdn.tailwindcss.com"></script>
          </head>
          <body class="bg-black text-yellow-200 font-mono flex flex-col items-center mt-20">
            <h1 class="text-3xl mb-4">💀 Error-based SQL Injection </h1>

            <form action="/sqli/search" method="GET" class="space-x-4">
              <input type="text" name="q" placeholder="Search Pirate Name" class="p-2 rounded text-black" />
              <button type="submit" class="bg-yellow-400 text-black px-4 py-2 rounded">Search</button>
            </form>

            <div class="mt-8 w-full max-w-xl" id="result">
              <h3 class="text-yellow-400">No pirates matched your query.</h3>
            </div>
          </body>
        </html>
      `);
    }

    // Return normal results if no SQLi payload
    let output = '<h3 class="text-green-400">🏴‍☠️ Pirate Results:</h3><ul>';
    results.forEach(p => {
      output += `<li>${p.name} - ${p.ship}</li>`;
    });
    output += '</ul>';

    return res.send(`
      <!DOCTYPE html>
      <html>
        <head>
          <title>🏴‍☠️ Error-based SQL Injection</title>
          <script src="https://cdn.tailwindcss.com"></script>
        </head>
        <body class="bg-black text-yellow-200 font-mono flex flex-col items-center mt-20">
          <h1 class="text-3xl mb-4">💀 Error-based SQL Injection </h1>

          <form action="/sqli/search" method="GET" class="space-x-4">
            <input type="text" name="q" placeholder="Search Pirate Name" class="p-2 rounded text-black" />
            <button type="submit" class="bg-yellow-400 text-black px-4 py-2 rounded">Search</button>
          </form>

          <div class="mt-8 w-full max-w-xl" id="result">
            ${output}
          </div>
        </body>
      </html>
    `);
  });
}

module.exports = { handleSQLInjection };
