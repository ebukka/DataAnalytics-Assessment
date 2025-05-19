{\rtf1\ansi\ansicpg1252\cocoartf2709
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- Drop view if it already exists to avoid conflict\
DROP VIEW IF EXISTS clv_estimation;\
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0
\cf0 \
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0
\cf0 -- Create view to identify customers with both savings and investment plans\
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0
\cf0 CREATE VIEW clv_estimation AS\
SELECT \
    u.id AS customer_id,\
    CONCAT(u.first_name, ' ', u.last_name) AS name,\
    -- Convert tenure to months\
    ROUND(DATEDIFF(CURDATE(), u.date_joined) / 30, 2) AS tenure_months,\
\
    -- Count total transactions per customer\
    COUNT(s.id) AS total_transactions,\
\
    -- Compute CLV using simplified model\
    ROUND(((COUNT(s.id) / (DATEDIFF(CURDATE(), u.date_joined) / 30)) * 12 * \
          (SUM(s.confirmed_amount) * 0.001 / COUNT(s.id))), 2) AS estimated_clv\
FROM users_customuser u\
JOIN savings_savingsaccount s ON u.id = s.owner_id\
WHERE s.confirmed_amount > 0\
GROUP BY u.id\
HAVING tenure_months > 0\
ORDER BY estimated_clv DESC;}