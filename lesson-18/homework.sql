

--Level 1: Basic Subqueries

---1. Find Employees with Minimum Salary

CREATE TABLE employees ( 
	id INT PRIMARY KEY, 
	name VARCHAR(100), 
	salary DECIMAL(10, 2) 
);

INSERT INTO employees (id, name, salary) 
VALUES 
(1, 'Alice', 50000), 
(2, 'Bob', 60000), 
(3, 'Charlie', 50000);

SELECT * FROM Employees
WHERE Salary =  (SELECT MIN(Salary) FROM Employees) 

---2. Find Products Above Average Price

CREATE TABLE products ( 
	id INT PRIMARY KEY, 
	product_name VARCHAR(100), 
	price DECIMAL(10, 2) 
);

INSERT INTO products (id, product_name, price) 
VALUES 
(1, 'Laptop', 1200), 
(2, 'Tablet', 400), 
(3, 'Smartphone', 800), 
(4, 'Monitor', 300);

SELECT * FROM products
WHERE price > (SELECT AVG(price) FROM products)

--Level 2: Nested Subqueries with Conditions

---3. Find Employees in Sales Department

CREATE TABLE departments ( 
	id INT PRIMARY KEY, 
	department_name VARCHAR(100) 
);

CREATE TABLE employees1 ( 
	id INT PRIMARY KEY, 
	name VARCHAR(100), 
	department_id INT, 
	FOREIGN KEY (department_id) REFERENCES departments(id) 
);

INSERT INTO departments (id, department_name) 
VALUES 
(1, 'Sales'), 
(2, 'HR');

INSERT INTO employees1 (id, name, department_id) 
VALUES 
(1, 'David', 1), 
(2, 'Eve', 2), 
(3, 'Frank', 1);

SELECT * FROM departments
SELECT * FROM employees1

SELECT * FROM employees1 AS E
JOIN departments AS D ON E.department_id = D.id
WHERE D.department_name = 'Sales'

---4. Find Customers with No Orders

CREATE TABLE customers ( 
	customer_id INT PRIMARY KEY, 
	name VARCHAR(100) 
);

CREATE TABLE orders ( 
	order_id INT PRIMARY KEY, 
	customer_id INT, 
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
);

INSERT INTO customers (customer_id, name) 
VALUES 
(1, 'Grace'), 
(2, 'Heidi'), 
(3, 'Ivan');

INSERT INTO orders (order_id, customer_id) 
VALUES 
(1, 1), 
(2, 1);

SELECT * FROM customers
SELECT * FROM orders

SELECT C.name FROM orders AS O
RIGHT JOIN customers AS C ON C.customer_id = O.customer_id
WHERE O.order_id IS NULL

--Level 3: Aggregation and Grouping in Subqueries

---5. Find Products with Max Price in Each Category

CREATE TABLE products1 ( 
	id INT PRIMARY KEY, 
	product_name VARCHAR(100), 
	price DECIMAL(10, 2), 
	category_id INT 
);

INSERT INTO products1 (id, product_name, price, category_id) 
VALUES 
(1, 'Tablet', 400, 1), 
(2, 'Laptop', 1500, 1), 
(3, 'Headphones', 200, 2), 
(4, 'Speakers', 300, 2);

SELECT * FROM products1 AS A
WHERE price = (SELECT MAX(price) FROM products1 AS B WHERE A.category_id = B.category_id)

---6. Find Employees in Department with Highest Average Salary

CREATE TABLE departments1 ( 
	id INT PRIMARY KEY, 
	department_name VARCHAR(100) 
);

CREATE TABLE employees2 ( 
	id INT PRIMARY KEY, 
	name VARCHAR(100), 
	salary DECIMAL(10, 2), 
	department_id INT, 
	FOREIGN KEY (department_id) REFERENCES departments(id) 
);

INSERT INTO departments1 (id, department_name) 
VALUES 
(1, 'IT'), 
(2, 'Sales');

