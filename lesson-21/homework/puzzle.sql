

---View and Function Practice

--TASK 1. Aggregated Sales Summary

--Create a view named SalesSummary that shows the total sales amount and the number of orders for each customer.

CREATE TABLE Sales (
    SalesID INT,
    CustomerID INT,
    TotalSalesAmount DECIMAL(15,2)
);

INSERT INTO Sales (SalesID, CustomerID, TotalSalesAmount)
VALUES 
    (1, 6, 1200.25),  
    (2, 3, 400.00),  
    (3, 1, 500.25),  
    (4, 9, 2785.90),  
    (5, 4, 999.00),  
    (6, 10, 1320.45),  
    (7, 7, 350.30),  
    (8, 8, 4250.00),  
    (9, 2, 3420.75), 
    (10, 3, 2000.00),  
    (11, 7, 1200.00),  
    (12, 6, 4000.00),  
    (13, 5, 1500.00),  
    (14, 8, 1500.00),  
    (15, 3, 1175.00),  
    (16, 4, 1999.99),  
    (17, 10, 3700.00),  
    (18, 7, 450.00),  
    (19, 8, 2200.00),  
    (20, 6, 2100.75),  
    (21, 4, 1500.00),  
    (22, 1, 1200.50),  
    (23, 8, 3500.00),  
    (24, 3, 300.00),  
    (25, 10, 2200.00),  
    (26, 7, 700.00),  
    (27, 1, 750.00),  
    (28, 10, 2750.00),  
    (29, 4, 500.99),  
    (30, 6, 1500.50);  

	
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Customers (CustomerID, CustomerName)
VALUES 
    (1, 'Alice Johnson'),
    (2, 'Bob Smith'),
    (3, 'Charlie Davis'),
    (4, 'David Wilson'),
    (5, 'Emma Brown'),
    (6, 'Frank Harris'),
    (7, 'Grace Lee'),
    (8, 'Henry White'),
    (9, 'Isabella Scott'),
    (10, 'Jack Martinez'),
    (11, 'Kevin Thomas'), 
    (12, 'Lily Anderson');

SELECT * FROM Sales
SELECT * FROM Customers

SELECT * FROM [SalesSummary]

CREATE VIEW SalesSummary AS
SELECT 
    S.CustomerID,  -- Keeps it unique in case of duplicate names
    C.CustomerName,
    SUM(S.TotalSalesAmount) AS TotalAmount,
    COUNT(*) AS SalesCount
FROM Sales AS S
JOIN Customers AS C ON C.CustomerID = S.CustomerID
GROUP BY S.CustomerID, C.CustomerName;

--Task 2: Employee Department Details

--Create a view named EmployeeDepartmentDetails that combines employee and department information.



CREATE TABLE Employees (
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, EmployeeName, DepartmentID, Salary)
VALUES 
    (1, 'Alice Johnson', 2, 55000.00),
    (2, 'Bob Smith', 1, 62000.00),
    (3, 'Charlie Brown', 3, 48000.00),
    (4, 'David Williams', 2, 58000.00),
    (5, 'Eva Davis', 1, 67000.00),
    (6, 'Frank Miller', 3, 51000.00),
    (7, 'Grace Wilson', 2, 60000.00),
    (8, 'Henry Thomas', 1, 59000.00),
    (9, 'Ivy Moore', 3, 53000.00),
    (10, 'Jack Taylor', 2, 57000.00);

CREATE TABLE Departments (
    DepartmentID INT,
    DepartmentName VARCHAR(100)
);

INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES 
    (1, 'Human Resources'),
    (2, 'Engineering'),
    (3, 'Marketing');

SELECT * FROM Employees
SELECT * FROM Departments

ALTER VIEW EmployeeDepartmentDetails AS
SELECT 
	E.EmployeeID,
	E.EmployeeName,
	E.Salary,
	D.DepartmentName
FROM Employees AS E
JOIN Departments AS D ON E.DepartmentID = D.DepartmentID

SELECT * FROM EmployeeDepartmentDetails

--Task 3: Product Inventory Status

--Create a view named InventoryStatus that shows product availability information.

