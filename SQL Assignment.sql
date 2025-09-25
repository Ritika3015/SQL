#SQL BASICS

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
consistency, and reliability of the data.*/

#Example: -
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(100) NOT NULL
);

INSERT INTO Users (UserID, Username)
VALUES (1, NULL);  -- Username is NOT NULL

#ERROR: null value in column "Username" violates not-null constraint

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
students and classes*/

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
Students.class_id=Classes.class_id;

/*8. There are three tables- orders, customers and products.
Write a query that shows all order_id, customer_name, and product_name, 
ensuring that all products are listed even if they are not associated with an order 
Hint: (use INNER JOIN and LEFT JOIN)*/

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

/* 9.Given are the two tables- sales and products
Write a query to find the total sales amount for each product 
using an INNER JOIN and the SUM() function.*/

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


/* 10. You are given three tables: orders, customers, and order_details
Write a query to display the order_id, customer_name, and the quantity of products
ordered by each customer using an INNER JOIN between all three tables.*/

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

#SQL COMMANDS

 #1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences
 -- A primary key uniquely identifies each row in a table. It must be unique and cannot be null.
 -- Here actor_id. film_id, customer_id, rental_id, and language_id are primary keys.

-- A foreign key establishes a link between tables by referencing a primary key in another table.
-- It Can have duplicate values, can be NULL (unless specified NOT NULL).
-- It ensures referential integrity.
/*
| Aspect                | Primary Key (PK)                       | Foreign Key (FK)                              |
| --------------------- | -------------------------------------- | --------------------------------------------- |
| Purpose               | Uniquely identifies records in a table | Establishes a relationship with another table |
| Uniqueness            | Must be unique                         | Can have duplicates                           |
| Nullability           | Cannot be NULL                         | Can be NULL (unless constrained)              |
| Table Dependency      | Independent                            | Depends on the referenced PK                  |
| Referential Integrity | Not enforced externally                | Enforces referential integrity                |
*/
 
 #2- List all details of actors
 SELECT  * from actor;
 
 #3 -List all customer information from DB.
 SELECT * from customer;
 
 #4 -List different countries.
 SELECT country from country;
 
 #5 -Display all active customers.
 SELECT customer_id, first_name, active from customer
 WHERE active='1';
 
 #6 -List of all rental IDs for customer with ID 1.
 SELECT rental_id, customer_id from rental
 WHERE customer_id = '1';
 
 #7 - Display all the films whose rental duration is greater than 5 .
 SELECT film_id, title, rental_duration from film
 WHERE rental_duration > 5;
 
 #8 - List the total number of films whose replacement cost is greater than $15 and less than $20.
 SELECT count(title) as total_no_of_films from film
 WHERE replacement_cost BETWEEN 15 AND 20;

 #9 - Display the count of unique first names of actors.
 SELECT COUNT(distinct first_name) from actor;
 
#10- Display the first 10 records from the customer table.
SELECT * from customer
LIMIT 10;

 #11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
 SELECT * from customer
 WHERE first_name LIKE 'b%'
 LIMIT 3;
 
 #12 -Display the names of the first 5 movies which are rated as ‘G’.
 SELECT title from film
 WHERE rating = 'G'
 LIMIT 5;
 
 #13-Find all customers whose first name starts with "a".
 SELECT * from customer
 WHERE first_name LIKE 'a%';
 
 #14- Find all customers whose first name ends with "a".
 SELECT * from customer
 WHERE first_name LIKE '%a';
 
 #15- Display the list of first 4 cities which start and end with ‘a’.
 SELECT * from city
 WHERE city LIKE 'a%a'
 LIMIT 4;
 
 #16- Find all customers whose first name have "NI" in any position.
 SELECT * from customer
 WHERE first_name LIKE '%NI%';
 
 #17- Find all customers whose first name have "r" in the second position.
 SELECT * from customer
 WHERE first_name LIKE '_r%';
 
 #18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
 SELECT * from customer
 WHERE first_name LIKE 'a%____';
 
 #19- Find all customers whose first name starts with "a" and ends with "o".
 SELECT * from customer
 WHERE first_name LIKE 'a%o';
 
 #20- Get the films with pg and pg-13 rating using IN operator.
