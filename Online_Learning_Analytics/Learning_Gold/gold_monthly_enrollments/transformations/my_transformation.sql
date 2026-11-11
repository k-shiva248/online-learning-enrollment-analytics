
CREATE OR REFRESH MATERIALIZED VIEW gold_monthly_enrollments AS

SELECT
    DATE_TRUNC('MONTH', enrollment_date) AS enrollment_month,

    COUNT(*) AS enrollments,

    COUNT(DISTINCT learner_email) AS unique_learners,

    SUM(price_paid) AS revenue,

    SUM(
        CASE
            WHEN learner_status = 'Completed' THEN 1
            ELSE 0
        END
    ) AS completions,

    SUM(hours_watched) AS hours_watched

FROM silver_enrollments_clean

GROUP BY DATE_TRUNC('MONTH', enrollment_date);
