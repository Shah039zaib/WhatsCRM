# WhatsCRM — WhatsApp CRM SaaS System

WhatsCRM ek mukammal WhatsApp CRM aur chatbot SaaS system hai. Is me aap multiple WhatsApp accounts connect kar sakte hain, chatbot flows bana sakte hain, broadcasts bhej sakte hain, aur apne customers ko SaaS plans bech sakte hain.

## Khas Features

- **WhatsApp Multi-Account** — QR code scan karke multiple WhatsApp numbers connect karen
- **Chatbot Flow Builder** — Flow builder with AI replies
- **Broadcast / Campaigns** — Hazaaron contacts ko ek sath messages bhejen
- **Inbox** — Sab chats ek jagah, tags, notes, aur team assignment
- **Instagram & Telegram** — Alag inbox integrations
- **SaaS Plans** — Subscription plans banayen, users se payment len
- **Manual Payments (Pakistan)** — EasyPaisa, JazzCash, Bank transfer; admin screenshot dekh kar approve kare
- **AI Integration** — OpenAI se smart auto-replies
- **Multi-language** — English, Urdu, Turkish, Arabic waghera

## Zaroorat (Requirements)

- **Node.js** v18 ya zyada (v20+ behtar)
- **MySQL** v8.0 ya zyada
- **Git**

## Install Karne Ka Tarika

### 1. Code download karen

```bash
git clone https://github.com/Shah039zaib/WhatsCRM.git
cd WhatsCRM
```

### 2. Dependencies install karen

```bash
npm install
```

Agar koi error aye to:

```bash
npm rebuild bcrypt sharp
```

### 3. Database banayen

```bash
mysql -u root -p -e "CREATE DATABASE whatscrm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
```

Schema import karen (59 tables):

```bash
mysql -u root -p whatscrm < guide/whatscrm-schema.sql
```

Alag MySQL user banayen (recommended):

```bash
mysql -u root -p -e "CREATE USER 'whatscrm'@'localhost' IDENTIFIED BY 'apna-mazboot-password'; GRANT ALL PRIVILEGES ON whatscrm.* TO 'whatscrm'@'localhost'; FLUSH PRIVILEGES;"
```

### 4. Settings (.env) banayen

```bash
cp guide/.env.example .env
```

Phir `.env` kholen aur apni values likhen:

```
PORT=3010
DBHOST=localhost
DBPORT=3306
DBUSER=whatscrm
DBPASS=apna-mazboot-password
DBNAME=whatscrm
JWTKEY=koi-lambi-random-secret-key
NODE_ENV=production
BACKURI=http://localhost:3010
FRONTENDURI=http://localhost:3010
```

> **Khabardar:** Asli `.env` file kabhi GitHub par upload na karen — is me passwords hote hain.

### 5. App chalyen

```bash
npm start
```

Agar sab theek ho to ye nazar ayega:

```
Database has been connected
[LangSync] All language files are in sync with English.json
WaCrm server is running on port 3010
```

Browser me kholen: `http://localhost:3010`

## VPS Par Deploy Karna (Production)

### PM2 se chalana (recommended)

```bash
npm install -g pm2
pm2 start server.js --name whatscrm
pm2 save
pm2 startup
```

### Nginx reverse proxy (domain ke liye)

```nginx
server {
    listen 80;
    server_name apka-domain.com;

    location / {
        proxy_pass http://localhost:3010;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

Phir SSL ke liye:

```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d apka-domain.com
```

### .env me domain update karen

```
BACKURI=https://apka-domain.com
FRONTENDURI=https://apka-domain.com
```

## Manual Payment Setup (Pakistan)

1. Admin panel me login karen
2. Kholein: `http://apka-domain.com/admin-manual-payments.html`
3. **Payment Methods** section me EasyPaisa / JazzCash / Bank ke account details add karen
4. Jab user payment karega to `http://apka-domain.com/manual-pay.html` se screenshot upload karega
5. **Submissions** table me screenshot dekh kar **Approve** ya **Reject** karen
6. Approve hote hi user ka plan khud-ba-khud activate ho jayega

## WhatsApp Connect Karna

1. Login ke baad WhatsApp / Instance section me jayen
2. QR code ayega — apne mobile se scan karen
3. Session connect ho jayegi

> `sessions/` folder me WhatsApp ke session data hota hai — ye kabhi GitHub par upload na karen.

## Guide Folder

`guide/` folder me ye files hain:

- `whatscrm-schema.sql` — Mukammal database schema (59 tables)
- `.env.example` — Settings ki sample file
- `SETUP.md` — English me tafseeli setup guide

## Masail Hal Karna (Troubleshooting)

| Masla | Hal |
|---|---|
| `Database connected error` | MySQL chal raha hai? `.env` me password theek hai? |
| `Unknown database 'whatscrm'` | Database banayen aur schema import karen (step 3) |
| Port pehle se use me hai | `.env` me `PORT` change karen |
| bcrypt/sharp error | `npm rebuild bcrypt sharp` chalayen |

## License

Is version me license verification hata di gayi hai — koi license key darkar nahi, seedha deploy karen.
