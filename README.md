# DataAnalytics-Assessment

Welcome to the SQL Proficiency Assessment. This repository contains my solutions to the SQL tasks provided as part of the Data Analyst technical evaluation. The assessment evaluates the ability to extract meaningful insights from relational data using SQL.

---

## 📋 Assessment Overview

You are provided with a database containing the following tables:

- `users_customuser`: Customer demographic and contact information.
- `savings_savingsaccount`: Records of savings transactions.
- `plans_plan`: Records of customer investment and savings plans.
- `withdrawals_withdrawal`: Records of withdrawal transactions.

---

## ✅ Evaluation Criteria

Each query has been written with attention to:

- **Accuracy** – Ensuring correct results
- **Efficiency** – Writing optimal, performant queries
- **Completeness** – Fully addressing each business requirement
- **Readability** – Using consistent formatting and comments where necessary

---

## 🗂 Repository Structure

DataAnalytics-Assessment/
│
├── Assessment_Q1.sql # High-Value Customers with Multiple Products
├── Assessment_Q2.sql # Transaction Frequency Analysis
├── Assessment_Q3.sql # Account Inactivity Alert
├── Assessment_Q4.sql # Customer Lifetime Value (CLV) Estimation
└── README.md

---

## 📌 SQL File Requirements

- Each SQL file includes a **single query** with clear formatting and inline comments where needed.
- File names follow the required `Assessment_Q#.sql` structure.

---

## 🧠 Per-Question Explanation

### `Assessment_Q1.sql` – High-Value Customers with Multiple Products

**Goal:** Identify customers who have at least one **funded savings** plan and one **funded investment** plan. Results are sorted by total deposit amount.  
**Approach:**  
- Filter savings accounts with `confirmed_amount > 0` and `is_regular_savings = 1`
- Filter investment plans with `confirmed_amount > 0` and `is_a_fund = 1`
- Join with `users_customuser` and aggregate totals.

---

### `Assessment_Q2.sql` – Transaction Frequency Analysis

**Goal:** Segment customers based on how frequently they transact.  
**Approach:**  
- Count total savings transactions per user per month.
- Calculate average per user.
- Categorize as:
  - High (≥10/month)
  - Medium (3–9/month)
  - Low (≤2/month)

---

### `Assessment_Q3.sql` – Account Inactivity Alert

**Goal:** Identify active savings and investment accounts with **no inflow** for over **365 days**.  
**Approach:**  
- Filter by transaction date using `CURDATE() - last_transaction_date`
- Include only accounts with `confirmed_amount > 0`
- Return type (savings/investment), plan ID, owner, and inactivity duration.

---

### `Assessment_Q4.sql` – Customer Lifetime Value (CLV) Estimation

**Goal:** Estimate each customer's CLV using a simplified profit model:
- `CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_transaction`

**Approach:**  
- Calculate account tenure in months
- Count transactions per user
- Use 0.1% of transaction value as average profit

---

## 🚧 Challenges Faced

- **Full outer joins in MySQL:** MySQL does not support full outer joins natively. I worked around this using `UNION` of `LEFT JOIN` and `RIGHT JOIN`.
- **Duplicate column names:** When using `SELECT *`, I encountered naming conflicts; this was resolved by selecting specific columns or aliasing.
- **Date calculations:** Ensured consistent use of `DATEDIFF()` and `CURDATE()` for accurate date-based computations.

---

## 📤 Submission Instructions

- Repository: [https://github.com/your-username/DataAnalytics-Assessment](https://github.com/ebukka/DataAnalytics-Assessment)
- All files are committed as per instructions
- SQL queries are formatted, commented, and clearly organized

---

## ⚠️ Notes

- All queries are written from scratch and are my own original work.
- 

