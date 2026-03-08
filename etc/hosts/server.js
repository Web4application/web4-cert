// server.js
const https = require('https');
const fs = require('fs');

const options = {
  key: fs.readFileSync(process.env.API + '/web4_certs/ci.web4.com.key'),
  cert: fs.readFileSync(process.env.API + '/web4_certs/ci.web4.com.crt'),
  ca: fs.readFileSync(process.env.API + '/web4_certs/WEB4 Root CA.crt')
};

https.createServer(options, (req, res) => {
  res.writeHead(200);
  res.end("Hello from secure Web4!");
}).listen(8443, () => {
  console.log("HTTPS server running at https://ci.web4.com:8443");
});
