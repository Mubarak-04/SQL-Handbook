-- =====================================
-- 05_Advanced.sql
-- Covers: Date functions, Regex,
-- Transactions, Grants, Normalization,
-- SCD, Triggers
-- =====================================

USE de_project;

-- DATE & TIME
CREATE TABLE events (
event_id INT AUTO_INCREMENT PRIMARY KEY,
event_name VARCHAR(100),
event_date DATETIME,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT event_id,event_name,YEAR(event_date),MONTH(event_date)
FROM events;

SELECT event_date + INTERVAL 42 DAY FROM events;

-- REGEX
CREATE TABLE regex_samples (
id INT AUTO_INCREMENT PRIMARY KEY,
sample_text VARCHAR(100)
);

SELECT * FROM regex_samples WHERE sample_text REGEXP '^a';
SELECT * FROM regex_samples WHERE sample_text REGEXP 'e$';

-- TRANSACTIONS
CREATE TABLE Accounts1 (
AccountID INT PRIMARY KEY,
AccountHolder VARCHAR(100),
Balance DECIMAL(10,2)
);

START TRANSACTION;
UPDATE Accounts1 SET Balance = Balance - 1000 WHERE AccountID = 1;
ROLLBACK;

START TRANSACTION;
SAVEPOINT sp1;
UPDATE Accounts1 SET Balance = Balance - 1000 WHERE AccountID = 1;
ROLLBACK TO sp1;
COMMIT;

-- GRANT / REVOKE
CREATE USER 'jane_doe'@'localhost' IDENTIFIED BY 'Strong';

GRANT SELECT, INSERT
ON de_project.orders_sp1
TO 'jane_doe'@'localhost';

REVOKE SELECT, INSERT
ON de_project.orders_sp1
FROM 'jane_doe'@'localhost';

-- NORMALIZATION (1NF)
CREATE TABLE student (
student_id INT PRIMARY KEY,
student_name VARCHAR(100)
);

CREATE TABLE student_phone (
student_id INT,
phone_numbers VARCHAR(100),
PRIMARY KEY(student_id,phone_numbers),
FOREIGN KEY (student_id) REFERENCES student(student_id)
);

-- 2NF
CREATE TABLE Courses (
course_id INT PRIMARY KEY,
course_name VARCHAR(100),
instructor VARCHAR(100)
);

CREATE TABLE enrollment (
course_id INT,
student_id INT,
PRIMARY KEY(course_id,student_id),
FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- 3NF
CREATE TABLE office (
instructor VARCHAR(100) PRIMARY KEY,
instructor_office VARCHAR(100)
);

CREATE TABLE Courses1 (
course_id INT PRIMARY KEY,
course_name VARCHAR(100),
instructor VARCHAR(100),
FOREIGN KEY (instructor) REFERENCES office(instructor)
);

-- SCD TYPE 1
CREATE TABLE dim_product_type1 (
product_id INT PRIMARY KEY,
product_title VARCHAR(255),
category VARCHAR(100),
brand VARCHAR(100)
);

-- SCD TYPE 2
CREATE TABLE dim_seller_type2 (
seller_key INT PRIMARY KEY,
seller_id INT,
seller_name VARCHAR(255),
store_location VARCHAR(255),
effective_date DATE,
end_date DATE,
is_current BOOLEAN
);

-- SCD TYPE 3
CREATE TABLE dim_product_type3 (
product_id INT PRIMARY KEY,
product_title VARCHAR(255),
current_category VARCHAR(100),
previous_category VARCHAR(100)
);

-- TRIGGERS
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50),
salary INT
);

CREATE TABLE emp_log (
log_id INT AUTO_INCREMENT PRIMARY KEY,
emp_id INT,
action VARCHAR(50),
log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER employee_log
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
INSERT INTO emp_log(emp_id, action)
VALUES (NEW.id, 'Employee Added');
END//

DELIMITER ;
