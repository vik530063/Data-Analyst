use  SQL_Project;

-- Revenue Per Transaction
SELECT 
    InvoiceID, 
    Branch, 
    City, 
    Sales AS Revenue, 
    RANK() OVER (ORDER BY Sales DESC) AS RevenueRank
FROM 
    SalesData;


-- City-wise contribution to Total Sales
SELECT 
    City, 
    SUM(Sales) AS TotalSales, 
    ROUND(SUM(Sales) / (SELECT SUM(Sales) FROM SalesData) * 100, 2) AS PercentageContribution
FROM 
    SalesData
GROUP BY 
    City
ORDER BY 
    TotalSales DESC;

-- Peak Sales Hour
SELECT 
    HOUR(Time) AS Hour, 
    SUM(Sales) AS TotalSales
FROM 
    SalesData
GROUP BY 
    Hour
ORDER BY 
    TotalSales DESC;


-- ProductLine Profitibility
SELECT 
    ProductLine, 
    SUM(GrossIncome) AS TotalProfit, 
    SUM(Sales) AS TotalSales, 
    ROUND(SUM(GrossIncome) / SUM(Sales) * 100, 2) AS ProfitMarginPercentage
FROM 
    SalesData
GROUP BY 
    ProductLine
ORDER BY 
    TotalProfit DESC;

-- Branch wise Product-Line Analysis
SELECT 
    Branch, 
    ProductLine, 
    SUM(Sales) AS TotalSales, 
    SUM(Quantity) AS TotalQuantity
FROM 
    SalesData
GROUP BY 
    Branch, ProductLine
ORDER BY 
    Branch, TotalSales DESC;

-- Customer Retention Analysis (Member Vs Normal)
SELECT 
    CustomerType, 
    COUNT(InvoiceID) AS TotalTransactions, 
    SUM(Sales) AS TotalSales, 
    AVG(Sales) AS AvgTransactionValue
FROM 
    SalesData
GROUP BY 
    CustomerType
ORDER BY 
    TotalSales DESC;
    
    -- Payment method Performance
    SELECT 
    Payment, 
    COUNT(InvoiceID) AS TotalTransactions, 
    SUM(Sales) AS TotalSales, 
    AVG(Sales) AS AvgTransactionValue
FROM 
    SalesData
GROUP BY 
    Payment
ORDER BY 
    TotalSales DESC;

-- City and Gender wise Sales analysis
SELECT 
    City, 
    Gender, 
    SUM(Sales) AS TotalSales, 
    AVG(Sales) AS AvgSales
FROM 
    SalesData
GROUP BY 
    City, Gender
ORDER BY 
    City, TotalSales DESC;

-- Rating based Product Line performance
SELECT 
    ProductLine, 
    AVG(Rating) AS AvgRating, 
    SUM(Sales) AS TotalSales
FROM 
    SalesData
GROUP BY 
    ProductLine
ORDER BY 
    AvgRating DESC;

-- High Grossing Product-Line By city
WITH RankedProducts AS (
    SELECT 
        City, 
        ProductLine, 
        SUM(Sales) AS TotalSales,
        RANK() OVER (PARTITION BY City ORDER BY SUM(Sales) DESC) AS ProductRank
    FROM 
        SalesData
    GROUP BY 
        City, ProductLine
)
SELECT 
    City, 
    ProductLine, 
    TotalSales
FROM 
    RankedProducts
WHERE 
    ProductRank = 1
ORDER BY 
    City, TotalSales DESC;


-- Monthly trends and Growth rate
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month, 
    SUM(Sales) AS MonthlySales,
    LAG(SUM(Sales)) OVER (ORDER BY DATE_FORMAT(Date, '%Y-%m')) AS PreviousMonthSales,
    ROUND((SUM(Sales) - LAG(SUM(Sales)) OVER (ORDER BY DATE_FORMAT(Date, '%Y-%m'))) / LAG(SUM(Sales)) OVER (ORDER BY DATE_FORMAT(Date, '%Y-%m')) * 100, 2) AS GrowthRate
FROM 
    SalesData
GROUP BY 
    Month
ORDER BY 
    Month;

-- Corelation between unit price and quantity
-- SELECT 
--     (COUNT(*) * SUM(UnitPrice * Quantity) - SUM(UnitPrice) * SUM(Quantity)) /
--     SQRT(
--         (COUNT(*) * SUM(POW(UnitPrice, 2)) - POW(SUM(UnitPrice), 2)) *
--         (COUNT(*) * SUM(POW(Quantity, 2)) - POW(SUM(Quantity), 2))
--     ) AS CorrelationCoefficient
-- FROM 
--     SalesData;


-- Top performing day of the week
SELECT 
    DAYNAME(Date) AS Day, 
    SUM(Sales) AS TotalSales
FROM 
    SalesData
GROUP BY 
    Day
ORDER BY 
    FIELD(Day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- Customer segmentation by spending behavior
SELECT 
    CustomerType,
    CASE 
        WHEN SUM(Sales) > 1000 THEN 'High Spender'
        WHEN SUM(Sales) BETWEEN 500 AND 1000 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS SpendingCategory,
    SUM(Sales) AS TotalSales
FROM 
    SalesData
GROUP BY 
    CustomerType
ORDER BY 
    TotalSales DESC;


