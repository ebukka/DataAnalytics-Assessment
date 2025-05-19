-- Drop view if it already exists to avoid conflict
DROP VIEW IF EXISTS clv_estimation;

-- Create view to identify customers with both savings and investment plans
CREATE VIEW clv_estimation AS

SELECT 
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    -- Convert tenure to months
    ROUND(DATEDIFF(CURDATE(), u.date_joined) / 30, 2) AS tenure_months,

    -- Count total transactions per customer
    COUNT(s.id) AS total_transactions,

    -- Compute CLV using simplified model
    ROUND(((COUNT(s.id) / (DATEDIFF(CURDATE(), u.date_joined) / 30)) * 12 * 
          (SUM(s.confirmed_amount) * 0.001 / COUNT(s.id))), 2) AS estimated_clv
FROM users_customuser u
JOIN savings_savingsaccount s ON u.id = s.owner_id
WHERE s.confirmed_amount > 0
GROUP BY u.id
HAVING tenure_months > 0
ORDER BY estimated_clv DESC;
