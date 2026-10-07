/**
 * Manual Payment Gateway for WhatsCRM (Pakistan)
 * ------------------------------------------------
 * Allows users to pay via EasyPaisa / JazzCash / Bank transfer and upload
 * a payment screenshot. Admin verifies submissions from the admin panel
 * and approves/rejects them. On approval the user's plan is activated.
 *
 * Tables used (see guide/whatscrm-schema.sql):
 *   - manual_payment_methods     (admin-managed receiving accounts)
 *   - manual_payment_submissions (user payment proofs)
 *   - orders                     (order record on approval)
 *   - plan / user                (plan activation via updateUserPlan)
 */

const express = require("express");
const router = express.Router();
const path = require("path");
const fs = require("fs");
const randomstring = require("randomstring");

const { query } = require("../database/dbpromise.js");
const adminValidator = require("../middlewares/admin.js");
const validateUser = require("../middlewares/user.js");
const { getFileExtension, updateUserPlan } = require("../functions/function.js");

// Allowed payment method types
const METHOD_TYPES = ["easypaisa", "jazzcash", "bank"];
// Allowed screenshot extensions and max size (5 MB)
const ALLOWED_EXT = ["jpg", "jpeg", "png"];
const MAX_SCREENSHOT_SIZE = 5 * 1024 * 1024;

/* ============================================================
 * ADMIN ROUTES
 * ============================================================ */

// List all payment methods (admin)
router.get(
  "/admin/manual_payment_methods",
  adminValidator,
  async (req, res) => {
    try {
      const methods = await query(
        `SELECT * FROM manual_payment_methods ORDER BY id DESC`,
        []
      );
      res.json({ success: true, data: methods });
    } catch (err) {
      console.log(err);
      res.json({ success: false, msg: "server error" });
    }
  }
);

// Create or update a payment method (admin)
// body: { id?, method_type, account_title, account_number, bank_name?, iban?, instructions?, is_active? }
router.post(
  "/admin/manual_payment_method",
  adminValidator,
  async (req, res) => {
    try {
      const {
        id,
        method_type,
        account_title,
        account_number,
        bank_name,
        iban,
        instructions,
        is_active,
      } = req.body;

      if (!method_type || !METHOD_TYPES.includes(method_type)) {
        return res.json({
          success: false,
          msg: "Invalid method_type. Use: easypaisa, jazzcash, bank",
        });
      }
      if (!account_title || !account_number) {
        return res.json({
          success: false,
          msg: "account_title and account_number are required",
        });
      }

      const active = is_active === undefined ? 1 : is_active ? 1 : 0;

      if (id) {
        // Update existing
        await query(
          `UPDATE manual_payment_methods
           SET method_type = ?, account_title = ?, account_number = ?,
               bank_name = ?, iban = ?, instructions = ?, is_active = ?,
               updated_at = NOW()
           WHERE id = ?`,
          [
            method_type,
            account_title,
            account_number,
            bank_name || null,
            iban || null,
            instructions || null,
            active,
            id,
          ]
        );
        return res.json({ success: true, msg: "Payment method updated" });
      }

      // Create new
      const result = await query(
        `INSERT INTO manual_payment_methods
         (method_type, account_title, account_number, bank_name, iban, instructions, is_active, created_at, updated_at)
         VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), NOW())`,
        [
          method_type,
          account_title,
          account_number,
          bank_name || null,
          iban || null,
          instructions || null,
          active,
        ]
      );
      res.json({
        success: true,
        msg: "Payment method added",
        id: result.insertId,
      });
    } catch (err) {
      console.log(err);
      res.json({ success: false, msg: "server error" });
    }
  }
);

// Delete a payment method (admin)
router.delete(
  "/admin/manual_payment_method/:id",
  adminValidator,
  async (req, res) => {
    try {
      await query(`DELETE FROM manual_payment_methods WHERE id = ?`, [
        req.params.id,
      ]);
      res.json({ success: true, msg: "Payment method deleted" });
    } catch (err) {
      console.log(err);
      res.json({ success: false, msg: "server error" });
    }
  }
);

// List all payment submissions with user email + plan title (admin)
router.get(
  "/admin/manual_payment_submissions",
  adminValidator,
  async (req, res) => {
    try {
      const rows = await query(
        `SELECT s.*, u.email AS user_email, p.title AS plan_title
         FROM manual_payment_submissions s
         LEFT JOIN user u ON u.uid = s.uid
         LEFT JOIN plan p ON p.id = s.plan_id
         ORDER BY s.created_at DESC`,
        []
      );
      res.json({ success: true, data: rows });
    } catch (err) {
      console.log(err);
      res.json({ success: false, msg: "server error" });
    }
  }
);

