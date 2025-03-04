--1
SELECT * FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products)

--2
SELECT * FROM Employees
WHERE DepartmentID IN (SELECT DepartmentID FROM Employees GROUP BY DepartmentID HAVING COUNT(*) > 10  )

--3
SELECT * FROM Employees A
WHERE Salary > (SELECT AVG(Salary) FROM Employees B WHERE A.DepartmentID = B.DepartmentID)
	
--4
SELECT C.CustomerName  FROM Customers AS C
JOIN Orders AS O ON C.CustomerID = O.CustomerID
GROUP BY CustomerName
HAVING COUNT(DISTINCT C.CustomerID) > 0

--5
SELECT * FROM Orders A
WHERE EXISTS (SELECT 1 FROM OrderDetails B WHERE A.OrderID = B.OrderID)

--7
SELECT *, (SELECT AVG(Salary) FROM Employees) AS AVG FROM Employees 
WHERE Salary > (SELECT AVG(Salary) FROM Employees )

--8

--9
SELECT * FROM Products
WHERE Price = (SELECT MAX(Price) FROM Products)

--10
SELECT SalesAmount FROM Sales
WHERE SalesAmount = (SELECT MAX(SalesAmount) FROM Sales)

--11
SELECT C.CustomerName FROM Customers AS C
JOIN Orders AS O ON C.CustomerID = O.CustomerID
WHERE NOT EXISTS (
    SELECT 1 FROM Orders AS O2 WHERE O2.CustomerID = c.CustomerID
);

--12
SELECT * FROM Products
WHERE Category = (SELECT DISTINCT Category FROM Products WHERE Category = 'Electronics')
	
--13
SELECT * FROM Orders
WHERE OrderDate = (SELECT OrderDate FROM Orders WHERE OrderDate = '2025-01-11')

--14
SELECT SUM(Quantity) AS TotalSales FROM OrderDetails
WHERE OrderID = (SELECT DISTINCT OrderID FROM OrderDetails WHERE OrderID = 15) 

--15
SELECT CONCAT(FirstName,' ',LastName) AS FullName,
       DATEDIFF(YEAR,HiredDate,GETDATE()) Year 
FROM Employees
WHERE DATEDIFF(YEAR,HiredDate,GETDATE()) > 5

--16
SELECT * FROM Employees AS A
WHERE Salary > (SELECT AVG(Salary) AS AvgSalary FROM Employees AS B WHERE A.DepartmentID = B.DepartmentID)

--17
SELECT * FROM Sales AS S
WHERE EXISTS (SELECT 1 FROM Products AS P WHERE S.ProductID = P.ProductID)

--18
SELECT C.CustomerName FROM Orders AS O
JOIN Customers AS C ON O.CustomerID = C.CustomerID
WHERE DATEDIFF(DAY,OrderDate,GETDATE()) < 30

--19
SELECT ProductName FROM Products
WHERE StoredDate = (SELECT MIN(StoredDate) FROM Products)

--20
SELECT CONCAT(FirstName,' ',LastName) AS FullName FROM Employees AS E
WHERE NOT EXISTS (SELECT 1 FROM Departments AS D WHERE D.DepartmentID = E.DepartmentID)

--MEDIUM TASKS

--1
SELECT A.EmployeeID,
       CONCAT(A.LastName,' ', A.FirstName) AS FullName,
	   A.DepartmentID,
	   A.Salary
FROM Employees A
WHERE EXISTS (
    SELECT 1
    FROM Employees B
    WHERE B.Salary > 100000
    AND A.DepartmentID = B.DepartmentID
);

--2. Write a query to list all staff members who have the highest salary in their division using a subquery.
SELECT A.EmployeeID,
       CONCAT(A.LastName,' ', A.FirstName) AS FullName, 
	   A.DepartmentID, 
	   A.Salary 
FROM Employees AS A
WHERE Salary = (SELECT MAX(Salary) FROM Employees AS B WHERE A.DepartmentID = B.DepartmentID)

--3. Create a subquery to list all clients who have made purchases but have never bought an item priced above $200.
SELECT C.CustomerName,
       OD.UnitPrice
FROM Customers AS C
JOIN Orders AS O ON C.CustomerID = O.CustomerID
JOIN OrderDetails AS OD ON O.OrderID = OD.OrderID
WHERE UnitPrice <= 200

--4
 
--5
SELECT CustomerName
FROM Customers AS  C
JOIN (
    SELECT O.CustomerID
    FROM Orders AS O
    JOIN OrderDetails AS OD ON O.OrderID = OD.OrderID
	GROUP BY O.CustomerID
    HAVING COUNT(OD.OrderID) > 3
) AS SubQ ON C.CustomerID = SubQ.CustomerID;

--6
SELECT * FROM Customers AS C
JOIN (SELECT O.CustomerID, SUM(OD.Quantity) AS TotalQuantity FROM Orders AS O 
      JOIN OrderDetails AS OD ON OD.OrderID = O.OrderID
	  WHERE O.OrderDate BETWEEN DATEADD(DAY,-30,GETDATE()) AND GETDATE()
	  GROUP BY O.CustomerID) AS Q ON Q.CustomerID = C.CustomerID

--7
SELECT * FROM Employees AS E
WHERE E.Salary > (SELECT AVG(E2.Salary) FROM Employees AS E2 WHERE E.DepartmentID = E2.DepartmentID)

--8
SELECT * FROM Products AS P 
LEFT JOIN OrderDetails AS O ON P.ProductID = O.ProductID 
WHERE O.OrderID IS NULL

--9

--10
SELECT P.ProductName, (SELECT SUM(OrderAmount) FROM Orders AS O
					   JOIN OrderDetails AS OD ON OD.OrderID = O.OrderID
					   WHERE P.ProductID = OD.ProductID AND 
					   OrderDate BETWEEN GETDATE() AND DATEADD(YEAR,-1,GETDATE()))
AS TotalSales
FROM Products AS P

--11
SELECT * FROM Employees 
WHERE (SELECT AVG(DATEDIFF(YEAR,BirthDate,GETDATE())) AS AvgAge FROM EMPLOYEES) < DATEDIFF(YEAR,BirthDate,GETDATE())

--12
SELECT * FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products)