SELECT * from film
WHERE rating IN ('PG', 'PG-13');

 #21 - Get the films with length between 50 to 100 using between operator.
 SELECT title from film
 WHERE LENGTH BETWEEN 50 AND 100;
 
 #22 - Get the top 50 actors using limit operator.
 SELECT * from actor
 LIMIT 50;
 
 #23 - Get the distinct film ids from inventory table.
 SELECT distinct film_id from inventory;
 
 #FUNCTIONS 
 
 -- Basic Aggregate Functions
 #Question 1: Retrieve the total number of rentals made in the Sakila database.
 SELECT COUNT(rental_id) as total_rentals from rental;
 
 #Question 2: Find the average rental duration (in days) of movies rented from the Sakila database.
 SELECT ROUND(AVG(DATEDIFF(return_date, rental_date)), 2) AS avg_rental_duration_days
 from rental;

 -- String Functions:
 #Question 3: Display the first name and last name of customers in uppercase.
 SELECT UPPER(first_name), UPPER (last_name) from customer;
 
 #Question 4: Extract the month from the rental date and display it alongside the rental ID.
 SELECT rental_id, MONTH(rental_date) as rental_month
 from rental;

 -- GROUP BY:
 #Question 5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
 SELECT 
    customer_id,
    COUNT(*) AS rental_count
FROM 
    rental
GROUP BY 
    customer_id
ORDER BY 
    rental_count DESC;
    
 #Question 6: Find the total revenue generated by each store.
 SELECT 
    staff_id,
    ROUND(SUM(amount), 2) AS total_revenue
FROM 
    payment
GROUP BY 
    staff_id
ORDER BY 
    total_revenue DESC;

 #Question 7: Determine the total number of rentals for each category of movies.
 SELECT 
    c.name AS category,
    COUNT(r.rental_id) AS total_rentals
FROM 
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    total_rentals DESC;

#Question 8: Find the average rental rate of movies in each language.
SELECT 
    l.name AS language,
    ROUND(AVG(f.rental_rate), 2) AS avg_rental_rate
FROM 
    film f
JOIN 
    language l
ON 
    f.language_id = l.language_id
GROUP BY 
    l.name
ORDER BY 
    avg_rental_rate DESC;

#JOINS

 #Questions 9 -Display the title of the movie, customer s first name, and last name who rented it.
 SELECT 
    f.title,
    c.first_name,
    c.last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id;

 #Question 10:
SELECT 
    f.title,
    c.first_name,
    c.last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id;

 
 #Question 11: Retrieve the customer names along with the total amount they've spent on rentals.
 SELECT 
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

 #Question 12: List the titles of movies rented by each customer in a particular city (e.g., 'London').
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    f.title AS rented_movie
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
ORDER BY c.customer_id, f.title;
 
 #Question 13: Display the top 5 rented movies along with the number of times they've been rented.
 SELECT 
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 5;

 #Question 14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2
ORDER BY c.customer_id;

#WINDOWS FUNCTIONS:

 #1. Rank the customers based on the total amount they've spent on rentals.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS rank_position
