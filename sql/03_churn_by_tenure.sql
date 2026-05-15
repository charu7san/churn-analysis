SELECT 
    CASE 
        WHEN tenure BETWEEN 0 AND 6   THEN '0-6 mo'
        WHEN tenure BETWEEN 7 AND 12  THEN '7-12 mo'
        WHEN tenure BETWEEN 13 AND 24 THEN '13-24 mo'
        WHEN tenure BETWEEN 25 AND 48 THEN '25-48 mo'
        ELSE '49-72 mo'
    END AS tenure_bucket,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 1) AS churn_rate_pct
FROM customers
GROUP BY tenure_bucket
ORDER BY churn_rate_pct DESC;