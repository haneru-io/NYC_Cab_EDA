-- Case Study 2: The Generosity Clock
-- Goal: Average tip percentage by hour of day.
--
-- TODO: fill in the SELECT. Sketch:
--   tip_pct = tip_amount / NULLIF(fare_amount, 0) * 100
--   filter to credit-card payments (payment_type = 1) since cash tips
--   aren't reliably recorded.
--
-- Placeholders ({{RAW_DATA}}, {{OUT_FILE}}) are substituted by process.sh.

COPY (
    SELECT
        hour(tpep_pickup_datetime) AS hour,
        -- TODO: avg tip_pct here
        NULL AS avg_tip_pct
    FROM '{{RAW_DATA}}'
    WHERE
        tpep_pickup_datetime >= '2025-01-01'
        AND tpep_pickup_datetime < '2025-02-01'
    GROUP BY hour
    ORDER BY hour
) TO '{{OUT_FILE}}' (FORMAT JSON, ARRAY true);
