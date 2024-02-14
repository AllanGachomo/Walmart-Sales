# Data Analyst Portfolio Project - Walmart Sales SQL

## Introduction

This project is designed to delve into Walmart's sales data, aiming to gain insights into the performance of various branches and products, understand sales trends, and analyze customer behavior. 

The ultimate goal is to study and enhance sales strategies. The dataset utilized in this analysis is sourced from the Kaggle Walmart Sales Forecasting Competition.

## Project Purpose

The primary objective of this project is to gain a comprehensive understanding of Walmart's sales data, focusing on factors influencing sales across different branches.

## About the Data

The dataset, obtained from the Kaggle Walmart Sales Forecasting Competition, includes sales transactions from three Walmart branches located in Mandalay, Yangon, and Naypyitaw. The dataset comprises 17 columns and 1000 rows:
| Column | Description | Data Type |
| --- | --- | --- |
| Invoice_ID | Invoice of the sales made | VARCHAR(30) |
| Branch | Branch at which sales were made | VARCHAR(5) |
| City | The location of the branch | VARCHAR(30) |
| Customer_type | The type of the customer | VARCHAR(30) |
| Gender | Gender of the customer making purchase | VARCHAR(10) |
| Product_line | Product line of the product solf | VARCHAR(100) |
| Unit_price | The price of each product | DECIMAL(10, 2) |
| Quantity | The amount of the product sold | INT |
| VAT | The amount of tax on the purchase | FLOAT |
| Total | The total cost of the purchase | DECIMAL(12, 4) |
| Date | The date on which the purchase was made | DATETIME |
| Time | The time at which the purchase was made | TIME |
| Payment_method | The total amount paid | VARCHAR(15) |
| COGS | Cost Of Goods sold | DECIMAL(10, 2) |
| Gross_margin_percentage | Gross margin percentage | FLOAT |
| Gross_income | Gross Income | DECIMAL(12, 4) |
| Rating | Rating | DECIMAL(10, 2) |

## Analysis List 

**1. Product Analysis**
- Conduct an in-depth analysis to understand different product lines, identify top-performing product lines, and highlight areas for improvement.

**2. Sales Analysis**
- Investigate sales trends to assess the effectiveness of each sales strategy, providing insights for necessary modifications to enhance sales performance.

**3. Customer Analysis**
- Uncover distinct customer segments, analyze purchase trends, and evaluate the profitability of each customer segment.

## Approach Used

**1. Data Wrangling:**
- Build a database
- Insert data.
- Utilize data replacement methods for handling missing or NULL values. There were no null values since we set NOT NULL for each data field in the SQL Server Management Studio while importing data

**2. Feature Engineering:**
- Introduce new columns like "time_of_day" to categorize sales into morning, afternoon, and evening.
- Introduce "day_name" to extract the day of the week for understanding branch activity.
- Introduce "month_name" to analyze monthly sales and profit trends.
- 
**3. Exploratory Data Analysis:**
Perform EDA to address project objectives and questions.

## Business Questions To Answer:

Below are a few examples of the questions answered in the query wiht their respective code. The rest can be found in the in the SQL file in the repository.

**Generic**
- How many unique cities does the data have?
- In which city is each branch?
```
SELECT
    DISTINCT City,
             Branch
FROM
    WalmartSalesData
```

**Product**
- How many unique product lines does the data have?
- What is the most common payment method?
- What is the most selling product line?
- What is the total revenue by month?
- What month had the largest COGS?
- What product line had the largest revenue?
- What is the city with the largest revenue?
- What product line had the largest VAT?
- Which branch sold more products than average product sold?
```
SELECT
    Branch,
    SUM(Quantity) AS QTY
FROM
    WalmartSalesData
GROUP BY
    Branch
HAVING SUM(Quantity) > (SELECT 
                            (SUM(Quantity)/COUNT(DISTINCT Branch))   
                        FROM 
                            WalmartSalesData)
```

This project was completed with the guidance of Code With Prince's Youtube videos.
