DROP VIEW IF EXISTS transaction_frequency;

CREATE VIEW transaction_frequency AS
SELECT 
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    u.email,
    COUNT(s.id) AS total_transactions,

    -- Calculate average transactions per month
    ROUND(COUNT(s.id) / 
        (TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)) + 1), 2
    ) AS avg_txn_per_month,

    -- Categorize transaction frequency
    CASE
        WHEN ROUND(COUNT(s.id) / (TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)) + 1), 2) >= 10 THEN 'High Frequency'
        WHEN ROUND(COUNT(s.id) / (TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)) + 1), 2) BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category

FROM users_customuser u
JOIN savings_savingsaccount s ON u.id = s.owner_id
GROUP BY u.id
ORDER BY avg_txn_per_month DESC;
