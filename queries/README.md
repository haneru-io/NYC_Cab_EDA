# Queries

One `.sql` file per case study. Each file is consumed by `process.sh` (build-time
DuckDB CLI) and — eventually — by the in-browser DuckDB-Wasm component.

## Placeholders

Queries use `{{TOKEN}}` placeholders for paths so they're not hardcoded:

| Placeholder      | Meaning                                | Example                         |
| ---------------- | -------------------------------------- | ------------------------------- |
| `{{RAW_DATA}}`   | The trips parquet                      | `public/trips.parquet`          |
| `{{ZONES_DATA}}` | The TLC zone lookup CSV                | `public/zones.csv`              |
| `{{OUT_FILE}}`   | Where the JSON result should be written | `src/data/temporal_pulse.json` |

`process.sh` substitutes these before piping the SQL into the `duckdb` CLI.

## Convention

The output filename mirrors the query filename:
`queries/temporal_pulse.sql` → `src/data/temporal_pulse.json`.

To add a new case study: drop `queries/<name>.sql` in this folder and add
`run_query "<name>"` to `process.sh`.
