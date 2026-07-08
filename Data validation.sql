USE ecommerce_db;

/*** DATA VALIDATION/VERIFICATION ***/

-- 1. CHECK MISSING DATA 
-- Products Table
SELECT * 
FROM 
	Products
WHERE
	ProductName IS NULL
    OR Price IS NULL
    OR StockQuantity IS NULL;
-- Users Table
SELECT *
FROM 
	Users
WHERE
	Email IS NULL
    OR UserName IS NULL;
    
-- 2. VALIDATE DATA FORMATS
-- Check that all email addresses in the Users table are correctly formatted.
SELECT *
FROM 
	Users
WHERE 
	Email NOT LIKE '%_@__%.__%';

-- 3. STANDARDIZE DATA FORMATS
-- Check all dates in the Orders table are within a reasonable range.
SELECT *
FROM 
	Orders
WHERE 
	OrderDate < '2000-01-01'
    OR OrderDate < CURDATE(); -- 1970-01-01 are the dates we defined for misisng values -> managers can decide how to deal with these data

-- 4. CHECK FOR DUPLICATE ENTRIES
-- Check for duplicate UserIDS in the Users table
SELECT 
	UserID,
    COUNT(*)
FROM
	Users
GROUP BY
	UserID
HAVING
	COUNT(*) > 1;
    
-- 5. ENFORCING CONSTRAINTS
-- Ensure Non-negative Prices
ALTER TABLE
	Products
ADD CONSTRAINT
	chk_price CHECK (Price >= 0); 
    
-- 6. CASCADING DELETES
-- If a user is deleted, ensure that their associated orders are also deleted
ALTER TABLE
	Orders
ADD CONSTRAINT
	fk_user
FOREIGN KEY
	(UserID) REFERENCES Users(UserID)
ON DELETE
	CASCADE;
    
-- 7. USING TRANSACTION TO MAINTAIN INTEGRITY
-- To process an order that affects both the Orders and Products tables.alter

SELECT * 
FROM 
	Users;
    
START TRANSACTION;
-- Insert a new order
-- This step adds a new order to the Orders table.

INSERT INTO
	Orders (OrderID, UserID, OrderDate, TotalAmount)
VALUES
	(1000,123, '2024-08-17', 99.99);
UPDATE
	Products
SET
	StockQuantity = StockQuantity - 1
WHERE 
	ProductID = 1677;
-- If everything is successful
-- COMMIT finalizes the transaction, saving all changes made
COMMIT;
-- If everything goes wrong -> ROLLBACK undoes all changes made -> database consistency
ROLLBACK;

    