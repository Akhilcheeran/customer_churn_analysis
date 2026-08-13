SELECT * FROM customer_churn LIMIT 10;
-- 1. Baseline Metrics & MRR Loss
SELECT 
    COUNT(customerid) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerid), 2
    ) AS churn_rate_pct,
    ROUND(SUM(monthlycharges)::numeric, 2) AS total_mrr,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN monthlycharges ELSE 0 END)::numeric, 2) AS lost_mrr
FROM customer_churn;

-- 2. Churn Rate & Lost MRR by Contract & Tenure Cohort
WITH cohort_summary AS (
    SELECT 
        contract,
        tenure_cohort,
        COUNT(customerid) AS total_accounts,
        SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_accounts,
        ROUND(SUM(CASE WHEN churn = 'Yes' THEN monthlycharges ELSE 0 END)::numeric, 2) AS cohort_lost_mrr
    FROM customer_churn
    GROUP BY contract, tenure_cohort
)
SELECT 
    contract,
    tenure_cohort,
    total_accounts,
    churned_accounts,
    ROUND(100.0 * churned_accounts / total_accounts, 2) AS churn_rate_pct,
    cohort_lost_mrr
FROM cohort_summary
ORDER BY cohort_lost_mrr DESC;

-- 3. Top High-Value Accounts at Immediate Churn Risk
WITH risk_ranking AS (
    SELECT 
        customerid,
        contract,
        monthlycharges,
        tenure,
        risk_segment,
        DENSE_RANK() OVER (ORDER BY monthlycharges DESC) AS revenue_rank
    FROM customer_churn
    WHERE churn = 'No' AND risk_segment = 'High Risk'
)
SELECT 
    revenue_rank,
    customerid,
    contract,
    monthlycharges AS mrr,
    tenure,
    risk_segment
FROM risk_ranking
WHERE revenue_rank <= 10;

-- 4. Churn Rate by Service Complexity Score
SELECT 
    service_count,
    COUNT(customerid) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerid), 2
    ) AS churn_rate_pct,
    ROUND(AVG(monthlycharges)::numeric, 2) AS avg_monthly_charge
FROM customer_churn
GROUP BY service_count
ORDER BY service_count ASC;