/* 1. Create a table called employees with the following structure
 emp_id (integer, should not be NULL and should be a primary key)
 emp_name (text, should not be NULL)
 age (integer, should have a check constraint to ensure the age is at least 18)
 email (text, should be unique for each employee)
 salary (decimal, with a default value of 30,000).
 Write the SQL query to create the above table with all constraints.*/

 CREATE Database Employees_Details;
 USE Employees_Details;
 CREATE Table Employees(
	emp_id int PRIMARY KEY,
	emp_name char(10) NOT NULL,
	age int CHECK (age>=18),
	email VARCHAR(30) UNIQUE,
	salary float DEFAULT('30000')
 )
SELECT * from Employees;

/*2. Explain the purpose of constraints and how they help maintain data integrity
 in a database. Provide examples of common types of constraints.
 
Constraints are rules applied to columns in a databse to enforce data integrity,
accuracy, and consistency. They ensure that only valid data is entered into 
the database and prevent accidentalor malicious corruption of data.

Constraints Help Maintain Data Integrity by: -

-- Prevent invalid data (e.g., no negative ages or null values where not allowed)
-- Enforce relationships between tables (e.g., foreign keys)
-- Ensure uniqueness of data (e.g., no duplicate emails)
-- Provide default values if none are supplied
-- Automate integrity checks without needing manual logic

Examples of Common types of constraints: -

-- 1) NOT NULL- Name VARCHAR(50) NOT NULL
-- 2) PRIMARY KEY- Employee_ID INT PRIMARY KEY
-- 3) FOREIGN KEY- UserID INT REFERENCES Users(ID)
-- 4) UNIQUE- Email VARCHAR(50)UNIQUE
-- 5) CHECK- Age INT CHECK (Age >= 18)
-- 6) DEFAULT Status VARCHAR(10) DEFAULT 'active'
*/  

/* 3.Why would you apply the NOT NULL constraint to a column? Can a primary key 
contain NULL values? Justify your answer.
The NOT NULL constraint is used to ensure that a column always contains a value. 
It cannot be left empty.
No, a primary key can never contain null values.
A primary key is meant to uniquely identify every row in a table. NULL means 
"unknown" or "missing". 
*/

/* 4. Explain the steps and SQL commands used to add or remove constraints on an
 existing table. Provide an example for both adding and removing a constraint.
 
 Steps to Add a Constraint: -
-- Identify the type of constraint to add (NOT NULL, UNIQUE, CHECK, FOREIGN KEY, etc.).
-- Use the ALTER TABLE statement with ADD CONSTRAINT.
 Example: -
ALTER TABLE Employees
ADD CONSTRAINT chk_age CHECK (Age >= 18);

 Steps to Remove a Constraint: -
-- Find the name of the constraint (you need the exact name).
-- Use the ALTER TABLE statement with DROP CONSTRAINT.
 Example: -
ALTER TABLE Employees
DROP CONSTRAINT chk_age;
*/

/* 5. Explain the consequences of attempting to insert, update, or delete data in a 
way that violates constraints. Provide an example of an error message that might occur 
when violating a constraint. 

When you try to insert, update, or delete data in a way that violates a constraint,
the database rejects the operation and returns an error. This protects the integrity,
consistency, and reliability of the data.

Example: -
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(100) NOT NULL
);

INSERT INTO Users (UserID, Username)
VALUES (1, NULL);  -- Username is NOT NULL

ERROR: null value in column "Username" violates not-null constraint
*/

/*6. You created a products table without constraints as follows:
 CREATE TABLE products (
 product_id INT,
 product_name VARCHAR(50),
 price DECIMAL(10, 2));
 Now, you realise that
 The product_id should be a primary key
 The price should have a default value of 50.00*/
 
CREATE TABLE products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(50),
	price DECIMAL(10, 2) DEFAULT 50.00
);

