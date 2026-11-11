
CREATE OR REFRESH MATERIALIZED VIEW gold_channel_summary AS

SELECT
    enrollment_channel,

    COUNT(*) AS enrollments,

    SUM(price_paid) AS revenue,

    ROUND(
        SUM(CASE
            WHEN learner_status = 'Completed'
            THEN 1 ELSE 0
        END) * 100.0 / COUNT(*), 2
    ) AS completion_rate_pct

FROM silver_enrollments_clean

GROUP BY enrollment_channel;
