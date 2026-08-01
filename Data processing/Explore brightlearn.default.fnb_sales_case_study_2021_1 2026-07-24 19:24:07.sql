-- Databricks notebook source
--- Checking all columns and values
SELECT * 
FROM `brightlearn`.`default`.`fnb_sales_case_study_2021_1`;

---Checking duplicates in all columns. 
SELECT COUNT(*) AS total_count,
COUNT(DISTINCT `Date`) AS duplicate_date,
COUNT(DISTINCT Sales) AS duplicate_sales,
COUNT(DISTINCT `Cost Of Sales`) AS duplicate_cost_of_sales,
COUNT(DISTINCT `Quantity Sold`) AS duplicate_qty
FROM `brightlearn`.`default`.`fnb_sales_case_study_2021_1`;

--- Checking null values 
SELECT *
FROM `brightlearn`.`default`.`fnb_sales_case_study_2021_1`
WHERE `Date` IS NULL
   OR Sales IS NULL
   OR `Cost Of Sales` IS NULL
   OR `Quantity Sold` IS NULL;

--- Checking the highest,lowest and average Quantity sold
SELECT 
MAX(`Quantity Sold`) AS highest_quantity,
MIN(`Quantity Sold`) AS lowest_quantity,
AVG(ROUND(`Quantity Sold`, 2)) AS Average_quantity,
MAX(ROUND(`Cost of Sales`, 2)) AS highest_of_Sales
FROM `brightlearn`.`default`.`fnb_sales_case_study_2021_1`;

--- Checking the month and daynames
SELECT 
Date,
MONTHNAME(`Date`) AS Month_name,
DAYNAME(`Date`) AS Day_name,
HOUR(`Date`) AS hour_of_the_day
FROM `brightlearn`.`default`.`fnb_sales_case_study_2021_1`;

--- Rounding of cost of sales and sales into two decimals
SELECT
    Date,
    ROUND(Sales, 2) AS Sales,
    ROUND(`Cost of Sales`, 2) AS Cost_of_Sales,
    `Quantity Sold`
FROM `brightlearn`.`default`.`fnb_sales_case_study_2021_1`;

--- Check Max,min and avg of quantity sold.
SELECT
Date,
MONTHNAME(`Date`) AS Month_name,
DAYNAME(`Date`) AS Day_name,
HOUR(`Date`) AS hour_of_the_day,
ROUND(Sales, 2) AS Sales,
ROUND(`Cost of Sales`, 2) AS Cost_of_Sales,
MAX(`Quantity Sold`) AS highest_quantity,
MIN(`Quantity Sold`) AS lowest_quantity,
AVG(`Quantity Sold`) AS Average_quantity
FROM `brightlearn`.`default`.`fnb_sales_case_study_2021_1`
GROUP BY Date, Sales, `Cost of Sales`;
-----Check Monthname and Dayname. Hour of day, Max,min and average quantity sold.
SELECT
    Date,
    MONTHNAME(Date) AS Month_name,
    DAYNAME(Date) AS Day_name,
    HOUR(Date) AS Hour_of_the_day,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(`Cost of Sales`), 2) AS Total_Cost_of_Sales,
    MAX(`Quantity Sold`) AS Highest_Quantity,
    MIN(`Quantity Sold`) AS Lowest_Quantity,
    ROUND(AVG(`Quantity Sold`), 2) AS Average_Quantity
FROM `brightlearn`.`default`.`fnb_sales_case_study_2021_1`
GROUP BY
    Date,
    MONTHNAME(Date),
    DAYNAME(Date),
    HOUR(Date)
ORDER BY Date;
------Cast to force change from 10 into two decimals.
SELECT
    MAX(`Quantity Sold`) AS Highest_Quantity,
    MIN(`Quantity Sold`) AS Lowest_Quantity,
    CAST(ROUND(AVG(`Quantity Sold`), 2) AS DECIMAL(10,2)) AS Average_Quantity,
    CAST(MAX(`Cost of Sales`) AS DECIMAL(10,2)) AS Highest_Cost_of_Sales,
    CAST(MIN(`Cost of Sales`) AS DECIMAL(10,2)) AS Lowest_Cost_of_Sales,
    CAST(AVG(`Cost of Sales`) AS DECIMAL(10,2)) AS Average_Cost_of_Sales   

