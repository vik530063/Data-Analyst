create database SQL_Project;
use  SQL_Project;
CREATE TABLE SalesData (
    InvoiceID VARCHAR(20) PRIMARY KEY,       -- Unique transaction ID
    Branch VARCHAR(50) NOT NULL,      -- Customer name
    City VARCHAR(50) NOT NULL,              -- City of the branch
    CustomerType VARCHAR(20) NOT NULL,      -- Customer type (Member/Normal)
    Gender VARCHAR(10) NOT NULL,            -- Gender (Male/Female)
    ProductLine VARCHAR(50) NOT NULL,       -- Product category
    UnitPrice DECIMAL(10, 2) NOT NULL,      -- Price per unit
    Quantity INT NOT NULL,                  -- Quantity sold
    Tax5Percent DECIMAL(10, 4) NOT NULL,    -- 5% tax amount
    Sales DECIMAL(10, 4) NOT NULL,          -- Total sales amount
    Date DATE NOT NULL,                     -- Transaction date
    Time TIME NOT NULL,                     -- Transaction time
    Payment VARCHAR(20) NOT NULL,           -- Payment method
    Cogs DECIMAL(10, 2) NOT NULL,           -- Cost of goods sold
    GrossMarginPercentage DECIMAL(10, 6) NOT NULL, -- Gross margin percentage
    GrossIncome DECIMAL(10, 4) NOT NULL,    -- Gross income
    Rating DECIMAL(3, 1) NOT NULL           -- Customer rating
);


 select * from SalesData;
 
 -- Total Sales by City
 SELECT City, SUM(Sales) AS TotalSales
FROM SalesData
GROUP BY City
ORDER BY TotalSales DESC;

-- Best Selling Product Line
SELECT ProductLine, SUM(Sales) AS TotalSales
FROM SalesData
GROUP BY ProductLine
ORDER BY TotalSales DESC;

 -- Top 5 Performing Branches
 SELECT Branch, SUM(Sales) AS TotalSales
FROM SalesData
GROUP BY Branch
ORDER BY TotalSales DESC
LIMIT 5;

-- Sales Braekdown by Payment method
SELECT Payment, SUM(Sales) AS TotalSales, COUNT(InvoiceID) AS Transactions
FROM SalesData
GROUP BY Payment
ORDER BY TotalSales DESC;

 -- Monthly sales Trends
 SELECT DATE_FORMAT(Date, '%Y-%m') AS Month, SUM(Sales) AS MonthlySales
FROM SalesData
GROUP BY Month
ORDER BY Month;

-- Customer Type analysis
SELECT CustomerType, COUNT(InvoiceID) AS CustomerCount, SUM(Sales) AS TotalSales
FROM SalesData
GROUP BY CustomerType
ORDER BY TotalSales DESC;

-- Gender Based Pattern
SELECT Gender, SUM(Sales) AS TotalSales, AVG(Rating) AS AvgRating
FROM SalesData
GROUP BY Gender;

-- Best Time For Sales
SELECT HOUR(Time) AS Hour, SUM(Sales) AS TotalSales
FROM SalesData
GROUP BY Hour
ORDER BY TotalSales DESC;

-- Average Rating by Product line
SELECT ProductLine, AVG(Rating) AS AvgRating
FROM SalesData
GROUP BY ProductLine
ORDER BY AvgRating DESC;

-- Gross income contribution by city
SELECT City, SUM(GrossIncome) AS TotalGrossIncome
FROM SalesData
GROUP BY City
ORDER BY TotalGrossIncome DESC;

