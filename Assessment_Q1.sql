-- Drop view if it already exists to avoid conflict
DROP VIEW IF EXISTS high_value_customers;

-- Create view to identify customers with both savings and investment plans
CREATE VIEW high_value_customers AS
SELECT 
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    u.email,
    sa.savings_count,
    pp.investment_count,
    (sa.total_savings + pp.total_investments) AS total_deposits
FROM users_customuser u

-- Subquery to aggregate funded savings accounts per customer
JOIN (
    SELECT 
        owner_id, 
        COUNT(*) AS savings_count,
        SUM(confirmed_amount) AS total_savings
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0  -- Filter only funded savings
    GROUP BY owner_id
) sa ON u.id = sa.owner_id

-- Subquery to aggregate funded investment plans per customer
JOIN (
    SELECT 
        owner_id, 
        COUNT(*) AS investment_count,
        SUM(amount) AS total_investments
    FROM plans_plan
    WHERE 
        amount > 0  -- Only funded investments
        AND is_deleted = 0
        AND is_archived = 0
        AND is_donation_plan = 0
        AND is_a_wallet = 0  -- Exclude non-investment plans
    GROUP BY owner_id
) pp ON u.id = pp.owner_id

-- Sort customers by total deposits in descending order
ORDER BY total_deposits DESC;
