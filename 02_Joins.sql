-- =====================================
-- 02_Joins.sql
-- Covers: Inner, Left, Right, Cross,
-- Group Join, Self Join, Full Outer Join
-- =====================================

USE de_project;

DROP TABLE IF EXISTS branch;
DROP TABLE IF EXISTS employee;

CREATE TABLE branch (
branch_id INT PRIMARY KEY,
branch_name VARCHAR(50),
location VARCHAR(50)
);

CREATE TABLE employee (
emp_id INT PRIMARY KEY,
ename VARCHAR(50),
job_desc VARCHAR(50),
salary INT,
branch_id INT
);

INSERT INTO branch VALUES
(1, 'Chennai', 'Tamil Nadu'),
(2, 'Bangalore', 'Karnataka'),
(3, 'Hyderabad', 'Telangana'),
(4, 'Mumbai', 'Maharashtra');

INSERT INTO employee VALUES
(11, 'Akshay', 'ENGINEER', 1000000, 1),
(12, 'John', 'ADMIN', 2200000, 1),
(13, 'Abinaya', 'ENGINEER', 2100000, 2),
(14, 'Vidya', 'ADMIN', 2200000, NULL),
(15, 'Ranjani', 'ENGINEER', 2100000, NULL),
(16, 'Karthik', 'MANAGER', 3000000, 3);

-- INNER JOIN
SELECT e.emp_id,e.ename,e.branch_id,b.branch_name
FROM employee e
INNER JOIN branch b
ON e.branch_id = b.branch_id;

-- LEFT JOIN
SELECT e.emp_id,e.ename,e.branch_id,b.branch_name
FROM employee e
LEFT JOIN branch b
ON e.branch_id = b.branch_id
ORDER BY e.emp_id;

-- RIGHT JOIN
SELECT e.emp_id,e.ename,e.branch_id,b.branch_name
FROM employee e
RIGHT JOIN branch b
ON e.branch_id = b.branch_id;

-- CROSS JOIN
SELECT e.ename,b.branch_name
FROM employee e
CROSS JOIN branch b;

-- GROUP JOIN
SELECT b.branch_name, COUNT(e.emp_id) AS emp_count
FROM branch b
JOIN employee e
ON e.branch_id = b.branch_id
GROUP BY b.branch_id;

-- SELF JOIN (manager example)
DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees (
id INT PRIMARY KEY,
name VARCHAR(50),
manager_id INT
);

INSERT INTO Employees VALUES
(1, 'Alice', 3),
(2, 'Bob', 3),
(3, 'Charlie', NULL),
(4, 'Diana', 3);

SELECT e.name AS emp_name, m.name AS manager_name
FROM Employees e
LEFT JOIN Employees m
ON e.manager_id = m.id;

-- FULL OUTER JOIN simulation
SELECT
e.employee_id,
e.first_name,
e.salary AS emp_salary,
h.salary AS high_salary
FROM employs e
LEFT JOIN high_slry h
ON e.employee_id = h.employee_id

UNION

SELECT
e.employee_id,
e.first_name,
e.salary AS emp_salary,
h.salary AS high_salary
FROM employs e
RIGHT JOIN high_slry h
ON e.employee_id = h.employee_id;