CREATE TABLE Products (
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES 
    (1, 'Laptop', 'Electronics', 1200.00),
    (2, 'Smartphone', 'Electronics', 800.00),
    (3, 'Desk Chair', 'Furniture', 150.00),
    (4, 'Table Lamp', 'Home Decor', 45.00),
    (5, 'Headphones', 'Electronics', 250.00),
    (6, 'Office Desk', 'Furniture', 350.00),
    (7, 'Blender', 'Appliances', 90.00),
    (8, 'Backpack', 'Accessories', 60.00),
    (9, 'Monitor', 'Electronics', 300.00),
    (10, 'Coffee Maker', 'Appliances', 110.00);

CREATE TABLE Inventory (
    ProductID INT,
    StockQuantity INT,
    WarehouseLocation VARCHAR(100)
);

INSERT INTO Inventory (ProductID, StockQuantity, WarehouseLocation)
VALUES 
    (1, 25, 'Warehouse A'),
    (2, 50, 'Warehouse B'),
    (3, 10, 'Warehouse A'),
    (4, 40, 'Warehouse C'),
    (5, 15, 'Warehouse A'),
    (6, 8, 'Warehouse B'),
    (7, 30, 'Warehouse C'),
    (8, 60, 'Warehouse B'),
    (9, 20, 'Warehouse A'),
    (10, 12, 'Warehouse C');

SELECT * FROM Products
SELECT * FROM Inventory


CREATE VIEW InventoryStatus AS
SELECT 
	I.ProductID,
	P.ProductName,
	P.Category AS ProductCategory,
	P.Price AS ProductPrice,
	I.StockQuantity,
	I.WarehouseLocation,
	(P.Price * I.StockQuantity) AS StockTotalAmount
FROM Inventory AS I
JOIN Products AS P ON P.ProductID = I.ProductID

SELECT * FROM  InventoryStatus

--Task 4: Simple Scalar Function

--Write a scalar function fn_GetFullName that concatenates a person's first and last name into a single string.

CREATE TABLE People (
    PersonID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

INSERT INTO People (PersonID, FirstName, LastName) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Michael', 'Johnson'),
(4, 'Emily', 'Davis'),
(5, 'David', 'Brown'),
(6, 'Sarah', 'Wilson'),
(7, 'James', 'Taylor'),
(8, 'Laura', 'Anderson'),
(9, 'Robert', 'Thomas'),
(10, 'Emma', 'White');

SELECT * FROM People

ALTER FUNCTION fn_GetFullName(@PersonID INT)
RETURNS VARCHAR(30)
AS
BEGIN
    DECLARE @Name VARCHAR(30)
    
    SELECT @Name = CONCAT(FirstName, ' ', LastName)
    FROM People AS P
    WHERE @PersonID = P.PersonID

    RETURN @Name;
END;

SELECT dbo.fn_GetFullName(3) AS FullName;

--Task 5: Inline Table-Valued Function

--Create an inline table-valued function fn_GetHighSales that returns sales above a given threshold.

CREATE TABLE SalesData (
    SalesID INT PRIMARY KEY,
    CustomerID INT,
    TotalSalesAmount DECIMAL(10,2),
    SalesDate DATE
);

INSERT INTO SalesData (SalesID, CustomerID, TotalSalesAmount, SalesDate) VALUES
(1, 101, 500.00, '2024-01-15'),
(2, 102, 1200.00, '2024-02-10'),
(3, 103, 750.00, '2024-03-05'),
(4, 104, 2000.00, '2024-04-20'),
(5, 105, 450.00, '2024-05-25'),
(6, 106, 3000.00, '2024-06-30'),
(7, 107, 1800.00, '2024-07-18'),
(8, 108, 600.00, '2024-08-22'),
(9, 109, 2500.00, '2024-09-10'),
(10, 110, 900.00, '2024-10-05');

SELECT * FROM SalesData


CREATE FUNCTION fn_GetHighSales(@Threshold DECIMAL(10,2))
RETURNS TABLE
AS
RETURN
(
    SELECT SalesID, CustomerID, TotalSalesAmount, SalesDate
    FROM SalesData
    WHERE TotalSalesAmount > @Threshold
);

SELECT * FROM fn_GetHighSales(1000);

--Task 6: Multi-Statement Table-Valued Function

--Create a function fn_GetCustomerStats that calculates statistics for customers based on their transactions.

CREATE TABLE CustomersData (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    CustomerID INT,
    Amount DECIMAL(10,2),
    TransactionDate DATE
);

INSERT INTO CustomersData (CustomerID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Michael Johnson'),
(104, 'Emily Davis'),
(105, 'David Brown');

INSERT INTO Transactions (TransactionID, CustomerID, Amount, TransactionDate) VALUES
(1, 101, 500.00, '2024-01-15'),
(2, 101, 1200.00, '2024-02-10'),
(3, 102, 750.00, '2024-03-05'),
(4, 102, 2000.00, '2024-04-20'),
(5, 103, 450.00, '2024-05-25'),
(6, 103, 3000.00, '2024-06-30'),
(7, 104, 1800.00, '2024-07-18'),
(8, 104, 600.00, '2024-08-22'),
(9, 105, 2500.00, '2024-09-10'),
(10, 105, 900.00, '2024-10-05');

SELECT * FROM CustomersData
SELECT * FROM Transactions

CREATE FUNCTION fn_GetCustomerStats()
RETURNS @CustomerStats TABLE 
(
    TransactionID INT,
    CustomerName VARCHAR(100),
    Amount DECIMAL(10,2),
    TransactionDate DATE
)
AS
BEGIN
    INSERT INTO @CustomerStats
    SELECT 
        T.TransactionID,
        C.CustomerName,
        T.Amount,
        T.TransactionDate
    FROM Transactions AS T
    JOIN Customers AS C ON C.CustomerID = T.CustomerID;

    RETURN;
END;

SELECT * FROM fn_GetCustomerStats();

---Window Functions in SQL

--Task 2: Syntax of Window Functions

--Write an SQL query to calculate cumulative sales using the SUM window function.


CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    CustomerID INT,
    TotalSalesAmount DECIMAL(10,2),
    SalesDate DATE
);

INSERT INTO Sales (SalesID, CustomerID, TotalSalesAmount, SalesDate) VALUES
(1, 101, 500.00, '2024-01-15'),
(2, 102, 1200.00, '2024-02-10'),
(3, 103, 750.00, '2024-03-05'),
(4, 104, 2000.00, '2024-04-20'),
(5, 105, 450.00, '2024-05-25'),
(6, 106, 3000.00, '2024-06-30'),
(7, 107, 1800.00, '2024-07-18'),
(8, 108, 600.00, '2024-08-22'),
(9, 109, 2500.00, '2024-09-10'),
(10, 110, 900.00, '2024-10-05');

SELECT * FROM Sales

SELECT *, SUM(TotalSalesAmount) OVER(ORDER BY SalesDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Sales


--Calculate the average salary for each department using window functions.

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10,2)
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

INSERT INTO Employees (EmployeeID, EmployeeName, DepartmentID, Salary) VALUES
(1, 'John Doe', 1, 5000.00),
(2, 'Jane Smith', 1, 6000.00),
(3, 'Michael Johnson', 2, 4500.00),
(4, 'Emily Davis', 2, 4800.00),
(5, 'David Brown', 3, 5500.00),
(6, 'Sarah Wilson', 3, 5300.00);

SELECT * FROM Employees
SELECT * FROM Departments

SELECT *, AVG(Salary) OVER(PARTITION BY D.DepartmentID) AS AvgByDepartment
FROM Employees AS E
JOIN Departments AS D ON E.DepartmentID = D.DepartmentID

--Task 3: Partition By vs Group By

--Create a query using PARTITION BY to calculate cumulative revenue for each product category.

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    ProductID INT,
    QuantitySold INT,
    TotalSalesAmount DECIMAL(10,2),
    SalesDate DATE
);

INSERT INTO Sales (SalesID, ProductID, QuantitySold, TotalSalesAmount, SalesDate) VALUES
(1, 7, 3, 270.00, '2024-02-12'),
(2, 2, 2, 1600.00, '2024-05-07'),
(3, 9, 5, 1500.00, '2024-03-25'),
(4, 4, 2, 90.00, '2024-04-19'),
(5, 1, 1, 1200.00, '2024-01-23'),
(6, 3, 4, 600.00, '2024-02-28'),
(7, 5, 2, 500.00, '2024-06-10'),
(8, 8, 3, 180.00, '2024-03-11'),
(9, 10, 5, 550.00, '2024-01-15'),
(10, 6, 2, 700.00, '2024-02-05'),
(11, 5, 1, 250.00, '2024-04-02'),
(12, 1, 2, 2400.00, '2024-05-18'),
(13, 9, 3, 900.00, '2024-03-07'),
(14, 7, 2, 180.00, '2024-01-29'),
(15, 3, 4, 600.00, '2024-06-01'),
(16, 10, 1, 110.00, '2024-02-17'),
(17, 2, 2, 1600.00, '2024-05-25'),
(18, 4, 4, 180.00, '2024-03-30'),
(19, 6, 3, 1050.00, '2024-06-05'),
(20, 8, 2, 120.00, '2024-02-09'),
(21, 1, 3, 3600.00, '2024-05-14'),
(22, 9, 1, 300.00, '2024-01-20'),
(23, 5, 3, 750.00, '2024-03-22'),
(24, 2, 4, 3200.00, '2024-06-18'),
(25, 8, 1, 60.00, '2024-02-23'),
(26, 6, 2, 700.00, '2024-04-08'),
(27, 3, 3, 450.00, '2024-05-27'),
(28, 7, 1, 90.00, '2024-01-17'),
(29, 10, 6, 660.00, '2024-02-14'),
(30, 4, 3, 135.00, '2024-06-22');

SELECT 
	S.SalesID,
	P.ProductName,
	P.Category,
	S.TotalSalesAmount,
	S.SalesDate,
	SUM(TotalSalesAmount)OVER(PARTITION BY P.Category ORDER BY S.SalesDate) AS RunningTotalByCategory
FROM Sales AS S
JOIN Products AS P ON P.ProductID = S.ProductID

