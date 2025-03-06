--EASY TASKS

---1. Write a query to assign a row number to each employee in the Employees table ordered by their Salary.
SELECT * FROM Employees

SELECT *, ROW_NUMBER() OVER(ORDER BY Salary) AS OrderBySalary
FROM Employees

---2. Create a query to rank all products based on their Price in descending order.
SELECT * FROM Products

SELECT *, RANK() OVER(ORDER BY Price DESC) AS RankBySalary
FROM Products

---3. Use the DENSE_RANK() function to rank employees by Salary in the Employees table.
SELECT * FROM Employees

SELECT *, DENSE_RANK() OVER(ORDER BY Salary) RankBySalary
FROM Employees

---4. Write a query to display the next (lead) salary for each employee in the same department using the LEAD() function.

SELECT *, LEAD(Salary,1,0) OVER(PARTITION BY DepartmentID ORDER BY Salary) AS NextEmpSalary
FROM Employees

---5. Use ROW_NUMBER() to assign a unique number to each order in the Orders table.
SELECT * FROM Orders

SELECT *, ROW_NUMBER() OVER(ORDER BY OrderID) AS No
FROM Orders

---6. Create a query using RANK() to identify the highest and second-highest salaries in the Employees table.
SELECT * FROM Employees


SELECT *
FROM(
SELECT *, RANK() OVER(ORDER BY Salary DESC) AS SalaryRank
FROM Employees 
) AS A
WHERE SalaryRank IN (1,2)

---7. Write a query to show the previous (lagged) salary for each employee in the Employees table using the LAG() function.

SELECT *, LAG(Salary) OVER(ORDER BY EmployeeID) AS PreEmpSalary
FROM Employees

---8. Use NTILE(4) to divide employees into 4 groups based on their Salary.
SELECT *, NTILE(4) OVER(ORDER BY SALARY) AS SalaryGroup
FROM Employees

---9. Write a query to partition employees by DepartmentID and assign a row number within each department.

SELECT *, ROW_NUMBER() OVER(PARTITION BY DepartmentID ORDER BY EmployeeID) AS No
FROM Employees

---10. Use DENSE_RANK() to rank products by Price in ascending order.

SELECT *, DENSE_RANK() OVER(ORDER BY Price) AS PriceRank
FROM Products

--MEDIUM TASKS

---1. Write a query to compute the cumulative average salary of employees, ordered by Salary.

SELECT *, AVG(Salary) OVER(ORDER BY SALARY ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeAvg
FROM Employees

---2. Use RANK() to rank products by their total sales while handling ties appropriately.

SELECT P.ProductName,
       S.SalesAmount,
	   S.SalesID,
	   RANK() OVER(ORDER BY SalesAmount) AS Rank
FROM Products AS P
JOIN Sales AS S ON S.ProductID = P.ProductID

---3. Create a query to retrieve the previous order's date for each order in the Orders table using the LAG() function.

SELECT SalesID,
       ProductID,
	   SalesAmount,
	   SalesDate AS SoldDate,
	   LAG(SalesDate) OVER(ORDER BY SalesDate) AS PreSoldDate
FROM Sales

---4. Write a query to calculate the moving sum of Price for products with a window frame of 3 rows.

SELECT *, SUM(Price) OVER(ORDER BY ProductID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS WindowFrame
FROM Products 

---5. Use NTILE(4) to assign employees to four salary ranges and display each employee's salary range.

SELECT *, NTILE(4) OVER(ORDER BY SALARY) AS Groups
FROM Employees

---6. Write a query to partition the Sales table by ProductID and calculate the total SalesAmount per product.

SELECT P.ProductID,
       P.ProductName,
	   S.SalesAmount,
	   SUM(S.SalesAmount) OVER(PARTITION BY P.ProductID) AS TotalPerProduct
FROM Products AS P
JOIN Sales AS S ON S.ProductID = P.ProductID

---7. Use DENSE_RANK() to rank products by StockQuantity without gaps in the ranking.

SELECT *, DENSE_RANK()OVER(ORDER BY StockQuantity)
FROM Products

---8. Create a query using ROW_NUMBER() to identify the second highest salary in each department.

SELECT * FROM (
	SELECT *, ROW_NUMBER() OVER(PARTITION BY DepartmentID ORDER BY Salary) SalaryRank
	FROM Employees
) AS A
WHERE SalaryRank = 2

---9. Write a query to calculate the running total of sales for each product in the Sales table.

SELECT *, 
	   SUM(SalesAmount) OVER(PARTITION BY ProductID ORDER BY SalesDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS TotalPerProduct
FROM Sales

---10. Use LEAD() to display the SalesAmount of the next row for each employee’s sale in the Sales table.

SELECT E.EmployeeName,
       S.ProductID,
	   S.SalesAmount,
	   LEAD(S.SalesAmount) OVER( ORDER BY S.SalesDate) AS NextAmount
FROM Employees AS E
JOIN Sales AS S ON S.EmployeeID = E.EmployeeID

--DIFFICULT TASKS

---1. Write a query using RANK() to rank products by their sales (handling ties) but exclude the top 10% of products by sales.

SELECT * FROM (
	SELECT *, 
	RANK() OVER(ORDER BY SalesAmount) AS Rank,
	COUNT(*) OVER() AS TotalNo
	FROM Sales
) AS A
WHERE [Rank] > (TotalNo/100*10)

---2. Use ROW_NUMBER() to list employees with over 5 years of service, ordered by their HireDate.

SELECT EmployeeName,
       YearsOfExperience
FROM (
SELECT *, 
       ROW_NUMBER() OVER(ORDER BY HireDate) AS [Order],
	   DATEDIFF(YEAR,HireDate,GETDATE()) AS YearsOfExperience
FROM Employees
) AS A
WHERE YearsOfExperience > 5
ORDER BY YearsOfExperience DESC

---3. Write a query using NTILE(10) to divide employees into 10 groups based on Salary and display each employee's group number.

SELECT EmployeeName, Salary, NTILE(10)OVER(ORDER BY Salary) AS GroupNo
FROM Employees

---4. Use the LEAD() function to calculate the next SalesAmount for each sale by an employee and compare it with the current sale.

SELECT EmployeeID,
       SalesAmount,
	   LEAD(SalesAmount) OVER(PARTITION BY EmployeeID ORDER BY SalesDate) AS NextAmount,
	   ABS(SalesAmount - (LEAD(SalesAmount) OVER( ORDER BY EmployeeID)))AS Difference
FROM Sales







