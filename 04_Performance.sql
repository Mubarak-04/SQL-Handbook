-- =====================================
-- 04_Performance.sql
-- Covers: Index, Explain, Partitioning,
-- Subpartition, Partition pruning
-- =====================================

USE de_project;

-- INDEX
DROP TABLE IF EXISTS customers1;

CREATE TABLE customers1 (
customer_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100),
city VARCHAR(50)
);

CREATE INDEX index_eml ON customers1(email);

EXPLAIN SELECT * FROM customers1 WHERE email='[michael.brown@example.com](mailto:michael.brown@example.com)';
EXPLAIN FORMAT=JSON SELECT * FROM customers1 WHERE email='[michael.brown@example.com](mailto:michael.brown@example.com)';

-- RANGE PARTITION
DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
order_id INT NOT NULL AUTO_INCREMENT,
order_date DATE NOT NULL,
customer_id INT,
order_amount DECIMAL(10,2),
PRIMARY KEY (order_id, order_date)
)
PARTITION BY RANGE (YEAR(order_date)) (
PARTITION p_before_2020 VALUES LESS THAN (2020),
PARTITION p_2020 VALUES LESS THAN (2021),
PARTITION p_2021 VALUES LESS THAN (2022),
PARTITION p_future VALUES LESS THAN MAXVALUE
);

EXPLAIN FORMAT=JSON SELECT * FROM orders WHERE order_date='2020-01-15';

-- LIST PARTITION
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
employee_id INT AUTO_INCREMENT,
first_name VARCHAR(50),
last_name VARCHAR(50),
department VARCHAR(50),
PRIMARY KEY(employee_id,department)
)
PARTITION BY LIST COLUMNS (department) (
PARTITION p_sales VALUES IN ('Sales'),
PARTITION p_hr VALUES IN ('HR'),
PARTITION p_engineering VALUES IN ('Engineering','DevOps'),
PARTITION p_other VALUES IN ('Finance','Marketing')
);

EXPLAIN FORMAT=JSON
SELECT * FROM employees WHERE department='HR';

-- HASH PARTITION
CREATE TABLE sens
