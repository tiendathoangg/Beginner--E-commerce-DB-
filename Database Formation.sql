CREATE DATABASE ecommerce_db;

-- Phase 1: Creating and Populating the Products Table
USE ecommerce_db;

-- Create the Products table to store product information
CREATE TABLE Products (
	ProductID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each product
    ProductName VARCHAR(25) NOT NULL, -- Name of the product
    Description TEXT, -- Description of the product
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT NOT NULL,
    Category VARCHAR(100),
    DateAdded DATE NOT NULL DEFAULT (CURDATE())
);

-- Verify the structure of the Products table

DESCRIBE Products;

-- Insert sample data into the Products table
INSERT INTO Products (ProductName, Description, Price, StockQuantity, Category)
VALUES 
('Smartphone', 'A latest model smartphone with all the features.', 699.99, 50, 'Electronics'),
('Running Shoes', 'Comfortable running shoes for all terrains.', 89.99, 100, 'Sportswear'),
('Bluetooth Speaker', 'Portable speaker with excellent sound quality', 45.00, 200, 'Electronics');

-- View the data in the Products table to confirm its accuracy
SELECT * FROM Products;

-- Phase 2: Creating and Populating the Users Table

CREATE TABLE Users (
	UserID INT AUTO_INCREMENT PRIMARY KEY, -- Unique Identifier for each user
    UserName VARCHAR(255) NOT NULL, 
    Email VARCHAR(255) NOT NULL UNIQUE, -- Email of the user, must be unique
    Password VARCHAR(255) NOT NULL, -- Hased password for security
    Address VARCHAR(255),
    DateRegistered DATE NOT NULL DEFAULT (CURDATE()) -- Date when the user registered, default is today
);

-- Verify the structure of the Users table
DESCRIBE Users;

-- Insert sample into the Users table
INSERT INTO Users (UserName, Email, Password, Address)
VALUES 
('John Doe', 'john.doe@example.com', 'hashedpassword123', '123 Main St'),
('Jane Smith', 'jane.smith@example.com', 'hashedpassword456', '456 Elm St');

-- View the data in the Users table to confirm it was inserted correctly
SELECT * FROM Users;

-- Phase 3: Creating and populating Orders table
CREATE TABLE Orders(
	OrderID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) -- Link to the Users table
);

-- Verify the structure of the Orders table
DESCRIBE Orders;

-- Insert sample data into the Orders table
INSERT INTO Orders (UserID, OrderDate, TotalAmount)
VALUES 
(1, '2024-08-01', 789.99),
(2, '2024-08-02', 120.50);

-- View the data in the Orders table
SELECT * FROM Orders;

-- Phase 4: Creating and Populating Reviews table
CREATE TABLE Reviews (
	ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    UserID INT,
    Rating INT,
    ReviewText TEXT, 
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CHECK (Rating >=1 AND Rating <= 5) -- Ensure the rating is beween 1 and 5
);

-- Verify the structure
DESCRIBE Reviews;

-- Insert data into the Reviews table
INSERT INTO Reviews(ProductID, UserID, Rating, ReviewText)
VALUES
(1, 1, 5, 'Amazing smartphone, very satisfied!'),
(2, 2, 4, 'Great shoes, very comfortable.');

-- View the data
SELECT * FROM Reviews;

CREATE TABLE Payments (
	PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    PaymentMethod VARCHAR(50),
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Verify the structure
DESCRIBE Payments;

-- Insert sample data into the table
INSERT INTO Payments (OrderID, PaymentMethod, PaymentDate, Amount)
VALUES 
(1, 'Credit Card', '2024-08-01', 789.99),
(2, 'PayPal', '2024-08-02', 120.50);

-- View the data
SELECT * FROM Payments;
