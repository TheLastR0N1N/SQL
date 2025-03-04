--EASY TASKS

---1. Write a query to calculate the running total of SalesAmount for each product in the Sales table, ordered by SaleDate.

SELECT 
    ProductID, 
    SaleDate, 
    SalesAmount, 
    SUM(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS TotalAmount
FROM Sales;

---2. Use the SUM() aggregate window function to calculate the cumulative sum of Amount for each customer in the Orders table.

SELECT 
	OrderID,
	CustomerID,
	OrderAmount,
	SUM(OrderAmount) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS CumulativeTotal
FROM Orders

---3. Write a query to find the running total of OrderAmount in the Orders table, partitioned by CustomerID.

SELECT 
	OrderID,
	CustomerID,
	OrderAmount,
	SUM(OrderAmount) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS CumulativeTotal
FROM Orders

---4. Use the AVG() window function to calculate the average sales amount up to the current row for each product in the Sales table.
SELECT 
	SalesID,
	EmployeeID,
	ProductID,
	AVG(SalesAmount) OVER(PARTITION BY ProductID ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS UnbAvg,
	SaleDate
FROM Sales

---5. Write a query to rank each order’s OrderAmount using the RANK() window function.

SELECT 
	OrderID,
	OrderAmount,
	RANK()OVER(ORDER BY OrderAmount) AS Ranking
FROM Orders

---6. Use the LEAD() function to retrieve the next row's Amount for each product in the Sales table.
SELECT 
	ProductID,
	SalesAmount AS CurrentAmount,
	LEAD(ProductID) OVER(ORDER BY SaleDate) AS NextProductID,
	LEAD(SalesAmount) OVER(ORDER BY SaleDate) AS NextAmount
FROM Sales

---7. Write a query to calculate the total sales for each customer in the Orders table using the SUM() function as a window function.
SELECT 
	OrderID,
	CustomerID,
	SUM(OrderAmount) OVER(PARTITION BY CustomerID) AS TotalByCustomer
FROM Orders 

---8. Use the COUNT() function to determine the number of orders placed up to the current row in the Orders table.
SELECT 
	OrderID,
	CustomerID,
	COUNT(*) OVER(ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeCount
FROM Orders

---9.Write a query to partition the Sales table by ProductCategory and calculate the running total of SalesAmount for each category.
SELECT 
	SalesID,
	ProductID,
	SalesAmount,
	SUM(SalesAmount) OVER(PARTITION BY ProductCategory ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Sales 

---10. Use ROW_NUMBER() to assign a unique rank to each order in the Orders table, ordered by OrderDate.
SELECT
	OrderID,
	CustomerID,
	OrderAmount,
	OrderDate,
	ROW_NUMBER() OVER(ORDER BY OrderDate) UniqueRank
FROM Orders

---11. Write a query using LAG() to find the OrderAmount from the previous row for each order in the Orders table.
SELECT 
	OrderID,
	OrderAmount,
	LAG(OrderAmount) OVER( ORDER BY ORDERID) AS PreAmount
FROM Orders

---12. Use NTILE(4) to divide products in the Products table into 4 equal groups based on Price.
SELECT
	ProductName,
	NTILE(4)OVER(ORDER BY Price) AS Groups
FROM Products

---13. Write a query using SUM() to calculate the cumulative total of sales for each salesperson in the Sales table.
SELECT 
	EmployeeID,
	SalesAmount,
	SUM(SalesAmount) OVER(PARTITION BY EmployeeID ) AS CumulativeTotal
FROM Sales

---14. Use DENSE_RANK() to rank the products in the Products table based on StockQuantity.
SELECT 
	ProductName,
	Price,
	DENSE_RANK() OVER(ORDER BY StockQuantity DESC) AS Ranking
FROM Products

---15. Write a query to compute the difference between the current and next OrderAmount in the Orders table using LEAD().
SELECT 
	OrderID,
	OrderAmount AS CurrentAmount,
	LEAD(OrderAmount,1,0) OVER(ORDER BY OrderID) AS NextAmount,
	ABS((OrderAmount-LEAD(OrderAmount,1,0) OVER(ORDER BY OrderID))) AS Difference
FROM Orders

---16. Use RANK() to assign a rank to products in the Products table, ordered by Price.
SELECT
	ProductName,
	RANK() OVER(ORDER BY Price) AS Ranking
FROM Products

---17. Write a query using AVG() to calculate the average order amount for each customer in the Orders table.
SELECT
	OrderID,
	CustomerID,
	OrderAmount,
	AVG(OrderAmount) OVER(PARTITION BY CustomerID) AS RunningAvg
FROM Orders

---18. Use ROW_NUMBER() to assign a unique row number to each employee in the Employees table, ordered by Salary.
SELECT 
	EmployeeID,
	DepartmentID,
	Salary,
	ROW_NUMBER() OVER(PARTITION BY EMPLOYEEID ORDER BY SALARY) UniqueRank
FROM Employees

---19. Write a query to partition the Sales table by StoreID and calculate the cumulative sum of SalesAmount for each store.
SELECT 
	StoreID,
	ProductID,
	SalesAmount,
	SaleDate,
	SUM(SalesAmount) OVER(PARTITION BY StoreID ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Cumulative
FROM Sales

---20. Use LAG() to find the previous order's OrderAmount in the Orders table.
SELECT 
	OrderID,
	OrderAmount,
	LAG(OrderAmount) OVER(ORDER BY ORDERID) AS PreAmount
FROM Orders

--DIFFICULT TASKS
---1. Write a query using SUM() to calculate the running total of SalesAmount for each product and store in the Sales table.
SELECT 
	SalesID,
	ProductID,
	StoreID,
	SalesAmount,
	SUM(SalesAmount) OVER(PARTITION BY ProductID, StoreID ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) TotalByProduct
FROM Sales

---2. Use LEAD() to calculate the percentage change in OrderAmount between the current and next row in the Orders table.
SELECT 
	OrderID,
	OrderAmount AS CurrentAmount,
	LEAD(OrderAmount) OVER(ORDER BY OrderID) AS NextAmount,
	CAST((100-((OrderAmount)/(LEAD(OrderAmount) OVER(ORDER BY OrderID))*100))AS DECIMAL(10,2)) AS PercentageChange
FROM Orders

---3. Write a query using ROW_NUMBER() to return the top 3 products by SalesAmount, ensuring ties are handled appropriately.
WITH RankedSales AS (
    SELECT 
        SalesID,
        ProductID,
        SalesAmount,
        ROW_NUMBER() OVER(ORDER BY SalesAmount DESC, SaleDate) AS Rank
    FROM Sales
)
SELECT SalesID, ProductID, SalesAmount
FROM RankedSales
WHERE Rank <= 3;

---4. Use RANK() to assign a rank to each employee in the Employees table based on Salary, partitioned by DepartmentID.
SELECT 
	EmployeeID,
	DepartmentID,
	Salary,
	RANK() OVER(PARTITION BY DEPARTMENTID ORDER BY SALARY DESC) AS Rank
FROM Employees

---6. Use LAG() to calculate the change in SalesAmount between the previous and current sale for each product in the Sales table.
SELECT 
	SalesID,
	ProductID,
	SalesAmount AS CurrentAmount,
	LAG(SalesAmount) OVER(ORDER BY ProductID) AS PreAmount,
	ABS((SalesAmount - (LAG(SalesAmount) OVER(ORDER BY ProductID)))) AS Difference
FROM Sales

---7. Write a query to compute the cumulative average of SalesAmount for each product, ordered by SaleDate.

SELECT 
	SalesID,
	ProductID,
	SalesAmount,
	AVG(SalesAmount) OVER(PARTITION BY PRODUCTID ORDER BY SALEDATE ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeAvg
FROM Sales

---8. Use DENSE_RANK() to identify the products with the top 5 highest SalesAmount in the Products table, ignoring ties.
WITH RankedSales AS (
    SELECT 
        SalesID,
        ProductID,
        SalesAmount,
        DENSE_RANK() OVER(ORDER BY SalesAmount DESC, SaleDate) AS Rank
    FROM Sales
)
SELECT SalesID, ProductID, SalesAmount
FROM RankedSales
WHERE Rank <= 5;

---9. Write a query to partition the Sales table by ProductCategory and calculate the running total of SalesAmount for each category.
SELECT 
	SalesID,
	P.ProductName,
	S.SalesAmount,
	P.ProductCategory,
	SUM(S.SalesAmount) OVER(PARTITION BY P.ProductCategory ORDER BY S.SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Sales AS S
JOIN Products AS P ON S.ProductID = P.ProductID

---10. Use both LEAD() and LAG() together to find the difference in OrderAmount between the previous and next rows in the Orders table.
SELECT 
	OrderID,
	LAG(OrderAmount) OVER(ORDER BY OrderID) AS PreAmount,
	LEAD(OrderAmount) OVER(ORDER BY OrderID) AS NextAmount,
	ABS((LAG(OrderAmount,1,0) OVER(ORDER BY OrderID)) - (LEAD(OrderAmount,1,0) OVER(ORDER BY OrderID))) AS Difference
FROM Orders



