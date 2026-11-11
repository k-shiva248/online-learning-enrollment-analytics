
CREATE OR REFRESH MATERIALIZED VIEW silver_enrollments_clean AS

WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY enrollment_id
               ORDER BY enrollment_id
           ) AS rn
    FROM bronze_course_enrollments
),

cleaned AS (
    SELECT
        enrollment_id,
        learner_id,
        LOWER(TRIM(learner_email)) AS learner_email,

        COALESCE(
            NULLIF(INITCAP(TRIM(learner_city)), ''),
            'Unknown'
        ) AS learner_city,

        age_group,
        course_id,
        course_name,

        COALESCE(
            NULLIF(INITCAP(TRIM(category)), ''),
            'Unknown'
        ) AS category,

        INITCAP(TRIM(course_level)) AS course_level,
        instructor_name,
        enrollment_date,

        INITCAP(TRIM(enrollment_channel))
            AS enrollment_channel,

        list_price,
        discount_amount,

        COALESCE(
            price_paid,
            list_price - discount_amount
        ) AS price_paid,

        payment_method,
        progress_pct,
        hours_watched,
        course_rating,
        certificate_issued

    FROM ranked
    WHERE rn = 1
)

SELECT *,
    CASE
        WHEN progress_pct = 100 THEN 'Completed'
        WHEN progress_pct > 0 THEN 'In Progress'
        ELSE 'Not Started'
    END AS learner_status

FROM cleaned

WHERE progress_pct BETWEEN 0 AND 100
  AND price_paid >= 0;
