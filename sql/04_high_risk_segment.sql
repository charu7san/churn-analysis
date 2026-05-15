SELECT 
    Contract,
    CASE 
        WHEN tenure BETWEEN 0 AND 6  THEN '0-6 mo'
        WHEN tenure BETWEEN 7 AND 12 THEN '7-12 mo'
        ELSE '13+ mo'
    END AS tenure_bucket,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 1) AS churn_rate_pct
FROM customers
WHERE Contract = 'Month-to-month'
GROUP BY tenure_bucket
ORDER BY churn_rate_pct DESC;