// Approve a submission: mark approved, activate plan, record order (admin)
router.post(
  "/admin/manual_payment_submission/:id/approve",
  adminValidator,
  async (req, res) => {
    try {
      const { id } = req.params;

      const rows = await query(
        `SELECT * FROM manual_payment_submissions WHERE id = ?`,
        [id]
      );
      if (rows.length < 1) {
        return res.json({ success: false, msg: "Submission not found" });
      }
      const submission = rows[0];
      if (submission.status === "approved") {
        return res.json({ success: false, msg: "Already approved" });
      }

      // Mark approved
      await query(
        `UPDATE manual_payment_submissions
         SET status = 'approved', admin_note = NULL, updated_at = NOW()
         WHERE id = ?`,
        [id]
      );

      // Activate the user's plan
      const plans = await query(`SELECT * FROM plan WHERE id = ?`, [
        submission.plan_id,
      ]);
      if (plans.length > 0) {
        await updateUserPlan(plans[0], submission.uid);
      }

      // Record the order
      const orderRef = `MANUAL_${randomstring.generate()}`;
      await query(
        `INSERT INTO orders (uid, payment_mode, amount, data) VALUES (?, ?, ?, ?)`,
        [submission.uid, "MANUAL", submission.amount, orderRef]
      );

      res.json({ success: true, msg: "Payment approved, plan activated" });
    } catch (err) {
      console.log(err);
      res.json({ success: false, msg: "server error" });
    }
  }
);

// Reject a submission with an admin note (admin)
router.post(
  "/admin/manual_payment_submission/:id/reject",
  adminValidator,
  async (req, res) => {
    try {
      const { id } = req.params;
      const { admin_note } = req.body;

      const rows = await query(
        `SELECT * FROM manual_payment_submissions WHERE id = ?`,
        [id]
      );
      if (rows.length < 1) {
        return res.json({ success: false, msg: "Submission not found" });
      }

      await query(
        `UPDATE manual_payment_submissions
         SET status = 'rejected', admin_note = ?, updated_at = NOW()
         WHERE id = ?`,
        [admin_note || null, id]
      );

      res.json({ success: true, msg: "Payment rejected" });
    } catch (err) {
      console.log(err);
      res.json({ success: false, msg: "server error" });
    }
  }
);

/* ============================================================
 * USER ROUTES
 * ============================================================ */

// List active payment methods (user)
router.get("/manual_payment_methods", validateUser, async (req, res) => {
  try {
    const methods = await query(
      `SELECT id, method_type, account_title, account_number, bank_name, iban, instructions
       FROM manual_payment_methods
       WHERE is_active = 1
       ORDER BY id ASC`,
      []
    );
    res.json({ success: true, data: methods });
  } catch (err) {
    console.log(err);
    res.json({ success: false, msg: "server error" });
  }
});

// Submit a manual payment with screenshot proof (user)
// multipart form: plan_id, method_type, transaction_id?, sender_account?, screenshot (file, required)
router.post("/submit_manual_payment", validateUser, async (req, res) => {
  try {
    const { plan_id, method_type, transaction_id, sender_account } = req.body;

    if (!plan_id) {
      return res.json({ success: false, msg: "plan_id is required" });
    }
    if (!method_type || !METHOD_TYPES.includes(method_type)) {
      return res.json({
        success: false,
        msg: "Invalid method_type. Use: easypaisa, jazzcash, bank",
      });
    }

    // Screenshot is required
    if (!req.files || !req.files.screenshot) {
      return res.json({
        success: false,
        msg: "Payment screenshot is required",
      });
    }
    const file = req.files.screenshot;
    const ext = getFileExtension(file.name);
    if (!ALLOWED_EXT.includes(ext)) {
      return res.json({
        success: false,
        msg: "Screenshot must be jpg, jpeg or png",
      });
    }
    if (file.size > MAX_SCREENSHOT_SIZE) {
      return res.json({
        success: false,
        msg: "Screenshot must be smaller than 5MB",
      });
    }

    // Verify the plan exists and get its price
    const plans = await query(`SELECT * FROM plan WHERE id = ?`, [plan_id]);
    if (plans.length < 1) {
      return res.json({ success: false, msg: "Invalid plan_id" });
    }
    const plan = plans[0];

    // Snapshot the chosen method's account details at time of payment
    const methods = await query(
      `SELECT method_type, account_title, account_number, bank_name, iban
       FROM manual_payment_methods
       WHERE method_type = ? AND is_active = 1
       ORDER BY id ASC LIMIT 1`,
      [method_type]
    );
    const methodDetails =
      methods.length > 0 ? JSON.stringify(methods[0]) : null;

    // Save the screenshot
    const filename = `pay_${randomstring.generate()}.${ext}`;
    const dest = path.join(
      __dirname,
      "..",
      "client",
      "public",
      "media",
      filename
    );
    await new Promise((resolve, reject) => {
      file.mv(dest, (err) => (err ? reject(err) : resolve()));
    });

    // Record the submission as pending
    await query(
      `INSERT INTO manual_payment_submissions
       (uid, plan_id, amount, method_type, method_details, screenshot, transaction_id, sender_account, status, created_at, updated_at)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'pending', NOW(), NOW())`,
      [
        req.decode.uid,
        plan_id,
        plan.price || plan.amount || 0,
        method_type,
        methodDetails,
        filename,
        transaction_id || null,
        sender_account || null,
      ]
    );

    res.json({
      success: true,
      msg: "Payment submitted. Admin will verify your screenshot shortly.",
    });
  } catch (err) {
    console.log(err);
    res.json({ success: false, msg: "server error" });
  }
});

// List current user's own submissions with plan title (user)
router.get("/my_payment_submissions", validateUser, async (req, res) => {
  try {
    const rows = await query(
      `SELECT s.*, p.title AS plan_title
       FROM manual_payment_submissions s
       LEFT JOIN plan p ON p.id = s.plan_id
       WHERE s.uid = ?
       ORDER BY s.created_at DESC`,
      [req.decode.uid]
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    console.log(err);
    res.json({ success: false, msg: "server error" });
  }
});

module.exports = router;