FROM customer c
JOIN payment p 
    ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

 #2. Calculate the cumulative revenue generated by each film over time.
 SELECT 
    f.film_id,
    f.title,
    DATE(p.payment_date) AS revenue_date,
    SUM(p.amount) AS daily_revenue,
    SUM(SUM(p.amount)) OVER (
        PARTITION BY f.film_id 
        ORDER BY DATE(p.payment_date)
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.film_id, f.title, DATE(p.payment_date)
ORDER BY f.film_id, revenue_date;

 #3. Determine the average rental duration for each film, considering films with similar lengths.
 SELECT 
    CASE 
        WHEN f.length < 60 THEN 'Short (<60 mins)'
        WHEN f.length BETWEEN 60 AND 100 THEN 'Medium (60–100 mins)'
        WHEN f.length BETWEEN 101 AND 150 THEN 'Long (101–150 mins)'
        ELSE 'Very Long (>150 mins)'
    END AS length_category,
    AVG(f.rental_duration) AS avg_rental_duration
FROM film f
GROUP BY length_category
ORDER BY avg_rental_duration DESC;

 #4. Identify the top 3 films in each category based on their rental counts.
WITH film_rentals AS (
    SELECT 
        c.name AS category_name,
        f.title,
        COUNT(r.rental_id) AS rental_count,
        RANK() OVER (
            PARTITION BY c.name 
            ORDER BY COUNT(r.rental_id) DESC
        ) AS rank_in_category
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.name, f.title
)
SELECT *
FROM film_rentals
WHERE rank_in_category <= 3
ORDER BY category_name, rank_in_category;

 #5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
 SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_rentals,
    (SELECT AVG(rental_count)
     FROM (
        SELECT COUNT(r2.rental_id) AS rental_count
        FROM rental r2
        GROUP BY r2.customer_id
     ) AS sub
    ) AS avg_rentals,
    COUNT(r.rental_id) - (
        SELECT AVG(rental_count)
        FROM (
            SELECT COUNT(r2.rental_id) AS rental_count
            FROM rental r2
            GROUP BY r2.customer_id
        ) AS sub
    ) AS rental_diff
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY rental_diff DESC;

 #6. Find the monthly revenue trend for the entire rental store over time.
 SELECT 
    DATE_FORMAT(p.payment_date, '%Y-%m') AS month,
    SUM(p.amount) AS total_revenue
FROM payment p
GROUP BY DATE_FORMAT(p.payment_date, '%Y-%m')
ORDER BY month;

 #7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
 WITH customer_spending AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_spent,
        PERCENT_RANK() OVER (ORDER BY SUM(p.amount)) AS spend_percentile
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT *
FROM customer_spending
WHERE spend_percentile >= 0.8
ORDER BY total_spent DESC;

 #8. Calculate the running total of rentals per category, ordered by rental count.
 SELECT 
    c.name AS category_name,
    COUNT(r.rental_id) AS rental_count,
    SUM(COUNT(r.rental_id)) OVER (
        ORDER BY COUNT(r.rental_id) DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_rentals
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY rental_count DESC;

 #9. Find the films that have been rented less than the average rental count for their respective categories.
 WITH film_rentals AS (
    SELECT 
        f.film_id,
        f.title,
        c.category_id,
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY f.film_id, f.title, c.category_id, c.name
),
category_avg AS (
    SELECT 
        category_id,
        AVG(rental_count) AS avg_rentals
    FROM film_rentals
    GROUP BY category_id
)
SELECT 
    fr.film_id,
    fr.title,
    fr.category_name,
    fr.rental_count,
    ca.avg_rentals
FROM film_rentals fr
JOIN category_avg ca ON fr.category_id = ca.category_id
WHERE fr.rental_count < ca.avg_rentals
ORDER BY fr.category_name, fr.rental_count ASC;

 #10. Identify the top 5 months with the highest revenue and display the revenue generated in each month
 SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS total_revenue
FROM payment
GROUP BY month
ORDER BY total_revenue DESC
LIMIT 5;

#NORMALISATION & CTE: -

/* 1. First Normal Form (1NF):
a. Identify a table in the Sakila database that violates 1NF. Explain how you
would normalize it to achieve 1NF.

1NF requires that a table has atomic (indivisible) values no repeating groups
or arrays each record is uniquely identified.
The column special_features stores multiple values in a single field (comma-separated
or as a SET). → violates 1NF.*/

#To normalize to 1NF:
#Create a child table to store each feature as a separate row.
 CREATE TABLE film_special_feature (
    film_id INT,
    feature VARCHAR(50),
    PRIMARY KEY(film_id, feature),
    FOREIGN KEY(film_id) REFERENCES film(film_id)
);

/*2. Second Normal Form (2NF): a. Choose a table in Sakila and describe how you would 
determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it.

A table is in 2NF if it’s already in 1NF and every non-key attribute is fully dependent
on the entire primary key (no partial dependency).
Candidate: film_category
| film_id (PK) | category_id (PK) | last_update |
PK = (film_id, category_id).
All non-key attributes (last_update) depend on both columns → no partial dependency. 
Already in 2NF.

Here title depends only on film_id, not on the composite key (rental_id, film_id).
To achieve 2NF → move title into film
*/

/*3. Third Normal Form (3NF): a. Identify a table in Sakila that violates 3NF. Describe
the transitive dependencies present and outline the steps to normalize the table to 3NF.

A table is in 3NF if it’s in 2NF and no transitive dependencies (non-key attributes 
should not depend on other non-key attributes).
Candidate: staff
staff_id	first_name	last_name	address_id	city	country
city depends on address_id (not on PK directly).
country depends on city.
→ staff violates 3NF.

To normalize to 3NF: Break into related tables 
(already done in Sakila: staff → address → city → country)
*/

/* 4. Normalization Process: Take a specific table in Sakila and guide through the
 process of normalizing it from the initial unnormalized form up to at least 2NF.
 
 Step1 → Convert UNF to 1NF
Split multivalued columns (if any).
Ensure atomic values*/

CREATE TABLE rental_1nf (
    rental_id INT PRIMARY KEY,
    customer_id INT,
    phone VARCHAR(20),
    film_id INT,
    category VARCHAR(20),
    rental_date DATETIME
);

/*Step → 2NF
Remove partial dependencies. phone depends only on customer_id.
category depends only on film_id.*/

CREATE TABLE customer_phone (
    customer_id INT PRIMARY KEY,
    phone VARCHAR(20)
);

CREATE TABLE film_category_temp (
    film_id INT,
    category VARCHAR(20),
    PRIMARY KEY(film_id, category)
);
#rental now only stores keys.

/*Step → 3NF
Check for transitive dependencies.
(e.g., if category → late_fee_rate, that belongs in category table.)
*/

/*5. CTE Basics: a. Write a query using a CTE to retrieve the distinct list of
actor names and the number of films they have acted in from the actor and
film_actor tables.*/

WITH actor_film_count AS (
    SELECT 
        a.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
        COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, a.first_name, a.last_name
)
SELECT actor_name, film_count
FROM actor_film_count
ORDER BY film_count DESC;

/*6. CTE with Joins: a. Create a CTE that combines information from the film
and language tables to display the film title, language name, and rental rate.*/

WITH film_language AS (
    SELECT 
        f.film_id,
        f.title,
        l.name AS language_name,
        f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT title, language_name, rental_rate
FROM film_language
ORDER BY title;
  
/* 7.CTE for Aggregation: a. Write a query using a CTE to find the total 
revenue generated by each customer (sum of payments) from the customer and
payment tables.*/

WITH customer_revenue AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(p.amount) AS total_revenue
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT customer_name, total_revenue
FROM customer_revenue
ORDER BY total_revenue DESC;

/* 8.CTE with Window Functions: a. Utilize a CTE with a window function to 
rank films based on their rental duration from the film table.*/

WITH film_rank AS (
    SELECT 
        film_id,
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS duration_rank
    FROM film
)
SELECT *
FROM film_rank
ORDER BY duration_rank;
 
/* 9.CTE and Filtering: a. Create a CTE to list customers who have made more
than two rentals, and then join this CTE with the customer table to retrieve 
additional customer details.*/

WITH frequent_renters AS (
    SELECT customer_id, COUNT(*) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > 2
)
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    f.rental_count
FROM frequent_renters f
JOIN customer c ON f.customer_id = c.customer_id
ORDER BY f.rental_count DESC;
            
/* 10.CTE for Date Calculations:
 a. Write a query using a CTE to find the total number of rentals made each month,
considering the rental_date from the rental table.*/

WITH monthly_rentals AS (
    SELECT 
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(*) AS rentals_count
    FROM rental
    GROUP BY DATE_FORMAT(rental_date, '%Y-%m')
)
SELECT rental_month, rentals_count
FROM monthly_rentals
ORDER BY rental_month;


/* 11.CTE and Self-Join:
 a. Create a CTE to generate a report showing pairs of actors who have appeared
 in the same film together, using the film_actor table.*/

WITH actor_pairs AS (
    SELECT 
        fa1.film_id,
        fa1.actor_id AS actor1,
        fa2.actor_id AS actor2
    FROM film_actor fa1
    JOIN film_actor fa2 
        ON fa1.film_id = fa2.film_id
       AND fa1.actor_id < fa2.actor_id
)
SELECT 
    ap.film_id,
    CONCAT(a1.first_name, ' ', a1.last_name) AS actor1_name,
    CONCAT(a2.first_name, ' ', a2.last_name) AS actor2_name
FROM actor_pairs ap
JOIN actor a1 ON ap.actor1 = a1.actor_id
JOIN actor a2 ON ap.actor2 = a2.actor_id
ORDER BY ap.film_id, actor1_name;

/*12. CTE for Recursive Search:
 a. Implement a recursive CTE to find all employees in the staff table who report
 to a specific manager, considering the reports_to column.*/

WITH RECURSIVE reporting_staff AS (
    -- Anchor member: direct reports of the manager
    SELECT 
        staff_id,
        first_name,
        last_name,
        reports_to
    FROM staff
    WHERE reports_to = 2

    UNION ALL

    -- Recursive member: find employees reporting to previous level
    SELECT 
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM staff s
    INNER JOIN reporting_staff rs ON s.reports_to = rs.staff_id
)
SELECT *
FROM reporting_staff
ORDER BY staff_id;




 
 