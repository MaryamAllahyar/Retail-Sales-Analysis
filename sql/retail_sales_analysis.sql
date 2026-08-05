/*
Retail Sales Performance Analysis
Author: Maryam Allahyar

Purpose:
Analyze retail sales, profitability, customer behavior,
product performance, regional trends, discounts,
and shipping performance using SQL.

Database: SQLite
Table: retail_sales
*/

-- =========================================================
-- Query 1: Overall Business Performance
-- Business Question:
-- What is the company's overall sales performance, profitability, and customer activity?
-- =========================================================
SELECT
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)
        AS profit_margin_percentage
FROM retail_sales;

-- =========================================================
-- Query 2: Category Performance
-- Business Question:
-- Which product categories generate the highest
-- sales and profits?
-- =========================================================

SELECT
    category,
    ROUND(SUM(sales),2) AS Total_Sales,
    ROUND(SUM(profit),2) AS Total_Profit,
    COUNT(DISTINCT order_id) AS Total_Orders,
    ROUND(SUM(profit)/SUM(sales)*100,2) AS Profit_Margin_Percentage
FROM retail_sales
GROUP BY category
ORDER BY Total_Sales DESC;

-- =========================================================
-- Query 3: Sub-Category Performance
-- Business Question:
-- Which product sub-categories generate the
-- highest sales and profit?
-- =========================================================

SELECT
    sub_category,
    ROUND(SUM(sales),2) AS Total_Sales,
    ROUND(SUM(profit),2) AS Total_Profit
FROM retail_sales
GROUP BY sub_category
ORDER BY Total_Sales DESC;

-- =========================================================
-- Query 4: Top 10 Products
-- Business Question:
-- Which products generate the highest sales?
-- =========================================================

SELECT
    product_name,
    ROUND(SUM(sales),2) AS Total_Sales,
    ROUND(SUM(profit),2) AS Total_Profit,
    SUM(quantity) AS Total_Quantity
FROM retail_sales
GROUP BY product_name
ORDER BY Total_Sales DESC
LIMIT 10;

-- =========================================================
-- Query 5: Bottom 10 Products
-- Business Question:
-- Which products have the lowest profitability?
-- =========================================================

SELECT
    product_name,
    ROUND(SUM(sales),2) AS Total_Sales,
    ROUND(SUM(profit),2) AS Total_Profit
FROM retail_sales
GROUP BY product_name
ORDER BY Total_Profit ASC
LIMIT 10;

-- =========================================================
-- Query 6: Regional Performance
-- Business Question:
-- How does sales performance vary across regions?
-- =========================================================

SELECT
    region,
    ROUND(SUM(sales),2) AS Total_Sales,
    ROUND(SUM(profit),2) AS Total_Profit,
    COUNT(DISTINCT order_id) AS Total_Orders,
    ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AS Average_Order_Value
FROM retail_sales
GROUP BY region
ORDER BY Total_Sales DESC;

-- =========================================================
-- Query 7: Customer Segment Analysis
-- Business Question:
-- Which customer segment generates the highest
-- sales and profit?
-- =========================================================
SELECT
    segment,
    ROUND(SUM(sales),2) AS Total_Sales,
    ROUND(SUM(profit),2) AS Total_Profit,
    COUNT(DISTINCT order_id) AS Total_Orders,
    ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AS Average_Order_Value,
    ROUND(SUM(profit)/SUM(sales)*100,2) AS Profit_Margin
FROM retail_sales
GROUP BY segment
ORDER BY Total_Sales DESC;

-- =========================================================
-- Query 8: Top Customers
-- Business Question:
-- Which customers generate the highest sales?
-- =========================================================
SELECT
    customer_name,
    ROUND(SUM(sales),2) AS Total_Sales,
    ROUND(SUM(profit),2) AS Total_Profit
FROM retail_sales
GROUP BY customer_name
ORDER BY Total_Sales DESC
LIMIT 10;

-- =========================================================
-- Query 9: Most Profitable Customers
-- Business Question:
-- Which customers contribute the highest profits?
-- =========================================================
SELECT
    customer_name,
    ROUND(SUM(profit),2) AS Total_Profit,
    ROUND(SUM(sales),2) AS Total_Sales
FROM retail_sales
GROUP BY customer_name
ORDER BY Total_Profit DESC
LIMIT 10;

-- =========================================================
-- Query 10: High-Sales Customers with Losses
-- Business Question:
-- Which customers generate high sales but
-- negative profits?
-- =========================================================

SELECT
    customer_name,
    ROUND(SUM(sales),2) AS Total_Sales,
    ROUND(SUM(profit),2) AS Total_Profit
FROM retail_sales
GROUP BY customer_name
HAVING SUM(sales) > 10000
AND SUM(profit) < 0
ORDER BY Total_Sales DESC;

-- =========================================================
-- Query 11: Shipping Analysis
-- Business Question:
-- Which shipping methods perform best?
-- =========================================================

SELECT
    ship_mode,
    ROUND(SUM(sales),2) AS Total_Sales,
    ROUND(SUM(profit),2) AS Total_Profit,
    ROUND(AVG(shipping_days),2) AS Average_Shipping_Days,
    ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AS Average_Order_Value
FROM retail_sales
GROUP BY ship_mode
ORDER BY Total_Sales DESC;

-- =========================================================
-- Query 12: Discount Analysis
-- Business Question:
-- How does discount affect profitability?
-- =========================================================

SELECT
    discount,
    COUNT(*) AS Transactions,
    ROUND(AVG(sales),2) AS Average_Sales,
    ROUND(AVG(profit),2) AS Average_Profit,
    ROUND(SUM(profit),2) AS Total_Profit
FROM retail_sales
GROUP BY discount
ORDER BY discount;

-- =========================================================
-- Query 13: State Performance
-- Business Question:
-- Which states perform best?
-- =========================================================

SELECT
    state,
    ROUND(SUM(sales),2) AS Total_Sales,
    ROUND(SUM(profit),2) AS Total_Profit,
    ROUND(SUM(profit)/SUM(sales)*100,2) AS Profit_Margin
FROM retail_sales
GROUP BY state
ORDER BY Total_Profit DESC;

-- =========================================================
-- Query 14: Loss-Making States
-- Business Question:
-- Which states generate negative profits?
-- =========================================================

SELECT
    state,
    ROUND(SUM(sales),2) AS Total_Sales,
    ROUND(SUM(profit),2) AS Total_Profit
FROM retail_sales
GROUP BY state
HAVING SUM(profit) < 0
ORDER BY Total_Profit ASC;

-- =========================================================
-- Query 15: Monthly Sales Trend
-- Business Question:
-- How do monthly sales change over time?
-- =========================================================

SELECT
    strftime('%Y-%m', order_date) AS Month,
    ROUND(SUM(sales),2) AS Total_Sales,
    ROUND(SUM(profit),2) AS Total_Profit
FROM retail_sales
GROUP BY Month
ORDER BY Month;

