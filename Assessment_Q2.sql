{\rtf1\ansi\ansicpg1252\cocoartf2709
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- Drop view if it already exists to avoid conflict\
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0
\cf0 DROP VIEW IF EXISTS transaction_frequency;\
\
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0
\cf0 -- Create view to identify customers with both savings and investment plans\
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0
\cf0 CREATE VIEW transaction_frequency AS\
SELECT \
    u.id AS customer_id,\
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,\
    u.email,\
    COUNT(s.id) AS total_transactions,\
\
    -- Calculate average transactions per month\
    ROUND(COUNT(s.id) / \
        (TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)) + 1), 2\
    ) AS avg_txn_per_month,\
\
    -- Categorize transaction frequency\
    CASE\
        WHEN ROUND(COUNT(s.id) / (TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)) + 1), 2) >= 10 THEN 'High Frequency'\
        WHEN ROUND(COUNT(s.id) / (TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)) + 1), 2) BETWEEN 3 AND 9 THEN 'Medium Frequency'\
        ELSE 'Low Frequency'\
    END AS frequency_category\
\
FROM users_customuser u\
JOIN savings_savingsaccount s ON u.id = s.owner_id\
GROUP BY u.id\
ORDER BY avg_txn_per_month DESC;}