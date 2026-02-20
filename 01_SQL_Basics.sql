-- =====================================
-- 01_SQL_Basics.sql
-- Covers: DDL, DML, CTAS, ALTER, WHERE,
-- Constraints, Aggregations, CASE,
-- NULL handling, String functions,
-- Subqueries, Views
-- =====================================

# DAY 1

SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS de_project;
USE de_project;

DROP DATABASE IF EXISTS de_projects;

CREATE TABLE test (SNO INT, sname VARCHAR(100));

INSERT INTO test VALUES
(1,'gowtham'),
(2,'NANDHN');

SELECT * FROM test;

UPDATE test
SET sno=3, sname='pdgowtham'
WHERE sno=1;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM test WHERE sno=2;
SET SQL_SAFE_UPDATES = 1;

TRUNCATE TABLE test;
DROP TABLE IF EXISTS test;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
empid INT PRIMARY KEY,
firstname VARCHAR(100),
lastname VARCHAR(100),
hiredate DATE,
salary DECIMAL(10,2)
);

# CTAS

CREATE TABLE highsalemp AS
SELECT empid , firstname , salary
FROM employees
WHERE salary > 60000;

# TEMP TABLE

CREATE TEMPORARY TABLE he AS
SELECT empid , salary FROM employees;

# CTE

WITH highemp AS (
SELECT empid, salary
FROM he
WHERE salary > 70000
)
SELECT * FROM highemp;

# ALTER

ALTER TABLE employees ADD result VARCHAR(100);
ALTER TABLE employees DROP COLUMN firstname;
ALTER TABLE employees RENAME TO emp;

SELECT * FROM emp;
DESC emp;

# WHERE example

CREATE TABLE rides(
ride_id INT,
driver_id INT,
rider_id INT,
pickup_location VARCHAR(100),
dropoff_location VARCHAR(100),
ride_date DATETIME,
fare DECIMAL(10, 2)
);

INSERT INTO rides VALUES
(1,101,201,'Chennai','Coimbatore','2024-12-29 08:00:00',500.00),
(2,102,202,'Bangalore','Hyderabad','2024-12-29 10:00:00',800.00);

SELECT * FROM rides WHERE fare > 500;

# Constraints

CREATE TABLE drivers (
driver_id INT PRIMARY KEY,
driver_name VARCHAR(100),
license_number VARCHAR(50) UNIQUE
);

CREATE TABLE rides_fk (
ride_id INT PRIMARY KEY,
driver_id INT,
pickup_location VARCHAR(100),
dropoff_location VARCHAR(100),
ride_date DATETIME,
fare DECIMAL(10,2),
FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

# Aggregations

CREATE TABLE CustomerTransactions (
id INT PRIMARY KEY,
login_device VARCHAR(50),
customer_name VARCHAR(100),
amount DECIMAL(10, 2),
transaction_status VARCHAR(20)
);

SELECT COUNT(*) FROM CustomerTransactions;
SELECT SUM(amount) FROM CustomerTransactions;
SELECT AVG(amount) FROM CustomerTransactions;

# CASE

SELECT amount,
CASE
WHEN amount >= 4000 THEN 'High'
WHEN amount BETWEEN 2000 AND 4000 THEN 'Mid'
ELSE 'Low'
END AS category
FROM CustomerTransactions;

# NULL handling

SELECT IFNULL(email,'NA') FROM customerdata;
SELECT COALESCE(email,phone_number,address,'NA') FROM customerdata;

# String functions

SELECT
LENGTH(customer_name),
UPPER(customer_name),
SUBSTRING(customer_name,1,3),
TRIM(customer_name)
FROM customerdata;

# Subquery

SELECT customer_name,
(SELECT MAX(order_amount) FROM orders) AS max_amt
FROM customers;

# View

CREATE VIEW high_slry AS
SELECT employee_id, first_name, salary
FROM employs
WHERE salary > 60000;
