-- ======================================================================
-- WhatsCRM v5.9.5 — Database Schema
-- ======================================================================
--
-- REVERSE-ENGINEERED from the Node.js backend source code.
-- The original .sql schema file was not included in the distribution,
-- so every table and column below was inferred from SQL queries
-- (SELECT / INSERT / UPDATE / WHERE / JOIN) found in the backend .js files.
--
-- IMPORTANT:
--   1. Column TYPES are best-guess inferences (usage-based heuristics).
--   2. Tables marked 'columns inferred' had few/no column references;
--      verify and extend them against a working installation if available.
--   3. All tables use utf8mb4. Every table has an auto-increment `id`.
--   4. Review before using in production.
--
-- Generated: 2026-10-07
-- ======================================================================

CREATE DATABASE IF NOT EXISTS whatscrm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE whatscrm;

-- Table: admin (4 columns)
CREATE TABLE IF NOT EXISTS `admin` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_email` (`email`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: agent_chats (4 columns)
CREATE TABLE IF NOT EXISTS `agent_chats` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `chat_id` VARCHAR(255) NULL,
  `owner_uid` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_chat_id` (`chat_id`),
  KEY `idx_owner_uid` (`owner_uid`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: agent_task (7 columns)
CREATE TABLE IF NOT EXISTS `agent_task` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `agent_comments` TEXT NULL,
  `description` TEXT NULL,
  `owner_uid` VARCHAR(255) NULL,
  `status` VARCHAR(50) NULL,
  `title` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: agents (14 columns)
CREATE TABLE IF NOT EXISTS `agents` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `allow_save_contact` TEXT NULL,
  `allow_send_new_qr` TEXT NULL,
  `comments` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `fcm_data` LONGTEXT NULL,
  `is_active` TINYINT(1) NULL DEFAULT 0,
  `logs` LONGTEXT NULL,
  `mask_number` TEXT NULL,
  `mobile` VARCHAR(50) NULL,
  `name` VARCHAR(255) NULL,
  `owner_uid` VARCHAR(255) NULL,
  `password` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_email` (`email`),
  KEY `idx_is_active` (`is_active`),
  KEY `idx_owner_uid` (`owner_uid`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: beta_api_analytics (4 columns)
CREATE TABLE IF NOT EXISTS `beta_api_analytics` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `date` DATETIME NULL,
  `statusfield` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: beta_api_logs (7 columns)
CREATE TABLE IF NOT EXISTS `beta_api_logs` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `err` VARCHAR(255) NULL,
  `msg_id` VARCHAR(255) NULL,
  `request` LONGTEXT NULL,
  `response` LONGTEXT NULL,
  `status` VARCHAR(50) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_msg_id` (`msg_id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: beta_api_messages (5 columns)
CREATE TABLE IF NOT EXISTS `beta_api_messages` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `meta_msg_id` VARCHAR(255) NULL,
  `status` VARCHAR(50) NULL,
  `uid` VARCHAR(255) NULL,
  `updated_at` DATETIME NULL,
  KEY `idx_meta_msg_id` (`meta_msg_id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: beta_campaign (27 columns)
CREATE TABLE IF NOT EXISTS `beta_campaign` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `added` VARCHAR(255) NULL,
  `around` VARCHAR(255) NULL,
  `backticks` VARCHAR(255) NULL,
  `body_variables` LONGTEXT NULL,
  `button_variables` LONGTEXT NULL,
  `campaign_id` VARCHAR(255) NULL,
  `createdat` DATETIME NULL,
  `daily` VARCHAR(255) NULL,
  `days` VARCHAR(255) NULL,
  `fixed` VARCHAR(255) NULL,
  `for` VARCHAR(255) NULL,
  `header_variable` LONGTEXT NULL,
  `last` VARCHAR(255) NULL,
  `phonebook_id` VARCHAR(255) NULL,
  `phonebook_name` VARCHAR(255) NULL,
  `schedule` VARCHAR(255) NULL,
  `sent_count` TEXT NULL,
  `stats` VARCHAR(255) NULL,
  `status` VARCHAR(50) NULL,
  `template_language` TEXT NULL,
  `template_name` VARCHAR(255) NULL,
  `the` VARCHAR(255) NULL,
  `timezone` VARCHAR(100) NULL,
  `title` VARCHAR(255) NULL,
  `total_contacts` TEXT NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_campaign_id` (`campaign_id`),
  KEY `idx_status` (`status`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: beta_campaign_logs (24 columns)
CREATE TABLE IF NOT EXISTS `beta_campaign_logs` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `await` VARCHAR(255) NULL,
  `beta_campaign_logs` TEXT NULL,
  `campaign` VARCHAR(255) NULL,
  `campaign_id` VARCHAR(255) NULL,
  `campaignid` VARCHAR(255) NULL,
  `const` VARCHAR(255) NULL,
  `contact_mobile` TEXT NULL,
  `contact_name` VARCHAR(255) NULL,
  `createdat` DATETIME NULL,
  `date` DATETIME NULL,
  `delivery_status` VARCHAR(50) NULL,
  `delivery_time` TEXT NULL,
  `error_message` TEXT NULL,
  `hour` VARCHAR(255) NULL,
  `last` VARCHAR(255) NULL,
  `let` VARCHAR(255) NULL,
  `logs` LONGTEXT NULL,
  `meta_msg_id` VARCHAR(255) NULL,
  `pendinglogs` VARCHAR(255) NULL,
  `query` VARCHAR(255) NULL,
  `recent` VARCHAR(255) NULL,
  `status` VARCHAR(50) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_campaign` (`campaign`),
  KEY `idx_campaign_id` (`campaign_id`),
  KEY `idx_createdat` (`createdat`),
  KEY `idx_delivery_status` (`delivery_status`),
  KEY `idx_meta_msg_id` (`meta_msg_id`),
  KEY `idx_pendinglogs` (`pendinglogs`),
  KEY `idx_status` (`status`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: beta_chatbot (8 columns)
CREATE TABLE IF NOT EXISTS `beta_chatbot` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `active` TINYINT(1) NULL DEFAULT 0,
  `flow_id` VARCHAR(255) NULL,
  `origin` LONGTEXT NULL,
  `origin_id` VARCHAR(255) NULL,
  `source` VARCHAR(100) NULL,
  `title` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_active` (`active`),
  KEY `idx_origin` (`origin`(191)),
  KEY `idx_origin_id` (`origin_id`),
  KEY `idx_source` (`source`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: beta_chats (18 columns)
CREATE TABLE IF NOT EXISTS `beta_chats` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `assigned_agent` LONGTEXT NULL,
  `chat_id` VARCHAR(255) NULL,
  `chat_label` LONGTEXT NULL,
  `chat_note` TEXT NULL,
  `createdat` DATETIME NULL,
  `kanban_order` TEXT NULL,
  `labels` VARCHAR(255) NULL,
  `last_message` LONGTEXT NULL,
  `old_chat_id` TEXT NULL,
  `origin` LONGTEXT NULL,
  `origin_instance_id` TEXT NULL,
  `profile` VARCHAR(255) NULL,
  `sender_mobile` VARCHAR(50) NULL,
  `sender_name` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  `unread_count` TEXT NULL,
  `updatedat` DATETIME NULL,
  KEY `idx_assigned_agent` (`assigned_agent`(191)),
  KEY `idx_chat_id` (`chat_id`),
  KEY `idx_labels` (`labels`),
  KEY `idx_origin` (`origin`(191)),
  KEY `idx_sender_mobile` (`sender_mobile`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: beta_conversation (17 columns)
CREATE TABLE IF NOT EXISTS `beta_conversation` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `chat_id` VARCHAR(255) NULL,
  `context` LONGTEXT NULL,
  `createdat` DATETIME NULL,
  `err` VARCHAR(255) NULL,
  `metachatid` VARCHAR(255) NULL,
  `msgcontext` LONGTEXT NULL,
  `origin` LONGTEXT NULL,
  `reaction` VARCHAR(255) NULL,
  `route` VARCHAR(255) NULL,
  `sendermobile` VARCHAR(255) NULL,
  `sendername` VARCHAR(255) NULL,
  `star` VARCHAR(255) NULL,
  `status` VARCHAR(50) NULL,
  `timestamp` DATETIME NULL,
  `type` VARCHAR(100) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_chat_id` (`chat_id`),
  KEY `idx_metachatid` (`metachatid`),
  KEY `idx_route` (`route`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: beta_flows (7 columns)
CREATE TABLE IF NOT EXISTS `beta_flows` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `data` LONGTEXT NULL,
  `flow_id` VARCHAR(255) NULL,
  `is_active` TINYINT(1) NULL DEFAULT 0,
  `name` VARCHAR(255) NULL,
  `source` VARCHAR(100) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_flow_id` (`flow_id`),
  KEY `idx_is_active` (`is_active`),
  KEY `idx_source` (`source`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: broadcast (18 columns)
CREATE TABLE IF NOT EXISTS `broadcast` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `broadcast_id` VARCHAR(255) NULL,
  `calls_completed` TEXT NULL,
  `calls_failed` TEXT NULL,
  `calls_initiated` TEXT NULL,
  `contacts` VARCHAR(255) NULL,
  `logs` LONGTEXT NULL,
  `meta_data` TEXT NULL,
  `permission_denied` TEXT NULL,
  `permission_granted` TEXT NULL,
  `permission_requested` TEXT NULL,
  `phonebook` LONGTEXT NULL,
  `schedule` VARCHAR(255) NULL,
  `status` VARCHAR(50) NULL,
  `templet` LONGTEXT NULL,
  `timezone` VARCHAR(100) NULL,
  `title` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_broadcast_id` (`broadcast_id`),
  KEY `idx_status` (`status`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: broadcast_log (9 columns)
CREATE TABLE IF NOT EXISTS `broadcast_log` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `broadcast_id` VARCHAR(255) NULL,
  `contact` VARCHAR(255) NULL,
  `delivery_status` VARCHAR(50) NULL,
  `example` LONGTEXT NULL,
  `send_to` TEXT NULL,
  `sender_mobile` VARCHAR(50) NULL,
  `templet_name` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_broadcast_id` (`broadcast_id`),
  KEY `idx_delivery_status` (`delivery_status`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: chat_tags (4 columns)
CREATE TABLE IF NOT EXISTS `chat_tags` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `hex` VARCHAR(255) NULL,
  `title` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: chat_widget (8 columns)
CREATE TABLE IF NOT EXISTS `chat_widget` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `logo` VARCHAR(500) NULL,
  `place` VARCHAR(255) NULL,
  `size` VARCHAR(255) NULL,
  `title` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  `unique_id` VARCHAR(255) NULL,
  `whatsapp_number` VARCHAR(50) NULL,
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: chatbot (10 columns)
CREATE TABLE IF NOT EXISTS `chatbot` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `active` TINYINT(1) NULL DEFAULT 0,
  `chats` LONGTEXT NULL,
  `flow` LONGTEXT NULL,
  `flow_id` VARCHAR(255) NULL,
  `for_all` TINYINT(1) NULL DEFAULT 0,
  `js` VARCHAR(255) NULL,
  `origin` LONGTEXT NULL,
  `title` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_active` (`active`),
  KEY `idx_origin` (`origin`(191)),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: chats (11 columns)
CREATE TABLE IF NOT EXISTS `chats` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `chat_id` VARCHAR(255) NULL,
  `chat_note` TEXT NULL,
  `chat_status` VARCHAR(50) NULL,
  `chat_tags` TEXT NULL,
  `is_opened` TINYINT(1) NULL DEFAULT 0,
  `last_message` LONGTEXT NULL,
  `last_message_came` DATETIME NULL,
  `sender_mobile` VARCHAR(50) NULL,
  `sender_name` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_chat_id` (`chat_id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: contact (12 columns)
CREATE TABLE IF NOT EXISTS `contact` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `mobile` VARCHAR(50) NULL,
  `name` VARCHAR(255) NULL,
  `phonebook_id` VARCHAR(255) NULL,
  `phonebook_name` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  `var1` VARCHAR(255) NULL,
  `var2` VARCHAR(255) NULL,
  `var3` VARCHAR(255) NULL,
  `var4` VARCHAR(255) NULL,
  `var5` VARCHAR(255) NULL,
  `var6` VARCHAR(255) NULL,
  KEY `idx_mobile` (`mobile`),
  KEY `idx_phonebook_id` (`phonebook_id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: contact_form (5 columns)
CREATE TABLE IF NOT EXISTS `contact_form` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `content` TEXT NULL,
  `email` VARCHAR(255) NULL,
  `mobile` VARCHAR(50) NULL,
  `name` VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: faq (3 columns)
-- NOTE: Minimal Q&A structure as referenced.
CREATE TABLE IF NOT EXISTS `faq` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `answer` TEXT NULL,
  `question` TEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: fcm_tokens (5 columns)
CREATE TABLE IF NOT EXISTS `fcm_tokens` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `existing` VARCHAR(255) NULL,
  `other` LONGTEXT NULL,
  `token` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_existing` (`existing`),
  KEY `idx_other` (`other`(191)),
  KEY `idx_token` (`token`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: flow (7 columns)
CREATE TABLE IF NOT EXISTS `flow` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `ai_list` TEXT NULL,
  `flow_id` VARCHAR(255) NULL,
  `name` VARCHAR(255) NULL,
  `prevent_list` TEXT NULL,
  `title` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_flow_id` (`flow_id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: flow_data (5 columns)
CREATE TABLE IF NOT EXISTS `flow_data` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `inputs` LONGTEXT NULL,
  `other` LONGTEXT NULL,
  `uid` VARCHAR(255) NULL,
  `uniqueid` VARCHAR(255) NULL,
  KEY `idx_uid` (`uid`),
  KEY `idx_uniqueid` (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: flow_session (7 columns)
CREATE TABLE IF NOT EXISTS `flow_session` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `data` LONGTEXT NULL,
  `flow_id` VARCHAR(255) NULL,
  `origin` LONGTEXT NULL,
  `origin_id` VARCHAR(255) NULL,
  `sender_mobile` VARCHAR(50) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_flow_id` (`flow_id`),
  KEY `idx_origin` (`origin`(191)),
  KEY `idx_origin_id` (`origin_id`),
  KEY `idx_sender_mobile` (`sender_mobile`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: flow_templates (5 columns)
CREATE TABLE IF NOT EXISTS `flow_templates` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `data` LONGTEXT NULL,
  `description` TEXT NULL,
  `source` VARCHAR(100) NULL,
  `title` VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: g_auth (4 columns)
CREATE TABLE IF NOT EXISTS `g_auth` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `label` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  `url` VARCHAR(500) NULL,
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: gen_links (4 columns)
CREATE TABLE IF NOT EXISTS `gen_links` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `email` VARCHAR(255) NULL,
  `msg` TEXT NULL,
  `wa_mobile` VARCHAR(50) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: instagram_accounts (14 columns)
CREATE TABLE IF NOT EXISTS `instagram_accounts` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `access_token` TEXT NULL,
  `connected_at` DATETIME NULL,
  `createdat` DATETIME NULL,
  `expires_in` TEXT NULL,
  `ig_graph_id` TEXT NULL,
  `name` VARCHAR(255) NULL,
  `page_id` TEXT NULL,
  `profile_pic` VARCHAR(500) NULL,
  `token_type` TEXT NULL,
  `uid` VARCHAR(255) NULL,
  `user_id` TEXT NULL,
  `username` VARCHAR(255) NULL,
  `webhook_id` TEXT NULL,
  KEY `idx_uid` (`uid`),
  KEY `idx_user_id` (`user_id`(191)),
  KEY `idx_webhook_id` (`webhook_id`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: instance (8 columns)
CREATE TABLE IF NOT EXISTS `instance` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `data` LONGTEXT NULL,
  `number` VARCHAR(255) NULL,
  `other` LONGTEXT NULL,
  `status` VARCHAR(50) NULL,
  `title` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  `uniqueid` VARCHAR(255) NULL,
  KEY `idx_number` (`number`),
  KEY `idx_status` (`status`),
  KEY `idx_uid` (`uid`),
  KEY `idx_uniqueid` (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: meta_api (10 columns)
CREATE TABLE IF NOT EXISTS `meta_api` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `access_token` TEXT NULL,
  `app_id` VARCHAR(255) NULL,
  `business_phone_number_id` VARCHAR(255) NULL,
  `embed_data` LONGTEXT NULL,
  `is_coexistence` TINYINT(1) NULL DEFAULT 0,
  `login_type` VARCHAR(100) NULL,
  `platform_type` TEXT NULL,
  `uid` VARCHAR(255) NULL,
  `waba_id` VARCHAR(255) NULL,
  KEY `idx_business_phone_number_id` (`business_phone_number_id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: meta_templet_media (5 columns)
CREATE TABLE IF NOT EXISTS `meta_templet_media` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `file_name` VARCHAR(255) NULL,
  `meta_hash` TEXT NULL,
  `templet_name` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: mobile_app (3 columns)
-- NOTE: Minimal structure as referenced.
CREATE TABLE IF NOT EXISTS `mobile_app` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `apptheme` VARCHAR(255) NULL,
  `fcmjson` LONGTEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: orders (7 columns)
CREATE TABLE IF NOT EXISTS `orders` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `amount` DECIMAL(10,2) NULL,
  `createdat` DATETIME NULL,
  `data` LONGTEXT NULL,
  `payment_mode` VARCHAR(100) NULL,
  `s_token` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: page (6 columns)
CREATE TABLE IF NOT EXISTS `page` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `content` TEXT NULL,
  `image` VARCHAR(500) NULL,
  `permanent` TINYINT(1) NULL DEFAULT 0,
  `slug` VARCHAR(255) NULL,
  `title` VARCHAR(255) NULL,
  KEY `idx_permanent` (`permanent`),
  KEY `idx_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: partners (2 columns)
-- NOTE: Only `filename` referenced; structure is minimal.
CREATE TABLE IF NOT EXISTS `partners` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `filename` VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: phonebook (3 columns)
-- NOTE: Minimal structure as referenced.
CREATE TABLE IF NOT EXISTS `phonebook` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_name` (`name`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: plan (18 columns)
CREATE TABLE IF NOT EXISTS `plan` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `allow_api` TEXT NULL,
  `allow_chatbot` TEXT NULL,
  `allow_note` TEXT NULL,
  `allow_tag` TEXT NULL,
  `allow_wa_forms` TEXT NULL,
  `contact_limit` TEXT NULL,
  `instagram_inbox` TEXT NULL,
  `is_trial` TINYINT(1) NULL DEFAULT 0,
  `plan_duration_in_days` TEXT NULL,
  `price` DECIMAL(10,2) NULL,
  `price_strike` TEXT NULL,
  `qr_account` TEXT NULL,
  `rest_api_qr` TEXT NULL,
  `short_description` TEXT NULL,
  `telegram_inbox` TEXT NULL,
  `title` VARCHAR(255) NULL,
  `wa_warmer` TEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: quick_reply (3 columns)
-- NOTE: Minimal structure as referenced.
CREATE TABLE IF NOT EXISTS `quick_reply` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `msg` TEXT NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: rooms (4 columns)
-- NOTE: Only `uid` referenced in backend queries; additional columns are inferred.
CREATE TABLE IF NOT EXISTS `rooms` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `uid` VARCHAR(255) NULL,
  `name` VARCHAR(255) NULL,  -- inferred, not found in code,
  `createdAt` DATETIME NULL,  -- inferred, not found in code,
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: smtp (6 columns)
CREATE TABLE IF NOT EXISTS `smtp` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `email` VARCHAR(255) NULL,
  `host` VARCHAR(255) NULL,
  `password` VARCHAR(255) NULL,
  `port` INT NULL,
  `username` VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: telegram_session (3 columns)
-- NOTE: Minimal structure as referenced.
CREATE TABLE IF NOT EXISTS `telegram_session` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `status` VARCHAR(50) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_status` (`status`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: templets (5 columns)
CREATE TABLE IF NOT EXISTS `templets` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `content` TEXT NULL,
  `title` VARCHAR(255) NULL,
  `type` VARCHAR(100) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: testimonial (5 columns)
CREATE TABLE IF NOT EXISTS `testimonial` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `description` TEXT NULL,
  `reviewer_name` VARCHAR(255) NULL,
  `reviewer_position` TEXT NULL,
  `title` VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: user (15 columns)
CREATE TABLE IF NOT EXISTS `user` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `api_key` VARCHAR(255) NULL,
  `createdat` DATETIME NULL,
  `email` VARCHAR(255) NULL,
  `fcm_data` LONGTEXT NULL,
  `fcm_inbox` LONGTEXT NULL,
  `mobile_with_country_code` VARCHAR(50) NULL,
  `name` VARCHAR(255) NULL,
  `password` VARCHAR(255) NULL,
  `plan` LONGTEXT NULL,
  `plan_expire` DATETIME NULL,
  `role` VARCHAR(100) NULL,
  `timezone` VARCHAR(100) NULL,
  `trial` TINYINT(1) NULL DEFAULT 0,
  `uid` VARCHAR(255) NULL,
  KEY `idx_email` (`email`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: users (6 columns)
-- NOTE: Table name appears in code comments but no backend SQL queries reference it directly; structure mirrors `user` table as best guess.
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `uid` VARCHAR(255) NULL,  -- inferred, not found in code,
  `name` VARCHAR(255) NULL,  -- inferred, not found in code,
  `email` VARCHAR(255) NULL,  -- inferred, not found in code,
  `password` VARCHAR(255) NULL,  -- inferred, not found in code,
  `createdAt` DATETIME NULL  -- inferred, not found in code
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: wa_call_bot (5 columns)
CREATE TABLE IF NOT EXISTS `wa_call_bot` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `active` TINYINT(1) NULL DEFAULT 0,
  `flow_id` VARCHAR(255) NULL,
  `title` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: wa_call_broadcasts (4 columns)
CREATE TABLE IF NOT EXISTS `wa_call_broadcasts` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `contacts` VARCHAR(255) NULL,
  `logs` LONGTEXT NULL,
  `status` VARCHAR(50) NULL,
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: wa_call_flows (6 columns)
CREATE TABLE IF NOT EXISTS `wa_call_flows` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `data` LONGTEXT NULL,
  `flow_id` VARCHAR(255) NULL,
  `name` VARCHAR(255) NULL,
  `source` VARCHAR(100) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_flow_id` (`flow_id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: wa_call_logs (7 columns)
-- NOTE: Only `uid` referenced in backend queries; additional columns are inferred from call-log context.
CREATE TABLE IF NOT EXISTS `wa_call_logs` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `uid` VARCHAR(255) NULL,
  `caller` VARCHAR(50) NULL,  -- inferred, not found in code,
  `callee` VARCHAR(50) NULL,  -- inferred, not found in code,
  `duration` INT NULL,  -- inferred, not found in code,
  `status` VARCHAR(50) NULL,  -- inferred, not found in code,
  `createdAt` DATETIME NULL,  -- inferred, not found in code,
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: wa_form_submissions (7 columns)
CREATE TABLE IF NOT EXISTS `wa_form_submissions` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `createdat` DATETIME NULL,
  `flow_id` VARCHAR(255) NULL,
  `form_name` VARCHAR(255) NULL,
  `from_phone` TEXT NULL,
  `raw_payload` TEXT NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: wa_forms (8 columns)
CREATE TABLE IF NOT EXISTS `wa_forms` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `createdat` DATETIME NULL,
  `description` TEXT NULL,
  `fields_json` TEXT NULL,
  `flow_id` VARCHAR(255) NULL,
  `flow_status` VARCHAR(50) NULL,
  `name` VARCHAR(255) NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: warmer_script (3 columns)
-- NOTE: Minimal structure as referenced.
CREATE TABLE IF NOT EXISTS `warmer_script` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `message` TEXT NULL,
  `uid` VARCHAR(255) NULL,
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: warmers (4 columns)
CREATE TABLE IF NOT EXISTS `warmers` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `instances` VARCHAR(255) NULL,
  `is_active` TINYINT(1) NULL DEFAULT 0,
  `uid` VARCHAR(255) NULL,
  KEY `idx_is_active` (`is_active`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: web_private (39 columns)
CREATE TABLE IF NOT EXISTS `web_private` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `embed_app_config` TEXT NULL,
  `embed_app_id` TEXT NULL,
  `embed_app_sec` TEXT NULL,
  `fcm_apikey` TEXT NULL,
  `fcm_appid` TEXT NULL,
  `fcm_authdomain` TEXT NULL,
  `fcm_clientemail` TEXT NULL,
  `fcm_measurementid` TEXT NULL,
  `fcm_messagingsenderid` TEXT NULL,
  `fcm_privatekey` TEXT NULL,
  `fcm_projectid` TEXT NULL,
  `fcm_storagebucket` TEXT NULL,
  `fcm_vapidkey` TEXT NULL,
  `insta_app_id` TEXT NULL,
  `insta_app_secret` TEXT NULL,
  `insta_callback_url` TEXT NULL,
  `mercadopago_active` TEXT NULL,
  `mongodb_string` TEXT NULL,
  `offline_active` TEXT NULL,
  `pay_mercadopago_access_token` TEXT NULL,
  `pay_mercadopago_public_key` TEXT NULL,
  `pay_offline_id` TEXT NULL,
  `pay_offline_key` TEXT NULL,
  `pay_paypal_id` TEXT NULL,
  `pay_paypal_key` TEXT NULL,
  `pay_paystack_id` TEXT NULL,
  `pay_paystack_key` TEXT NULL,
  `pay_stripe_id` TEXT NULL,
  `pay_stripe_key` TEXT NULL,
  `paypal_active` TEXT NULL,
  `paystack_active` TEXT NULL,
  `qr_storage` TEXT NULL,
  `rz_active` TEXT NULL,
  `rz_id` TEXT NULL,
  `rz_key` TEXT NULL,
  `stripe_active` TEXT NULL,
  `teleappid` VARCHAR(255) NULL,
  `telehash` VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: web_public (19 columns)
CREATE TABLE IF NOT EXISTS `web_public` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `app_name` VARCHAR(255) NULL,
  `broadcast_screen_tutorial` TEXT NULL,
  `chatbot_screen_tutorial` TEXT NULL,
  `currency_code` TEXT NULL,
  `currency_symbol` TEXT NULL,
  `custom_home` TEXT NULL,
  `exchange_rate` TEXT NULL,
  `fb_login_active` TEXT NULL,
  `fb_login_app_id` TEXT NULL,
  `fb_login_app_sec` TEXT NULL,
  `google_client_id` TEXT NULL,
  `google_login_active` TEXT NULL,
  `home_page_tutorial` TEXT NULL,
  `is_custom_home` TINYINT(1) NULL DEFAULT 0,
  `login_header_footer` TEXT NULL,
  `logo` VARCHAR(500) NULL,
  `meta_description` TEXT NULL,
  `rtl` VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: manual_payment_methods (admin-managed EasyPaisa/JazzCash/Bank accounts)
CREATE TABLE IF NOT EXISTS `manual_payment_methods` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `method_type` VARCHAR(50) NOT NULL,
  `account_title` VARCHAR(255) NULL,
  `account_number` VARCHAR(100) NULL,
  `bank_name` VARCHAR(255) NULL,
  `iban` VARCHAR(50) NULL,
  `instructions` TEXT NULL,
  `is_active` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  KEY `idx_method_type` (`method_type`),
  KEY `idx_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: manual_payment_submissions (user payment proofs for admin verification)
CREATE TABLE IF NOT EXISTS `manual_payment_submissions` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `uid` VARCHAR(255) NULL,
  `plan_id` INT NULL,
  `amount` DECIMAL(10,2) NULL,
  `method_type` VARCHAR(50) NULL,
  `method_details` TEXT NULL,
  `screenshot` VARCHAR(500) NULL,
  `transaction_id` VARCHAR(255) NULL,
  `sender_account` VARCHAR(255) NULL,
  `status` VARCHAR(20) NULL DEFAULT 'pending',
  `admin_note` TEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  KEY `idx_uid` (`uid`),
  KEY `idx_status` (`status`),
  KEY `idx_plan_id` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
