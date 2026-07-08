USE ecommerce_db;

-- 1. Retrieving neccessary columns for analysis
-- Before Optimization 
SELECT *
FROM 
	Products;

-- After Optimization: choosing relevant fields to retrieve data 
SELECT
	ProductName,
    Price,
    StockQuantity
FROM
	Products;
    
-- 2. Limiting specific rows
-- Before Optimization
SELECT 
	ProductName,
    Price,
    StockQuantity
FROM 
	Products
WHERE
	Category = "Gizmos";
    
-- After Optimization
SELECT 
	ProductName,
    Price,
    StockQuantity
FROM 
	Products
WHERE
	Category = "Gizmos"
LIMIT 5;

/* Optimizations 1 and 2 can help businesses save time and resources by retrieving targeted information */

-- 3. Using the EXPLAIN Command
-- The EXPLAIN command is used to analyze the execution plan of a query,
-- It helps to understand how MySQL is processing the query, which is useful for optimization.

EXPLAIN SELECT
	ProductName,
    Price
FROM
	Products
WHERE
	Category = 'Instruments';


