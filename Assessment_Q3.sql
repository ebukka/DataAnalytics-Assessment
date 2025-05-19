-- Drop view if it already exists to avoid conflict
DROP VIEW IF EXISTS inactive_accounts;

-- Create view to identify customers with both savings and investment plans
CREATE VIEW inactive_accounts AS

-- Savings accounts with no inflows in last 1 year
SELECT 
    s.id AS plan_id,
    s.owner_id,
    'Savings' AS type,
    s.transaction_date AS last_transaction_date,
    DATEDIFF(CURDATE(), s.transaction_date) AS inactivity_days
FROM savings_savingsaccount s
WHERE s.confirmed_amount > 0
  AND s.transaction_date < DATE_SUB(CURDATE(), INTERVAL 365 DAY)

UNION

-- Investment plans with no activity in last 1 year
SELECT 
    p.id AS plan_id,
    p.owner_id,
    'Investment' AS type,
    p.created_on AS last_transaction_date,
    DATEDIFF(CURDATE(), p.created_on) AS inactivity_days
FROM plans_plan p
WHERE p.amount > 0
  AND p.created_on < DATE_SUB(CURDATE(), INTERVAL 365 DAY)
  AND p.is_deleted = 0
  AND p.is_archived = 0
  AND p.is_donation_plan = 0
  AND p.is_a_wallet = 0;