/*  7. You have two tables:
students and classes

CREATE Table Students (
	student_id INT PRIMARY KEY,
	student_name VARCHAR(50) UNIQUE,
	class_id INT
);
INSERT INTO Students (student_id,student_name,class_id)
VALUES 
('1', 'Alice', '101'),
('2', 'Bob', '102'),
('3', 'Charlie', '101');

CREATE Table Classes (
	class_id INT PRIMARY KEY,
	class_name VARCHAR(50) UNIQUE
);
INSERT INTO Classes (class_id, class_name)
VALUES 
('101', 'Math'),
('102', 'Science'),
('103', 'History');

SELECT student_name, class_name from 
Students INNER JOIN Classes
on
Students.class_id=Classes.class_id
*/

/*8. There are three tables- orders, customers and products.
Write a query that shows all order_id, customer_name, and product_name, 
ensuring that all products are listed even if they are not associated with an order 
Hint: (use INNER JOIN and LEFT JOIN)

CREATE Table Orders(
	order_id INT PRIMARY KEY,
    order_date DATE ,
    customer_id INT UNIQUE
);
INSERT INTO Orders (order_id, order_date, customer_id)
VALUES
('1', '2024-01-01', '101'),
('2', '2024-01-03', '102');

CREATE Table Customers(
	customer_id INT PRIMARY KEY,
    customer_name CHAR(20) UNIQUE
);
INSERT INTO Customers (customer_id, customer_name)
VALUES
('101', 'Alice'),
('102', 'Bob');

CREATE Table Products(
	product_id INT PRIMARY KEY,
    product_name CHAR(20) UNIQUE,
    order_id CHAR(10) NOT NULL
);
INSERT INTO Products (product_id, product_name, order_id)
VALUES
('1', 'Laptop', '1'),
('2', 'Phone', 'NULL');

SELECT 
    o.order_id,
    c.customer_name,
    p.product_name
FROM 
    Orders o
LEFT JOIN Products p ON o.order_id = p.order_id
LEFT JOIN Customers c ON o.customer_id = c.customer_id

UNION

SELECT 
    p.order_id,
    NULL AS customer_name,
    p.product_name
FROM 
    Products p
LEFT JOIN Orders o ON p.order_id = o.order_id
WHERE o.order_id IS NULL;
*/

/* 9.Given are the two tables- sales and products
Write a query to find the total sales amount for each product 
using an INNER JOIN and the SUM() function.

CREATE Table Sales(
	sale_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    amount FLOAT
);
INSERT INTO Sales (sale_id, product_id, amount)
VALUES
('1', '101', '500'),
('2', '102', '300'),
('3', '101', 700);

CREATE Table Products (
	product_id INT PRIMARY KEY,
    product_name CHAR(20) UNIQUE
);
INSERT INTO Products (product_id, product_name)
VALUES
('101', 'Laptop'),
('102', 'Phone');

SELECT 
    p.product_name,
    SUM(s.amount) AS total_sales
FROM 
    Sales s
INNER JOIN Products p ON s.product_id = p.product_id
GROUP BY 
    p.product_name;
*/

/* 10. You are given three tables: orders, customers, and order_details
Write a query to display the order_id, customer_name, and the quantity of products
ordered by each customer using an INNER JOIN between all three tables.

CREATE Table Orders(
	order_id INT PRIMARY KEY,
    order_date DATE ,
    customer_id INT UNIQUE
);
INSERT INTO Orders (order_id, order_date, customer_id)
VALUES
('1', '2024-01-02', '1'),
('2', '2024-01-05', '2');

CREATE Table Customers(
	customer_id INT PRIMARY KEY,
    customer_name CHAR(20) UNIQUE
);
INSERT INTO Customers (customer_id, customer_name)
VALUES
('1', 'Alice'),
('2', 'Bob');

CREATE Table Order_Details(
	order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT
);
INSERT INTO Order_Details (order_id, product_id, quantity)
VALUES
('1', '101', '2'),
('1', '102', '1'),
('2', '101', '3');

SELECT 
    o.order_id,
    c.customer_name,
    od.quantity
FROM 
    Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN Order_Details od ON o.order_id = od.order_id;
*/



 
 