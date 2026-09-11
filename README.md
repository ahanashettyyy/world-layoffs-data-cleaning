# World Layoffs — SQL Data Cleaning & Exploratory Data Analysis

## 📊 Project Overview

This project performs an end-to-end **data cleaning and exploratory data analysis (EDA)** workflow on a global layoffs dataset using **MySQL**.

The project begins with preparing a raw layoffs dataset for analysis by removing duplicate records, standardizing inconsistent fields, handling missing values, and creating a clean staging dataset. The cleaned data is then explored to identify patterns across companies, industries, countries, funding stages, and time periods.

The goal is to demonstrate how SQL can be used not only to clean messy real-world data, but also to transform it into **business-relevant insights for decision-making and analysis**.

---

## 🎯 Objectives

* Clean and prepare raw layoffs data for reliable analysis
* Identify and remove duplicate records
* Standardize company, industry, country, and date fields
* Handle NULL and blank values
* Analyze layoffs across different business dimensions
* Identify companies and industries with the highest layoffs
* Analyze layoffs by country and time period
* Examine companies with complete workforce reductions
* Compare layoffs with funding raised
* Calculate cumulative layoffs over time
* Rank companies based on yearly layoffs

---

## 🛠️ Tools & Technologies

* **MySQL**
* SQL
* Common Table Expressions (CTEs)
* Window Functions
* `ROW_NUMBER()`
* `DENSE_RANK()`
* `PARTITION BY`
* Aggregate Functions
* Date Functions
* Data Transformation & Cleaning

---

## 📁 Dataset

The project uses a global layoffs dataset containing information such as:

* Company
* Location
* Industry
* Total Laid Off
* Percentage Laid Off
* Date
* Country
* Funding Raised
* Company Stage

The dataset contains **2,361 records** used as the basis for the cleaning workflow.

---

# 🔄 Project Workflow

## 1. Data Cleaning

The raw dataset was first copied into staging tables to preserve the original data and provide a controlled environment for transformations.

### Duplicate Detection & Removal

Duplicate records were identified using:

* `ROW_NUMBER()`
* `PARTITION BY`
* Window Functions
* CTEs

This allowed records to be grouped according to relevant attributes and duplicate rows to be identified systematically.

### Data Standardization

Inconsistent values were standardized across important categorical fields, including:

* Company names
* Industry
* Country
* Date fields

### Missing Value Handling

NULL and blank values were investigated and handled using SQL transformations and joins where appropriate.

The final cleaned dataset was stored in a staging table and used as the input for exploratory analysis.

---

# 🔎 Exploratory Data Analysis

After cleaning the dataset, SQL was used to investigate patterns and trends in global layoffs.

### Overall Layoff Analysis

The analysis examined:

* Maximum number of employees laid off in a single record
* Maximum percentage of workforce laid off
* Companies experiencing complete workforce reductions

### Company Analysis

Companies were grouped and compared based on their total number of layoffs.

This helps identify organizations that contributed the largest number of layoffs within the dataset.

### Industry Analysis

Layoffs were aggregated by industry to understand which sectors experienced the largest overall workforce reductions.

### Country Analysis

The dataset was grouped by country to compare the overall scale of layoffs geographically.

### Time-Based Analysis

Layoffs were analyzed by:

* Year
* Month
* Monthly totals

This provides a view of how layoffs changed over time and helps identify periods of higher layoff activity.

### Company Stage Analysis

Layoffs were also analyzed according to company stage to investigate how workforce reductions were distributed across different stages of company growth and development.

---

# 📈 Advanced SQL Analysis

## Rolling Layoff Total

A monthly layoffs dataset was created and a **cumulative rolling total** was calculated using a window function.

```sql
SUM(total_off) OVER (ORDER BY month)
```

This provides a cumulative view of layoffs as the timeline progresses.

---

## Yearly Company Ranking

Companies were grouped by year and total layoffs.

A `DENSE_RANK()` window function was then used to rank companies within each year.

```sql
DENSE_RANK() OVER (
    PARTITION BY years
    ORDER BY total_laid_off DESC
)
```

The analysis was used to identify the **top five companies by layoffs for each year**.

---

## 💡 Business Questions Explored

The project uses SQL to answer questions such as:

1. Which companies recorded the highest total layoffs?
2. Which industries experienced the largest number of layoffs?
3. Which countries recorded the highest layoffs?
4. How did layoffs change across different years and months?
5. Which companies experienced complete workforce reductions?
6. How do layoffs compare with the amount of funding raised?
7. Which company stages recorded the highest layoffs?
8. What are the top five companies by layoffs in each year?
9. How does the cumulative number of layoffs change over time?

---

## 🧠 Key SQL Concepts Demonstrated

### Data Cleaning

* Staging tables
* Duplicate detection
* NULL handling
* Blank value handling
* String standardization
* Date transformation

### Data Analysis

* `GROUP BY`
* `ORDER BY`
* `WHERE`
* Aggregate functions
* Date functions
* Conditional filtering

### Advanced SQL

* CTEs
* Self joins
* Window functions
* `ROW_NUMBER()`
* `DENSE_RANK()`
* `PARTITION BY`
* Rolling totals

---

## 📂 Project Structure

```text
World-Layoffs-SQL-Analysis/
│
├── Data Cleaning.sql
├── Exploratory Data Analysis.sql
└── README.md
```

The **Data Cleaning** workflow prepares the dataset, while the **Exploratory Data Analysis** workflow uses the cleaned staging table for further analysis.

---

## 📌 Project Takeaway

This project demonstrates an end-to-end SQL analytics workflow:

**Raw Data → Data Cleaning → Data Transformation → Exploratory Analysis → Advanced SQL Analysis → Business Insights**

Rather than directly analyzing an unclean dataset, the project focuses on building a reliable analytical dataset first and then using SQL to investigate trends, comparisons, rankings, and patterns.

The project demonstrates practical SQL skills relevant to **Data Analyst and Business Analyst roles**, particularly in data preparation, exploratory analysis, reporting, and business-oriented problem solving.

---

## 👩‍💻 Skills Demonstrated

**SQL | MySQL | Data Cleaning | Exploratory Data Analysis | Data Transformation | CTEs | Window Functions | Business Analysis | Data-Driven Problem Solving**


