-- Case Study 3: Top Pickup Zones
-- Goal: The 20 busiest pickup zones in NYC, by trip count. First step
-- toward zone-level / mapping work down the line.
--
-- Notes
--   * Joins trips to public/zones.csv on PULocationID = LocationID.
--   * read_csv_auto sniffs the header so we can reference Borough/Zone by
--     name rather than positional indexes.
--   * LEFT JOIN keeps trips with unknown zone IDs so the count totals are
--     honest — but we filter NULL zone names out of the final result so we
--     don't render an empty-label row in the chart.
--
-- Placeholders ({{RAW_DATA}}, {{ZONES_DATA}}, {{OUT_FILE}}) are substituted
-- by process.sh.

COPY (
    SELECT
        z.Zone     AS zone_name,
        z.Borough  AS borough,
        COUNT(*)   AS trip_count
    FROM '{{RAW_DATA}}' t
    LEFT JOIN read_csv_auto('{{ZONES_DATA}}') z
        ON t.PULocationID = z.LocationID
    WHERE
        t.tpep_pickup_datetime >= '2025-01-01'
        AND t.tpep_pickup_datetime < '2025-02-01'
        AND z.Zone IS NOT NULL
    GROUP BY z.Zone, z.Borough
    ORDER BY trip_count DESC
    LIMIT 20
) TO '{{OUT_FILE}}' (FORMAT JSON, ARRAY true);
