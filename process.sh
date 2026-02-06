#!/bin/bash

# 1. Define where the data lives and where it's going
RAW_DATA="public/trips.parquet"
ZONES_DATA="public/zones.csv"
OUTPUT_DIR="src/data"

# Ensure the output directory exists
mkdir -p $OUTPUT_DIR

echo "Starting NYC Taxi Data Pipeline..."

# CASE STUDY 1: The Temporal Pulse
# Goal: Count trips by hour to see when the city is busiest.
echo "Processing Case Study 1..."
duckdb -c "
COPY (
    SELECT 
        hour(tpep_pickup_datetime) AS hour, 
        count(*) AS trip_count
    FROM '$RAW_DATA' 
    GROUP BY 1 
    ORDER BY 1
) TO '$OUTPUT_DIR/temporal_pulse.json' (FORMAT JSON, ARRAY true);
"

# CASE STUDY 2: [Your future SQL here]
# echo "Processing Case Study 2..."
# duckdb -c "COPY (...) TO '$OUTPUT_DIR/case_study_2.json' (FORMAT JSON, ARRAY true);"

echo "All data exported to $OUTPUT_DIR"