INSERT INTO employees2 (id, name, salary, department_id) 
VALUES 
(1, 'Jack', 80000, 1), 
(2, 'Karen', 70000, 1), 
(3, 'Leo', 60000, 2);

SELECT * FROM departments1
SELECT * FROM employees2

SELECT E2.name FROM employees2 AS E2
FULL JOIN (SELECT TOP (1) * FROM (SELECT  AVG(E.salary) AvgSalary,
		D.id	
FROM employees2 AS E
JOIN departments1 AS D ON E.department_id = D.id
GROUP BY D.id) AS A
ORDER BY AvgSalary DESC) AS D1 ON D1.id = E2.department_id
WHERE E2.department_id = (SELECT TOP (1) id FROM (SELECT  AVG(E.salary) AvgSalary,
		D.id	
FROM employees2 AS E
JOIN departments1 AS D ON E.department_id = D.id
GROUP BY D.id) AS B)

--Level 4: Correlated Subqueries

---7. Find Employees Earning Above Department Average

CREATE TABLE employees ( 
	id INT PRIMARY KEY, 
	name VARCHAR(100), 
	salary DECIMAL(10, 2),
	department_id INT );

INSERT INTO employees (id, name, salary, department_id) 
VALUES 
(1, 'Mike', 50000, 1), 
(2, 'Nina', 75000, 1), 
(3, 'Olivia', 40000, 2), 
(4, 'Paul', 55000, 2);

SELECT * FROM employees AS A
WHERE salary > (SELECT AVG(salary) FROM employees AS B WHERE A.department_id = B.department_id)

---8. Find Students with Highest Grade per Course

CREATE TABLE students ( 
	student_id INT PRIMARY KEY, 
	name VARCHAR(100) 
);

CREATE TABLE grades ( 
	student_id INT, course_id INT, 
	grade DECIMAL(4, 2), 
	FOREIGN KEY (student_id) REFERENCES students(student_id) 
);

INSERT INTO students (student_id, name) 
VALUES 
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) 
VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);

SELECT * FROM students
SELECT * FROM grades

SELECT B.name, A.course_id, (SELECT MAX(G.grade) AS MaxGrade FROM students AS S
JOIN grades AS G ON S.student_id = G.student_id WHERE A.course_id = G.course_id) AS MaxGrade FROM grades AS A
JOIN students AS B ON B.student_id = A.student_id
WHERE A.grade = (SELECT MAX(G.grade) AS MaxGrade FROM students AS S
JOIN grades AS G ON S.student_id = G.student_id WHERE A.course_id = G.course_id)

--Level 5: Subqueries with Ranking and Complex Conditions

---9. Find Third-Highest Price per Category

CREATE TABLE products ( 
	id INT PRIMARY KEY, 
	product_name VARCHAR(100),
	price DECIMAL(10, 2),
	category_id INT
);

INSERT INTO products (id, product_name, price, category_id)
VALUES
(1, 'Phone', 800, 1), 
(2, 'Laptop', 1500, 1), 
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1), 
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);

SELECT * FROM products AS A
WHERE price = (SELECT price FROM products AS B WHERE A.category_id = B.category_id ORDER BY price DESC OFFSET 2 ROWS FETCH NEXT 1 ROW ONLY)

---10. Find Employees Between Company Average and Department Max Salary

CREATE TABLE employees ( 
	id INT PRIMARY KEY, 
	name VARCHAR(100), 
	salary DECIMAL(10, 2),
	department_id INT
);

INSERT INTO employees (id, name, salary, department_id) 
VALUES 
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2), 
(5, 'Evan', 75000, 1);

SELECT * FROM employees AS A
WHERE Salary BETWEEN (SELECT AVG(salary) AvgSalary FROM employees) AND (SELECT MAX(salary) MaxSalary FROM employees AS B WHERE B.department_id = A.department_id)
 





























