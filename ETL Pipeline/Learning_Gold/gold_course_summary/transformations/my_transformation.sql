
CREATE OR REFRESH MATERIALIZED VIEW gold_course_summary AS

SELECT
    category,
    course_name,
    course_level,
    instructor_name,

    COUNT(*) AS enrollments,

    SUM(price_paid) AS revenue,

    ROUND(
        SUM(CASE
            WHEN learner_status = 'Completed'
            THEN 1 ELSE 0
        END) * 100.0 / COUNT(*), 2
    ) AS completion_rate_pct,

    AVG(course_rating) AS avg_rating,

    SUM(hours_watched) AS hours_watched

FROM silver_enrollments_clean

GROUP BY
    category,
    course_name,
    course_level,
    instructor_name;
