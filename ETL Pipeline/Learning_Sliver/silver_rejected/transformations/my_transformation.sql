
CREATE OR REFRESH MATERIALIZED VIEW
silver_enrollments_rejected AS

SELECT *,
    CASE
        WHEN progress_pct < 0 OR progress_pct > 100
            THEN 'Progress is outside 0 to 100'

        WHEN price_paid < 0
            THEN 'Price paid is negative'
    END AS reject_reason

FROM bronze_course_enrollments

WHERE progress_pct < 0
   OR progress_pct > 100
   OR price_paid < 0;
