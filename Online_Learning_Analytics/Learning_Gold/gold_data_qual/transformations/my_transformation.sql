
CREATE OR REFRESH MATERIALIZED VIEW gold_data_quality AS

WITH bronze_stats AS (
    SELECT
        COUNT(*) AS bronze_rows,

        COUNT(*) - COUNT(DISTINCT enrollment_id)
            AS duplicate_rows,

        SUM(CASE
            WHEN progress_pct < 0 OR progress_pct > 100
            THEN 1 ELSE 0
        END) AS invalid_progress_rows,

        SUM(CASE
            WHEN price_paid < 0
            THEN 1 ELSE 0
        END) AS negative_price_rows,

        SUM(CASE
            WHEN category IS NULL OR TRIM(category) = ''
            THEN 1 ELSE 0
        END) AS missing_category_rows,

        SUM(CASE
            WHEN learner_city IS NULL OR TRIM(learner_city) = ''
            THEN 1 ELSE 0
        END) AS missing_city_rows,

        SUM(CASE
            WHEN price_paid IS NULL
            THEN 1 ELSE 0
        END) AS missing_price_rows,

        COUNT(DISTINCT learner_email)
            AS learners_before_email_fix,

        COUNT(DISTINCT LOWER(TRIM(learner_email)))
            AS learners_after_email_fix

    FROM bronze_course_enrollments
),

silver_stats AS (
    SELECT COUNT(*) AS clean_rows
    FROM silver_enrollments_clean
),

rejected_stats AS (
    SELECT COUNT(*) AS rejected_rows
    FROM silver_enrollments_rejected
)

SELECT
    b.*,
    s.clean_rows,
    r.rejected_rows,

    b.duplicate_rows + s.clean_rows + r.rejected_rows
        AS accounted_rows,

    CASE
        WHEN b.bronze_rows =
             b.duplicate_rows + s.clean_rows + r.rejected_rows
        THEN 'Passed'
        ELSE 'Failed'
    END AS reconciliation_status

FROM bronze_stats b
CROSS JOIN silver_stats s
CROSS JOIN rejected_stats r;
