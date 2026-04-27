-- Case Study 2: The Generosity Clock
-- Goal: Average tip percentage by hour of day — does NYC tip more at 3am than 3pm?
--
-- Notes
--   * payment_type = 1  -> credit card. We exclude cash trips because cash
--     tips aren't recorded by the meter (tip_amount is always 0 for cash).
--   * tip_amount / fare_amount captures tip-on-fare (industry convention).
--     We use AVG of the ratio (mean of per-trip tip rates) rather than
--     SUM(tip)/SUM(fare) — the question is "does the average rider tip
--     more at this hour", not "what's the aggregate tip pool".
--   * We also return sample_size so a thin bar at low-volume hours is
--     visible in the chart.
--
-- Placeholders ({{RAW_DATA}}, {{OUT_FILE}}) are substituted by process.sh.

COPY (
    SELECT
        hour(tpep_pickup_datetime) AS hour,
        ROUND(AVG(tip_amount / fare_amount) * 100, 2) AS avg_tip_pct,
        COUNT(*) AS sample_size
    FROM '{{RAW_DATA}}'
    WHERE
        tpep_pickup_datetime >= '2025-01-01'
        AND tpep_pickup_datetime < '2025-02-01'
        AND payment_type = 1   -- credit card only
        AND fare_amount > 0    -- avoid divide-by-zero on voided/free rides
        AND tip_amount >= 0    -- defensive: drop any negative tip rows
    GROUP BY hour
    ORDER BY hour
) TO '{{OUT_FILE}}' (FORMAT JSON, ARRAY true);
