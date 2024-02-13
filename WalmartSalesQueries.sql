-- --------------------------- Feature Engineering ---------------------------

-- Time of day

SELECT
    [Time],
    (CASE
        WHEN [Time] BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN [Time] BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END
    ) AS 'Time of day'  
FROM
    WalmartSalesData

-- Add the Time_of_day and values --

ALTER TABLE WalmartSalesData ADD Time_of_day VARCHAR(20)

UPDATE WalmartSalesData
SET Time_of_day = (
                CASE
                    WHEN [Time] BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
                    WHEN [Time] BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
                    ELSE 'Evening'
                END
                )   


-- Day name

SELECT
    [Date],
    DATENAME(WEEKDAY,[Date]) AS Day_name
FROM
    WalmartSalesData

-- Add Day name and values

ALTER TABLE WalmartSalesData ADD Day_name VARCHAR(10)

UPDATE WalmartSalesData
SET Day_name = DATENAME(WEEKDAY,[Date])


-- Month name

SELECT
    [Date],
    DATENAME(MONTH,[Date]) AS Month_name
FROM
    WalmartSalesData

-- Add Month name and values

ALTER TABLE WalmartSalesData ADD Month_name VARCHAR(10)

UPDATE WalmartSalesData
SET Month_name = DATENAME(MONTH,[Date])





-- --------------------------- Generic Questions ---------------------------

-- How many unique cities does the data have?

SELECT
    DISTINCT City
FROM
    WalmartSalesData

-- In which city is each branch?

SELECT
    DISTINCT City,
             Branch
FROM
    WalmartSalesData





-- --------------------------- Product Questions ---------------------------

-- How many unique product lines does the data have?

SELECT
    COUNT(Product_line)
FROM
    WalmartSalesData

-- What is the most common payment method?

SELECT
    [Payment_method],
    COUNT(Payment_method) AS Payments
FROM
    WalmartSalesData
GROUP BY
    Payment_method
ORDER BY
    Payments DESC

-- What is the most selling product line?

SELECT
    [Product_line],
    COUNT(Product_line) AS Sales
FROM
    WalmartSalesData
GROUP BY
    Product_line
ORDER BY
    Sales DESC

-- What is the total revenue by month?

SELECT 
    Month_name AS Month,
    SUM(Total) AS Total_Revenue
FROM
    WalmartSalesData
GROUP BY
   Month_name
ORDER BY
    Total_Revenue DESC

-- What month had the largest COGS?

SELECT 
    Month_name AS Month,
    SUM(COGS) AS Total_COGS
FROM
    WalmartSalesData
GROUP BY
   Month_name
ORDER BY
    Total_COGS DESC

-- What product line had the largest revenue?

SELECT 
    Product_line,
    SUM(Total) AS Total_Revenue
FROM
    WalmartSalesData
GROUP BY
   Product_line
ORDER BY
    Total_Revenue DESC

-- What is the city with the largest revenue?

SELECT 
    Branch,
    City,
    SUM(Total) AS Total_Revenue
FROM
    WalmartSalesData
GROUP BY
   City, Branch
ORDER BY
    Total_Revenue DESC

-- What product line had the largest VAT?

SELECT 
    Product_line,
    AVG(VAT) AS AVG_VAT
FROM
    WalmartSalesData
GROUP BY
   Product_line
ORDER BY
    AVG_VAT DESC

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

SELECT
    (SUM(Total)/COUNT(DISTINCT Product_line)) 
FROM
    WalmartSalesData

SELECT 
    Product_line       
FROM 
    WalmartSalesData 
GROUP BY
   Product_line
 

-- Which branch sold more products than average product sold?

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

-- What is the most common product line by gender?

SELECT
    Gender,
    Product_line,
    COUNT(Gender) AS total_cnt
FROM
    WalmartSalesData
GROUP BY
    Gender, Product_line
ORDER BY
    total_cnt DESC

-- What is the average rating of each product line?

SELECT
    ROUND(AVG(Rating), 2) AS AVG_Rating,
    Product_line
FROM
    WalmartSalesData
GROUP BY 
    Product_line
ORDER BY 
    AVG_Rating DESC





-- --------------------------- Sales Questions ---------------------------

-- Number of sales made in each time of the day per weekday

SELECT
    Time_of_day,
    COUNT(Invoice_ID) AS Total_sales
FROM
    WalmartSalesData
WHERE 
    Day_name = 'Tuesday'
GROUP BY
    Time_of_day
ORDER BY
    Total_sales DESC

-- Which of the customer types brings the most revenue?

SELECT
    Customer_type,
    SUM(Total) AS Total_revenue
FROM
    WalmartSalesData
GROUP BY
    Customer_type
ORDER BY
    Total_revenue DESC

-- Which city has the largest tax percent/ VAT (Value Added Tax)?

SELECT
    City,
    AVG(VAT) AS VAT
FROM
    WalmartSalesData
GROUP BY
    City
ORDER BY 
    VAT DESC

-- Which customer type pays the most in VAT?

SELECT
    Customer_type,
    AVG(VAT) AS VAT
FROM
    WalmartSalesData
GROUP BY
    Customer_type
ORDER BY 
    VAT DESC





-- --------------------------- Customer Questions ---------------------------

-- How many unique customer types does the data have and which one has the most customers?

SELECT
 DISTINCT Customer_type,
 COUNT(Customer_type) AS No_of_customers
FROM
    WalmartSalesData
GROUP BY
    Customer_type
ORDER BY
    No_of_customers DESC

-- How many unique payment methods does the data have and which one is used the most?

SELECT
 DISTINCT Payment_method,
 COUNT(Payment_method) AS No_of_payments
FROM
    WalmartSalesData
GROUP BY
    Payment_method
ORDER BY
    No_of_payments DESC

-- What is the gender of most of the customers?

SELECT
    Gender,
    COUNT(Gender) as Customer_count
FROM
    WalmartSalesData
GROUP BY
    Gender
ORDER BY
    Customer_count DESC

-- What is the gender distribution per branch?

SELECT
    Gender,
    COUNT(Gender) as Customer_count
FROM
    WalmartSalesData
WHERE
    Branch = 'C'
GROUP BY
    Gender
ORDER BY
    Customer_count DESC

-- Which time of the day do customers give most ratings?

SELECT
    Time_of_day,
    COUNT(Rating) AS No_of_ratings
FROM
    WalmartSalesData
GROUP BY
    Time_of_day
ORDER BY
    No_of_ratings DESC

-- Which time of the day do customers give most ratings per branch?

SELECT
    Time_of_day,
    COUNT(Rating) AS No_of_ratings
FROM
    WalmartSalesData
WHERE
    Branch = 'A'
GROUP BY
    Time_of_day
ORDER BY
    No_of_ratings DESC

-- Which day fo the week has the best avg rating?

SELECT
    Day_name,
    AVG(Rating) AS Avg_rating
FROM
    WalmartSalesData
GROUP BY
    Day_name
ORDER BY
    Avg_rating DESC

-- Which day of the week has the best average ratings per branch?

SELECT
    Day_name,
    AVG(Rating) AS Avg_rating
FROM
    WalmartSalesData
WHERE
    Branch = 'C'
GROUP BY
    Day_name
ORDER BY
    Avg_rating DESC