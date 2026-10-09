-- Question 5: Online Shopping Management System
-- A. Theory:
-- Explain how INSERT, UPDATE, and DELETE commands are used to modify records in SQL. Explain how GROUP BY is used with aggregate functions such as COUNT(), SUM(), and AVG() to summarize data. Also explain how HAVING differs from WHERE when filtering query results.
-- B. Practical:
-- Create an Online Shopping Management System using Customer and Orders tables.
-- 1. Create both tables with suitable attributes and apply Primary Key and Foreign Key constraints.
-- 2. Apply suitable NOT NULL, UNIQUE, DEFAULT, and CHECK constraints.
-- 3. Insert at least 5 customer records and 5 order records.
-- 4. Display orders whose total amount is greater than ₹5,000.
-- 5. Calculate the total order amount for each customer using GROUP BY and SUM().
-- 6. Display customers whose total order amount exceeds ₹10,000 using HAVING.
-- 7. Find the average order amount using AVG().
-- 8. Update the status of a particular order.
-- 9. Delete an order based on a suitable condition.
-- 10. Add a new column to the Orders table using ALTER.
-- 11. Display the final order records.
-- QUESTION 5: ONLINE SHOPPING MANAGEMENT SYSTEM

DROP DATABASE IF EXISTS OnlineShopping;
CREATE DATABASE OnlineShopping;
USE OnlineShopping;
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(50) DEFAULT 'chd',
    age INT CHECK (age >= 18)
);
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount > 0),
    status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
INSERT INTO Customer VALUES
(1, 'Hariom Mishra', 'rl@gmail.com', 'Delhi', 22),
(2, 'Piyush bhai a', 'ya@gmail.com', 'Mumbai', 24),
(3, 'Pawan  Singh', 'a@gmail.com', 'Chandigarh', 21),
(4, 'Neha singh', 'nea@gmail.com', 'Lucknow', 23),
(5, 'Rohit Kumar', 'rohit@gmail.com', 'Jaipur', 25);
INSERT INTO Orders VALUES
(101,1, '2026-10-01',6000, 'Delivered'),
(102,1, '2026-10-02', 5000, 'Pending'),
(103,2, '2026-10-03', 7500, 'Shipped'),
(104,2, '2026-10-04', 4000, 'Delivered'),
(105,3, '2026-10-05', 12000, 'Pending'),
(106,4, '2026-10-06', 3000, 'Shipped'),
(107,5, '2026-10-07', 8500, 'Delivered');
SELECT *
FROM Orders
WHERE total_amount > 5000;
SELECT c.customer_id, c.customer_name,
       SUM(o.total_amount) AS total_order_amount
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;
SELECT c.customer_id, c.customer_name,
       SUM(o.total_amount) AS total_order_amount
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) > 10000;
SELECT AVG(total_amount) AS average_order_amount
FROM Orders;
UPDATE Orders
SET status = 'Delivered'
WHERE order_id = 102;
DELETE FROM Orders
WHERE order_id = 106;
ALTER TABLE Orders
ADD payment_method VARCHAR(30) DEFAULT 'Cash';
SELECT *
FROM Orders;
