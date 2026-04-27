#!/bin/bash
#
# NYC Taxi Data Pipeline
# ----------------------
# Reads each .sql file in queries/, substitutes path placeholders, and pipes
# the result into the DuckDB CLI to produce JSON files in src/data/.
#
# Convention: queries/<name>.sql -> src/data/<name>.json

set -euo pipefail

# Paths (relative to repo root)
RAW_DATA="public/trips.parquet"
ZONES_DATA="public/zones.csv"
OUTPUT_DIR="src/data"
QUERY_DIR="queries"

mkdir -p "$OUTPUT_DIR"

# run_query <name>
#   Reads queries/<name>.sql, substitutes {{...}} placeholders, pipes to duckdb.
#   Writes src/data/<name>.json (the COPY ... TO target inside the SQL).
run_query() {
    local name="$1"
    local sql_file="$QUERY_DIR/${name}.sql"
    local out_file="$OUTPUT_DIR/${name}.json"

    if [[ ! -f "$sql_file" ]]; then
        echo "  ✗ missing $sql_file — skipping"
        return 1
    fi

    echo "→ ${name}"
    sed -e "s|{{RAW_DATA}}|${RAW_DATA}|g" \
        -e "s|{{ZONES_DATA}}|${ZONES_DATA}|g" \
        -e "s|{{OUT_FILE}}|${out_file}|g" \
        "$sql_file" | duckdb
}

echo "Starting NYC Taxi Data Pipeline..."

run_query "temporal_pulse"

# Pending — uncomment once queries/generosity_clock.sql is filled in:
# run_query "generosity_clock"

echo "All data exported to $OUTPUT_DIR"
