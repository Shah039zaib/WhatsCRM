require("dotenv").config({ silent: true });
const express = require("express");
const cors = require("cors");
const fs = require("fs");
const path = require("path");
const fileUpload = require("express-fileupload");
const nodeCleanup = require("node-cleanup");
const { initCampaign } = require("./loops/campaignBeta.js");
const { init, cleanup } = require("./helper/addon/qr");
const { warmerLoopInit } = require("./helper/addon/qr/warmer/index.js");
const { initTele, cleanupTele } = require("./helper/addon/telegram/tele.js");
const { updateLangJsonFromEnglish } = require("./utils/fun.js");

const app = express();
const currentDir = process.cwd();

// ─── Middleware ───────────────────────────────────────────────────────────────
app.use(express.json({ limit: "10mb" }));
app.use(express.urlencoded({ limit: "10mb", extended: true }));
app.use(cors());
// express-fileupload parses multipart bodies — only enable it on the routers
// that actually accept file uploads, so plain JSON API calls skip the overhead.
const upload = fileUpload();

// ─── Routes ───────────────────────────────────────────────────────────────────
// Routers that handle file uploads get the multipart parser; the rest skip it.
app.use("/api/user", upload, require("./routes/user"));
app.use("/api/web", upload, require("./routes/web"));
app.use("/api/admin", upload, require("./routes/admin"));
app.use("/api/phonebook", upload, require("./routes/phonebook"));
app.use("/api/agent", upload, require("./routes/agent"));
app.use("/api/manualpay", upload, require("./routes/manual_payments"));
app.use("/api/chat_flow", require("./routes/chatFlow"));
app.use("/api/inbox", require("./routes/inbox"));
app.use("/api/templet", require("./routes/templet"));
app.use("/api/chatbot", require("./routes/chatbot"));
app.use("/api/broadcast", require("./routes/broadcast"));
app.use("/api/v1", require("./routes/apiv2"));
app.use("/api/qr", require("./routes/qr"));
app.use("/api/ai", require("./routes/ai"));
app.use("/api/webhook", require("./routes/webhook"));
app.use("/api/wa_call", require("./routes/waCall"));
app.use("/api/telegram", require("./routes/telegram"));
app.use("/api/theme", require("./routes/theme"));
app.use("/api/insta", require("./routes/insta"));
app.use("/api/kaban", require("./routes/kaban"));
app.use("/api/waform", require("./routes/waform"));

// ─── Media Streaming Middleware ───────────────────────────────────────────────
const createMediaMiddleware = (folderPath) => {
  const mimeTypes = {
    // Video
    ".mp4": "video/mp4",
    ".webm": "video/webm",
    ".mov": "video/quicktime",
    ".avi": "video/x-msvideo",
    // Audio
    ".mp3": "audio/mpeg",
    ".ogg": "audio/ogg",
    ".opus": "audio/opus",
    ".wav": "audio/wav",
    ".m4a": "audio/mp4",
    ".aac": "audio/aac",
  };

  return express.static(path.resolve(currentDir, folderPath), {
    setHeaders: (res, filePath) => {
      res.setHeader("Accept-Ranges", "bytes");

      const ext = path.extname(filePath).toLowerCase();
      if (mimeTypes[ext]) {
        res.setHeader("Content-Type", mimeTypes[ext]);
      }

      res.setHeader("Cache-Control", "public, max-age=31536000");
      res.setHeader("Access-Control-Allow-Origin", "*");
      res.setHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
      res.setHeader("Access-Control-Allow-Headers", "Range");
    },
    index: false,
    acceptRanges: true,
  });
};

app.use("/media", createMediaMiddleware("./client/public/media"));
app.use("/meta-media", createMediaMiddleware("./client/public/meta-media"));

// ─── Static & Catch-All ───────────────────────────────────────────────────────
// Hashed build assets (main.<hash>.js/css) are immutable — cache them for a
// year so repeat visits don't re-download the 5MB bundle. index.html itself
// is never cached so deploys are picked up immediately.
app.use(
  express.static(path.resolve(currentDir, "./client/public"), {
    index: false,
    maxAge: "1y",
    immutable: true,
    setHeaders: (res, filePath) => {
      if (filePath.endsWith("index.html") || filePath.endsWith(".json")) {
        res.setHeader("Cache-Control", "no-cache");
      }
    },
  })
);

app.get("*", function (request, response) {
  response.sendFile(path.resolve(currentDir, "./client/public", "index.html"));
});

// ─── Server ───────────────────────────────────────────────────────────────────
const server = app.listen(process.env.PORT || 3010, () => {
  console.log(`WaCrm server is running on port ${process.env.PORT}`);
  // Defer language sync until after the server is accepting connections so
  // startup isn't blocked by file I/O on slow disks.
  setImmediate(() => {
    try {
      updateLangJsonFromEnglish();
    } catch (e) {
      console.error("[LangSync] deferred sync failed:", e?.message);
    }
  });
  // init();
  // setTimeout(() => {
  //   warmerLoopInit();
  //   initCampaign();
  //   initTele();
  // }, 1000);
});

// ─── Socket.IO ────────────────────────────────────────────────────────────────
const io = require("./socket").initializeSocket(server);
module.exports = io;

// ─── Cleanup ──────────────────────────────────────────────────────────────────
nodeCleanup(async (exitCode, signal) => {
  await cleanupTele();
  cleanup();
});
