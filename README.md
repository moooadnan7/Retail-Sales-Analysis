# Retail Sales Analysis - SQL Project

## Overview
This project showcases essential SQL skills used by data analysts to explore, clean, and analyze retail sales data. It involves setting up a database, performing exploratory data analysis (EDA), and answering business-related questions.

---

## Objectives
1. **Database Setup:** Create and populate a retail sales database.
2. **Data Cleaning:** Identify and remove records with missing or null values.
3. **Exploratory Data Analysis (EDA):** Gain insights into the dataset.
4. **Business Analysis:** Derive insights by answering business questions using SQL.

---

## Project Structure

### 1. Database Setup
Create the database and table:

```sql
CREATE DATABASE p1_retail_db;

USE p1_retail_db;

CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

#### **Count the total number of records:**
```sql
SELECT COUNT(*) FROM retail_sales;
```

#### **Count the number of unique customers:**
```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```

#### **List all unique product categories:**
```sql
SELECT DISTINCT category FROM retail_sales;
```

#### **Check for null values:**
```sql
SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

#### **Delete records with null values:**
```sql
DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

---

### 3. Business Analysis & Insights

#### **Retrieve all sales made on '2022-11-05':**
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

#### **Find all 'Clothing' transactions in November 2022 where quantity sold > 4:**
```sql
SELECT *
FROM retail_sales
WHERE 
    category = 'Clothing' AND 
    FORMAT(sale_date, 'yyyy-MM') = '2022-11' AND 
    quantity > 4;
```

#### **Calculate total sales for each category:**
```sql
SELECT 
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

#### **Find the average age of customers purchasing 'Beauty' items:**
```sql
SELECT 
    ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

#### **Retrieve transactions where the total sale exceeds 1000:**
```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

#### **Find total transactions by gender in each category:**
```sql
SELECT 
    category,
    gender,
    COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

#### **Calculate the average sales per month and find the best-selling month for each year:**
```sql
WITH monthly_sales AS (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT year, month, avg_sale
FROM monthly_sales
WHERE rank = 1;
```

#### **Find the top 5 customers based on total sales:**
```sql
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

#### **Count unique customers for each category:**
```sql
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

#### **Categorize sales by shifts and count orders in each shift:**
```sql
WITH hourly_sales AS (
    SELECT *,
        CASE
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift;
```

---

## Findings
1. **Customer Demographics:** Customers from various age groups contributed to sales in categories such as 'Clothing' and 'Beauty.'
2. **High-Value Transactions:** Many transactions exceeded $1000, indicating premium purchases.
3. **Sales Trends:** Monthly trends help identify peak seasons.
4. **Customer Insights:** Top-spending customers and popular product categories were identified.

---

## How to Use
1. Clone this repository.
2. Set up the database by executing the SQL scripts provided.
3. Run the queries to explore the dataset and derive insights.
4. Modify queries to analyze additional patterns or answer new questions.
