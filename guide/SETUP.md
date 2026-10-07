# WhatsCRM — Setup Guide

Complete step-by-step guide to install, configure and run WhatsCRM.

## Requirements

- **Node.js** v18 or higher (v20+ recommended)
- **MySQL** v8.0 or higher
- **Git**

## 1. Clone the repository

```bash
git clone https://github.com/Shah039zaib/WhatsCRM.git
cd WhatsCRM
```

## 2. Install dependencies

```bash
npm install
```

If native modules (bcrypt, sharp) fail to build, run:

```bash
npm rebuild bcrypt sharp
```

## 3. Create the database

```bash
mysql -u root -p -e "CREATE DATABASE whatscrm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
```

Import the schema (reverse-engineered from the application code):

```bash
mysql -u root -p whatscrm < guide/whatscrm-schema.sql
```

Create a dedicated MySQL user (recommended):

```bash
mysql -u root -p -e "CREATE USER 'whatscrm'@'localhost' IDENTIFIED BY 'your-strong-password'; GRANT ALL PRIVILEGES ON whatscrm.* TO 'whatscrm'@'localhost'; FLUSH PRIVILEGES;"
```

## 4. Configure environment

```bash
cp guide/.env.example .env
```

Edit `.env` and set your values:

| Variable | Description | Example |
|---|---|---|
| `PORT` | Server port | `3010` |
| `DBHOST` | MySQL host | `localhost` |
| `DBPORT` | MySQL port | `3306` |
| `DBUSER` | MySQL user | `whatscrm` |
| `DBPASS` | MySQL password | `your-strong-password` |
| `DBNAME` | Database name | `whatscrm` |
| `JWTKEY` | JWT secret (long random string) | `...` |
| `NODE_ENV` | `development` or `production` | `production` |
| `BACKURI` | Backend URL | `http://localhost:3010` |
| `FRONTENDURI` | Frontend URL | `http://localhost:3010` |

> ⚠️ Never commit the real `.env` file to git. It contains secrets.

## 5. Run the application

```bash
npm start
```

You should see:

```
Database has been connected
[LangSync] All language files are in sync with English.json
WaCrm server is running on port 3010
```

Open `http://localhost:3010` in your browser.

For production, use a process manager:

```bash
npm install -g pm2
pm2 start server.js --name whatscrm
pm2 save
```

## 6. Connect WhatsApp

1. Log in to the admin panel.
2. Go to the WhatsApp / instance section.
3. Scan the QR code with your phone to link a session.

Sessions are stored locally in `sessions/` (excluded from git — never commit live session credentials).

## Troubleshooting

| Problem | Fix |
|---|---|
| `Database connected error` (ECONNREFUSED) | MySQL is not running, or `.env` credentials are wrong. Check `sudo service mysql status`. |
| `Unknown database 'whatscrm'` | Create the database and import `guide/whatscrm-schema.sql` (step 3). |
| bcrypt / sharp errors at runtime | Run `npm rebuild bcrypt sharp`. |
| Port already in use | Change `PORT` in `.env` or stop the other process. |
| Language sync warnings | Normal on first run; files auto-sync. |

## Files in this guide folder

- `whatscrm-schema.sql` — full database schema (52 tables, reverse-engineered from the code)
- `.env.example` — environment template (copy to `.env`)
- `SETUP.md` — this file
