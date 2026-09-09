# World Layoffs Data Cleaning & Preparation

## 📌 Project Overview

This project focuses on cleaning and preparing a real-world layoffs
dataset using **MySQL**.

The raw dataset contains duplicate records, inconsistent values, missing
data, blank fields, and incorrectly formatted dates. The goal was to
transform the raw data into a cleaner, analysis-ready dataset while
preserving the original data through staging tables.

------------------------------------------------------------------------

## 🗂️ Dataset

The project uses `layoffs.csv`, containing **2,361 records** of company
layoffs.

### Key fields

-   `company`
-   `location`
-   `industry`
-   `total_laid_off`
-   `percentage_laid_off`
-   `date`
-   `stage`
-   `country`
-   `funds_raised_millions`

The raw dataset is included in this repository as `layoffs.csv`.

------------------------------------------------------------------------

## 🛠️ Tools & Technologies

-   **MySQL 8.x**
-   SQL
-   MySQL Workbench

------------------------------------------------------------------------

## 🔄 Data Cleaning Workflow

### 1. Data Staging

Created staging tables from the original `layoffs` table so that the raw
dataset remained unchanged during the cleaning process.

``` sql
CREATE TABLE layoffs_staging LIKE layoffs;

INSERT INTO layoffs_staging
SELECT * FROM layoffs;
```

### 2. Duplicate Detection & Removal

Used the `ROW_NUMBER()` window function with `PARTITION BY` to identify
duplicate records.

Duplicate records were assigned a `row_num` greater than 1 and
subsequently removed.

**SQL concepts used:**

-   `ROW_NUMBER()`
-   Window Functions
-   `PARTITION BY`
-   CTEs

### 3. Data Standardization

Standardized inconsistent values across the dataset.

#### Company Names

Removed unnecessary leading and trailing whitespace using `TRIM()`.

#### Industry

Standardized variations of cryptocurrency-related industry values to:

`Crypto`

#### Country

Standardized variations of United States entries to:

`United States`

#### Dates

Converted the `date` field from text into a proper MySQL `DATE` datatype
using `STR_TO_DATE()` and `ALTER TABLE`.

### 4. Handling Missing & Blank Values

Identified records containing missing or blank industry values.

Used a **self-join** to populate missing industry values when another
record for the same company contained a valid industry.

Specific known data inconsistencies were also corrected where
appropriate.

### 5. Removing Unusable Records

Removed records where both `total_laid_off` and `percentage_laid_off`
were missing, as these records did not provide useful layoff information
for analysis.

### 6. Final Cleanup

Removed the temporary `row_num` column after duplicate removal and
cleaning was completed.

The resulting table represents the cleaned dataset ready for further
analysis.

------------------------------------------------------------------------

## 🧠 SQL Concepts Demonstrated

-   `SELECT`
-   `CREATE TABLE`
-   `INSERT INTO ... SELECT`
-   `ROW_NUMBER()`
-   Window Functions
-   `PARTITION BY`
-   Common Table Expressions (CTEs)
-   Self Joins
-   `UPDATE ... JOIN`
-   `TRIM()`
-   `LIKE`
-   `STR_TO_DATE()`
-   `ALTER TABLE`
-   `DELETE`
-   `NULL` handling
-   Blank-value handling
-   Data type conversion
-   Staging tables

------------------------------------------------------------------------

## 📁 Repository Structure

``` text
world-layoffs-data-cleaning/
│
├── layoffs.csv
├── data_cleaning.sql
└── README.md
```

### `layoffs.csv`

Raw dataset used as the input for the project.

### `data_cleaning.sql`

SQL script containing the data-cleaning workflow.

### `README.md`

Project documentation explaining the cleaning process and SQL techniques
used.

------------------------------------------------------------------------

## 🎯 Key Learning

This project demonstrates how SQL can be used to take a messy raw
dataset and systematically prepare it for analysis:

**Raw Data → Staging → Duplicate Removal → Standardization → Missing
Value Handling → Final Clean Dataset**

The project provided practical experience with SQL data preparation and
working with real-world messy data.