FROM `brightlearn`.`default`.`fnb_sales_case_study_2021_1`;
--------------------------------------------------------------------------------------------------------------
SELECT
--- Check sales----
    Sales,`Quantity Sold`,`Cost of Sales`,
    CASE
        WHEN Sales < 5000 THEN 'Low Sales'
        WHEN Sales BETWEEN 5000 AND 10000 THEN 'Medium Sales'
        ELSE 'High Sales'
    END AS Sales_Category,
    ------Check quantity sold-------
    CASE
        WHEN `Quantity Sold` < 50 THEN 'Low Demand'
        WHEN `Quantity Sold` BETWEEN 50 AND 100 THEN 'Moderate Demand'
        ELSE 'High Demand'
    END AS Demand_Level,
------ Check profit catergory------------
    (Sales - `Cost of Sales`) AS Gross_Profit,
    CASE
        WHEN (Sales - `Cost of Sales`) < 1000 THEN 'Low Profit'
        WHEN (Sales - `Cost of Sales`) BETWEEN 1000 AND 5000 THEN 'Medium Profit'
        ELSE 'High Profit'
    END AS Profit_Category,
    ROUND(((Sales - `Cost of Sales`) / Sales) * 100, 2) AS Profit_Margin,
    --- Check the cost of sales margin--------
    CASE
        WHEN ((Sales - `Cost of Sales`) / Sales) * 100 < 20 THEN 'Low Margin'
        WHEN ((Sales - `Cost of Sales`) / Sales) * 100 BETWEEN 20 AND 40 THEN 'Average Margin'
        ELSE 'High Margin'
    END AS Margin_Category,
    DAYNAME(Date) AS Day_Name,
   ----Check Weekdays and Weekends-----
    CASE
        WHEN DAYNAME(Date) IN (1,7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Type,
    --- Check Quarters in a year-------
    CASE
        WHEN MONTH(Date) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN MONTH(Date) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN MONTH(Date) BETWEEN 7 AND 9 THEN 'Q3'
        ELSE 'Q4'
    END AS Quarter,
    --- Check Season-------------------------------
    CASE
        WHEN MONTH(Date) IN (12, 1, 2) THEN 'Summer'
        WHEN MONTH(Date) IN (3, 4, 5) THEN 'Autumn'
        WHEN MONTH(Date) IN (6, 7, 8) THEN 'Winter'
        ELSE 'Spring'
    END AS Season,
    --- Check Cost Efficiency-----------------------
    Sales,
    `Cost of Sales`,
    CASE
        WHEN `Cost of Sales` / Sales < 0.50 THEN 'Highly Efficient'
        WHEN `Cost of Sales` / Sales < 0.75 THEN 'Moderately Efficient'
        ELSE 'Needs Improvement'
    END AS Cost_Efficiency
FROM `brightlearn`.`default`.`fnb_sales_case_study_2021_1`;
--------------------------------------------------------------------------------------------------------------
--- Combination of the above mentioned case statements.
SELECT
    CAST(Sales AS DECIMAL(10,2)) AS Sales,
    `Quantity Sold`,
    CAST(`Cost of Sales` AS DECIMAL(10,2)) AS Cost_of_Sales,

    CASE
        WHEN Sales < 5000 THEN 'Low Sales'
        WHEN Sales BETWEEN 5000 AND 10000 THEN 'Medium Sales'
        ELSE 'High Sales'
    END AS Sales_Category,

    CASE
        WHEN `Quantity Sold` < 50 THEN 'Low Demand'
        WHEN `Quantity Sold` BETWEEN 50 AND 100 THEN 'Moderate Demand'
        ELSE 'High Demand'
    END AS Demand_Level,

    CAST((Sales - `Cost of Sales`) AS DECIMAL(10,2)) AS Gross_Profit,

    CASE
        WHEN (Sales - `Cost of Sales`) < 1000 THEN 'Low Profit'
        WHEN (Sales - `Cost of Sales`) BETWEEN 1000 AND 5000 THEN 'Medium Profit'
        ELSE 'High Profit'
    END AS Profit_Category,

    CAST(((Sales - `Cost of Sales`) / Sales) * 100 AS DECIMAL(10,2)) AS Profit_Margin,

    CASE
        WHEN ((Sales - `Cost of Sales`) / Sales) * 100 < 20 THEN 'Low Margin'
        WHEN ((Sales - `Cost of Sales`) / Sales) * 100 BETWEEN 20 AND 40 THEN 'Average Margin'
        ELSE 'High Margin'
    END AS Margin_Category,

    DAYNAME(Date) AS Day_Name,

    CASE
        WHEN DAYNAME(Date) IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Type,

    CASE
        WHEN MONTH(Date) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN MONTH(Date) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN MONTH(Date) BETWEEN 7 AND 9 THEN 'Q3'
        ELSE 'Q4'
    END AS Quarter,

    CASE
        WHEN MONTH(Date) IN (12, 1, 2) THEN 'Summer'
        WHEN MONTH(Date) IN (3, 4, 5) THEN 'Autumn'
        WHEN MONTH(Date) IN (6, 7, 8) THEN 'Winter'
        ELSE 'Spring'
    END AS Season,

    CASE
        WHEN `Cost of Sales` / Sales < 0.50 THEN 'Highly Efficient'
        WHEN `Cost of Sales` / Sales < 0.75 THEN 'Moderately Efficient'
        ELSE 'Needs Improvement'
    END AS Cost_Efficiency

FROM `brightlearn`.`default`.`fnb_sales_case_study_2021_1`;
-------------------------------------------------------------------------------------------------------------
--- Final code
SELECT `Quantity Sold`,
CAST(Sales AS DECIMAL (10,2)) AS Sales,
CAST(Sales / `Quantity Sold` AS DECIMAL(10,2)) AS Daily_Sales_Price_Per_Unit,
CAST((Sales - `Cost of Sales`) / Sales * 100 AS DECIMAL(10,2)) AS daily_gross_profit,
CAST((Sales - `Cost of Sales`) / `Quantity Sold` AS DECIMAL(10,2)) AS Gross_Profit_Per_Unit,
CAST((((Sales - `Cost of Sales`) / `Quantity Sold`)/(Sales / `Quantity Sold`)) * 100 AS DECIMAL(10,2)) AS Gross_Profit_Per_Unit_Percent,
CAST(`Cost of Sales` / `Quantity Sold` AS DECIMAL(10,2)) AS Cost_Per_Unit,
CAST(((Sales - `Cost of Sales`) / `Cost of Sales`) * 100 AS DECIMAL(10,2)) AS Markup_Percentage,
 CAST(AVG(Sales / `Quantity Sold`) OVER () AS DECIMAL(10,2)) AS Average_Unit_Sales_Price,
 MONTHNAME(`Date`) AS Month_name,
DAYNAME(`Date`) AS Day_name,
 CASE
        WHEN Sales < 5000 THEN 'Low Sales'
        WHEN Sales BETWEEN 5000 AND 10000 THEN 'Medium Sales'
        ELSE 'High Sales'
    END AS Sales_Category,
    CASE
        WHEN DAYNAME(Date) IN (1,7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Type,
    CASE
        WHEN MONTH(Date) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN MONTH(Date) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN MONTH(Date) BETWEEN 7 AND 9 THEN 'Q3'
        ELSE 'Q4'
    END AS Quarter,
    CASE
        WHEN MONTH(Date) IN (12, 1, 2) THEN 'Summer'
        WHEN MONTH(Date) IN (3, 4, 5) THEN 'Autumn'
        WHEN MONTH(Date) IN (6, 7, 8) THEN 'Winter'
        ELSE 'Spring'
    END AS Season,
    
END AS PromotionFlag
FROM `brightlearn`.`default`.`fnb_sales_case_study_2021_1`;