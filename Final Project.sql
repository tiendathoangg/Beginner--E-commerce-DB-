USE ecommerce_db;

-- 1. Update the Database Schema
-- Add the new ProductLaunchDate field to the Products table

ALTER TABLE 
	Products
ADD ProductLaunchDate DATE;

-- Check the columns of the Products table
SELECT *
FROM 
	Products;

-- 2. Populate the ProductLaunchDate Field
UPDATE Products
SET ProductLaunchDate = CASE Category
		WHEN 'Widgets' THEN '2024-01-01'
        WHEN 'Tools' THEN '2024-02-01'
        WHEN 'Miscellaneous' THEN '2024-03-01'
        WHEN 'Machines' THEN '2024-04-01'
        WHEN 'Instruments' THEN '2024-05-01'
        WHEN 'Gizmos' THEN '2024-06-01'
        WHEN 'Gadgets' THEN '2024-07-01'
        WHEN 'Devices' THEN '2024-08-01'
        WHEN 'Contraptions' THEN '2024-09-01'
        WHEN 'Appliances' THEN '2024-10-01'
        WHEN 'Apparatus' THEN '2021-11-01'
        ELSE ProductLaunchDate
END;

-- Data Validation and Queries
-- 1. Retrieve and Display 
SELECT 
	ProductID,
    ProductName,
	ProductLaunchDate 
FROM 
	Products;
    
-- 2. Count the number of products 	where the ProductLaunchDate	is not NULL	
SELECT
	Category,
    COUNT(*)
FROM 
	Products
GROUP BY
	Category
HAVING
	COUNT(ProductLaunchDate) IS NOT NULL;
    
-- 3. Identify any products where the ProductLaunchDate is still NULL
SELECT
	Category,
    COUNT(*)
FROM 
	Products
GROUP BY
	Category
HAVING
	COUNT(ProductLaunchDate) IS NULL;
    
-- 4. Add a check constraint to ensure the ProductLaunchDate is not NULL and is not earlier than January 1, 2020
ALTER TABLE
	Products
ADD CONSTRAINT
	chk_productlaunchdate 
    CHECK (
    ProductLaunchDate >= '2020-01-01' 
    AND ProductLaunchDate IS NOT NULL
	); 
    
-- Check to see if the constraint has been added
SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Products';

-- 5. Retrieve and display product details to verify data integrity after adding the constraint
SELECT *
FROM Products;

-- 6. Group products by ProductLaunchDate and count how the number of products were launched on each date
SELECT
	ProductLaunchDate,
    COUNT(ProductID) AS "Numer of Product",
    Category
FROM 
	Products
GROUP BY 
	ProductLaunchDate,
    Category;
    
-- Final Check
DESCRIBE Products;