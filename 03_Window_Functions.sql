-- =====================================
-- 03_Window_Functions.sql
-- Covers: Aggregate window, Ranking,
-- lag, lead, first_value, last_value,
-- nth_value
-- =====================================

USE de_project;

-- Running SUM
CREATE TABLE sales (
TransactionID INT PRIMARY KEY,
Store VARCHAR(10),
SalesAmount DECIMAL(10,2)
);

INSERT INTO sales VALUES
(1,'A',100.00),
(2,'A',200.00),
(3,'A',150.00),
(4,'B',250.00),
(5,'B',300.00);

SELECT store, salesamount,
SUM(salesamount) OVER (PARTITION BY store ORDER BY transactionid DESC) AS tot_amt
FROM sales;

-- ROW_NUMBER (dedup usecase)
DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees (
EmployeeID INT,
Name VARCHAR(100),
Department VARCHAR(50),
HireDate DATE
);

INSERT INTO Employees VALUES
(1,'Alice','HR','2020-05-01'),
(1,'Alice','HR','2022-06-15'),
(2,'Bob','IT','2021-07-10'),
(3,'Charlie','Finance','2020-09-30'),
(3,'Charlie','Finance','2022-05-22');

WITH employrank AS (
SELECT *,
ROW_NUMBER() OVER(PARTITION BY employeeid ORDER BY hiredate ASC) AS rownum
FROM Employees
)
SELECT EmployeeID, Name, Department, HireDate
FROM employrank
WHERE rownum = 1;

-- RANK / DENSE_RANK
CREATE TABLE students (
StudentID INT,
StudentName VARCHAR(100),
ExamScore INT
);

INSERT INTO students VALUES
(1,'Alice',95),
(2,'Bob',90),
(3,'Charlie',95),
(4,'David',85),
(5,'Eva',90);

SELECT *,
RANK() OVER(ORDER BY examscore DESC) AS score_rank
FROM students;

SELECT *,
DENSE_RANK() OVER(ORDER BY examscore DESC) AS score_rank
FROM students;

-- PERCENT_RANK
SELECT *,
PERCENT_RANK() OVER(ORDER BY examscore DESC) AS per_rank
FROM students;

-- NTILE
CREATE TABLE EmployeeSales (
EmployeeID INT,
EmployeeName VARCHAR(100),
SalesAmount INT
);

INSERT INTO EmployeeSales VALUES
(1,'Alice',10000),
(2,'Bob',8500),
(3,'Charlie',7500),
(4,'David',6000),
(5,'Eva',11000),
(6,'Frank',4500),
(7,'Grace',3000),
(8,'Hank',4000),
(9,'Ivy',8000),
(10,'Jack',9500);

SELECT *,
NTILE(3) OVER(ORDER BY salesamount DESC) AS bucket
FROM EmployeeSales;

-- LAG
CREATE TABLE EmployeeSalaries (
EmployeeID INT,
EmployeeName VARCHAR(100),
Salary DECIMAL(10,2),
Year INT
);

INSERT INTO EmployeeSalaries VALUES
(1,'Alice',5000,2023),
(1,'Alice',5500,2024),
(2,'Bob',4500,2023),
(2,'Bob',4800,2024);

SELECT *,
LAG(salary) OVER(PARTITION BY employeeid ORDER BY year) AS prev_salary,
salary - LAG(salary) OVER(PARTITION BY employeeid ORDER BY year) AS diff
FROM EmployeeSalaries;

-- LEAD
CREATE TABLE ProductSales (
ProductID INT,
ProductName VARCHAR(100),
SaleAmount DECIMAL(10,2),
SaleDate DATE
);

INSERT INTO ProductSales VALUES
(1,'Product A',500,'2025-01-01'),
(2,'Product A',400,'2025-02-02'),
(3,'Product A',700,'2025-03-01');

SELECT *,
LEAD(saleamount) OVER(PARTITION BY productname ORDER BY saledate) AS next_sale
FROM ProductSales;

-- FIRST & LAST VALUE
SELECT *,
FIRST_VALUE(salary) OVER(PARTITION BY employeeid ORDER BY year) AS first_sal,
LAST_VALUE(salary) OVER(
PARTITION BY employeeid ORDER BY year
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS last_sal
FROM EmployeeSalaries;

-- NTH VALUE
SELECT *,
NTH_VALUE(salary,2) OVER(
ORDER BY salary ASC
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS nthvalue
FROM EmployeeSalaries;
