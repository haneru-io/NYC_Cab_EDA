-- Case Study 1: The Temporal Pulse
-- Goal: Count trips by hour of day to see when the city is busiest.
--
-- Placeholders ({{RAW_DATA}}, {{OUT_FILE}}) are substituted by process.sh
-- at build time. For browser/DuckDB-Wasm use, substitute them client-side
-- (or replace the COPY ... TO with a plain SELECT and read the result set).

COPY (
    SELECT
        hour(tpep_pickup_datetime) AS hour,
        count(*) AS trip_count
    FROM '{{RAW_DATA}}'
    WHERE
        -- SAFETY CHECK: Only keep data from Jan 2025
        tpep_pickup_datetime >= '2025-01-01'
        AND tpep_pickup_datetime < '2025-02-01'
    GROUP BY hour
    ORDER BY hour
) TO '{{OUT_FILE}}' (FORMAT JSON, ARRAY true);
