
CREATE OR REFRESH MATERIALIZED VIEW gold_category_summary AS

SELECT
    category,

    COUNT(*) AS enrollments,

    SUM(price_paid) AS revenue,

    SUM(CASE
        WHEN learner_status = 'Completed'
        THEN 1 ELSE 0
    END) AS completed,

    SUM(CASE
        WHEN learner_status = 'In Progress'
        THEN 1 ELSE 0
    END) AS in_progress,

    SUM(CASE
        WHEN learner_status = 'Not Started'
        THEN 1 ELSE 0
    END) AS not_started,

    ROUND(
        SUM(CASE
            WHEN learner_status = 'Completed'
            THEN 1 ELSE 0
        END) * 100.0 / COUNT(*), 2
    ) AS completion_rate_pct,

    AVG(progress_pct) AS avg_progress_pct

FROM silver_enrollments_clean

GROUP BY category;
