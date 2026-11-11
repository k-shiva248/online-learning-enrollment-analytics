# Online Learning Enrollment Analytics

## Project Overview

This project develops an end-to-end Online Learning Enrollment Analytics Platform using Databricks and Lakeflow Spark Declarative Pipelines.

The project transforms raw course enrollment data into clean, reliable and business-ready datasets using Medallion Architecture (Bronze, Silver and Gold).

The final output is an interactive Databricks AI/BI dashboard that provides insights into enrollments, revenue, course performance, learner activity and data quality.

## Business Objectives

- Analyze monthly course enrollment trends.
- Monitor revenue and course performance.
- Identify popular course categories.
- Analyze enrollment channels.
- Track learner completion status.
- Identify duplicate and invalid records.
- Improve data quality and reporting accuracy.

## Technologies Used

- Databricks
- Databricks SQL
- Lakeflow Spark Declarative Pipelines
- Unity Catalog
- Medallion Architecture
- Databricks AI/BI Dashboards

## Dataset

The project uses a synthetic online learning enrollment dataset containing 1,283 rows and 20 columns.

The dataset includes learner information, course details, enrollment dates, payment information, progress percentages and ratings.

## Project Architecture

### 1. Bronze Layer

- Ingested raw CSV data from Unity Catalog Volume.
- Preserved original source data.
- Added source filename and load timestamp.

Table: `bronze_course_enrollments`

### 2. Silver Layer

- Removed duplicate enrollment records.
- Standardized text columns.
- Cleaned learner email addresses.
- Handled missing values.
- Validated prices and progress percentages.
- Created learner status.
- Separated rejected records.

Tables:
- `silver_enrollments_clean`
- `silver_enrollments_rejected`

### 3. Gold Layer

Created business-ready summary tables:

- `gold_monthly_enrollments`
- `gold_category_summary`
- `gold_course_summary`
- `gold_channel_summary`
- `gold_data_quality`

## Dashboard

Created a three-page Databricks AI/BI Dashboard.

1. Overview – Enrollment trends, revenue, completions and learner activity.
2. Courses & Channels – Course performance, ratings, category analysis and enrollment channels.
3. Data Quality – Bronze, clean and rejected records, duplicates and reconciliation.

## Data Quality

Performed validation checks for:
- Duplicate enrollment IDs.
- Missing values.
- Invalid progress percentages.
- Negative prices.
- Email standardization.
- Record reconciliation.

## Project Outcome

Developed an end-to-end data pipeline that transforms raw enrollment data into business-ready analytical datasets and interactive dashboards.

The project demonstrates practical knowledge of SQL, Databricks, ETL pipelines, data transformation, data validation and analytics.

## Author

Shiva Prasad

GitHub: https://github.com/k-shiva248
