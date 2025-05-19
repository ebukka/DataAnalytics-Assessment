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

**Goal:**  
Identify customers who have at least one **funded savings** plan and one **funded investment** plan. Results are sorted by total deposit amount.

**Approach:**  
- Filter savings accounts with `confirmed_amount > 0` and `is_regular_savings = 1`
- Filter investment plans with `amount > 0`, excluding deleted, archived, donation, and wallet-based plans
- Join with `users_customuser` on customer ID
- Aggregate count and sum for both product types and calculate total deposits

**Challenges:**  
- Filtering out non-eligible investment plans based on multiple boolean flags  
- Ensuring customers exist in **both** datasets (savings and investments) using inner joins  
- Preventing null sums by applying filters before aggregation

---

### `Assessment_Q2.sql` – Transaction Frequency Analysis

**Goal:**  
Segment customers based on how frequently they transact.

**Approach:**  
- Join `users_customuser` and `savings_savingsaccount` by user ID  
- Count total savings transactions per user  
- Calculate average monthly transactions using `TIMESTAMPDIFF`  
- Categorize users as:
  - High (≥10/month)
  - Medium (3–9/month)
  - Low (≤2/month)

**Challenges:**  
- Ensuring correct month span calculation even when first and last transaction are in the same month  
- Avoiding division by zero by padding `+1` to the denominator  
- Accurate classification using rounded average transactions

---

### `Assessment_Q3.sql` – Account Inactivity Alert

**Goal:**  
Identify active savings and investment accounts with **no inflow** for over **365 days**.

**Approach:**  
- Filter savings accounts with `confirmed_amount > 0` and transaction date older than 1 year  
- Filter valid investment plans with `amount > 0`, created over a year ago and not marked as deleted, archived, donation, or wallet  
- Return type (savings/investment), plan ID, user ID, and inactivity duration in days

**Challenges:**  
- Choosing the correct date field to reflect last transaction (e.g., `transaction_date` vs. `created_on`)  
- Unifying output schema from two distinct sources (`savings` and `investments`) using `UNION`  
- Avoiding inclusion of inactive, deleted, or special-type plans

---

### `Assessment_Q4.sql` – Customer Lifetime Value (CLV) Estimation

**Goal:**  
Estimate each customer's CLV using a simplified profit model:  
`CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_transaction`

**Approach:**  
- Calculate each customer’s tenure in months using `DATEDIFF`  
- Count confirmed savings transactions and compute their average value  
- Use 0.1% of transaction value as average profit  
- Multiply by annualized transaction rate to estimate CLV

**Challenges:**  
- Preventing division by zero for very recent customers (ensured `tenure_months > 0`)  
- Maintaining precision with `ROUND()` while handling monetary values  
- Balancing simplicity and realism in a business-usable CLV model

---

## 📤 Submission Instructions

- Repository: [https://github.com/your-username/DataAnalytics-Assessment](https://github.com/ebukka/DataAnalytics-Assessment)
- All files are committed as per instructions
- SQL queries are formatted, commented, and clearly organized

---

