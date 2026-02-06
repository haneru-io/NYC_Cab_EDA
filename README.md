# 🚕 NYC Taxi Trip Analysis (EDA)

A high-performance Exploratory Data Analysis of the NYC Taxi & Limousine Commission (TLC) dataset. This project uses **DuckDB** for lightning-fast analytical queries and **Astro** for a zero-JS-overhead presentation.

## 📊 Project Highlights

- **Engine:** DuckDB (Processing 1M+ rows in milliseconds)
- **Frontend:** Astro (Static Site Generation)
- **Visuals:** Vega-Lite (Declarative data visualizations)
- **Data Source:** [NYC TLC Trip Record Data](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page)

## 🔍 Case Studies

1. **Temporal Pulse:** Hourly demand patterns across NYC.
2. **Tip Culture:** Correlation between payment types and gratuity.
3. **Airport Premium:** Analysis of JFK/LGA flat-rate efficiency.
   ... (Add others as you build them)

## 🛠️ Tech Stack & Architecture

- **SQL:** All data transformations are done via DuckDB CLI and exported to JSON.
- **Automation:** A shell script handles the data pipeline from Parquet to Site.
- **Deployment:** Hosted on Netlify.

## 🚀 Local Development

1. Clone the repo.
2. Place the TLC Parquet file in `/public`.
3. Run `./process_data.sh` to generate the analytical JSON files.
4. Run `npm run dev` to start the dashboard.
