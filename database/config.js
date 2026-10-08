const mysql = require("mysql2");

const con = mysql.createPool({
  connectionLimit: 10,
  maxIdle: 5,
  idleTimeout: 30000,
  host: process.env.DBHOST || "localhost",
  port: process.env.DBPORT || 3306,
  user: process.env.DBUSER,
  password: process.env.DBPASS,
  database: process.env.DBNAME,
  charset: "utf8mb4",
  connectTimeout: 60000,
  ssl: {
    minVersion: "TLSv1.2",
    rejectUnauthorized: true,
    servername: process.env.DBHOST,
  },
  waitForConnections: true,
  queueLimit: 0,
  enableKeepAlive: true,
  keepAliveInitialDelay: 10000,
});

// Handle connection errors
con.on("connection", function (connection) {
  // console.log("Database connection established as id " + connection.threadId);
});

con.on("error", function (err) {
  console.error("Database error:", err);
  if (err.code === "PROTOCOL_CONNECTION_LOST") {
    console.log("Database connection lost, reconnecting...");
  }
});

con.getConnection((err, connection) => {
  if (err) {
    console.log({
      err: err,
      msg: "Database connected error",
    });
    return;
  } else {
    console.log("Database has been connected");
    connection.release();
  }
});

module.exports = con;
