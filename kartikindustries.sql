-- 1. Create Database
CREATE DATABASE kartikindustries;
USE kartikindustries;

-- 2. Create Tables

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2) NOT NULL CHECK (salary > 0),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
        ON DELETE SET NULL
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100) NOT NULL UNIQUE,
    start_date DATE NOT NULL,
    end_date DATE,
    CHECK (end_date IS NULL OR end_date >= start_date)
);

CREATE TABLE employee_project (
    employee_id INT,
    project_id INT,
    hours_worked INT NOT NULL CHECK (hours_worked >= 0),
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
        ON DELETE CASCADE
);

-- 4. Index on salary column
CREATE INDEX idx_salary ON employees(salary);

  -- Insert Departments
INSERT INTO departments (department_name) VALUES
('IT'), ('HR'), ('Finance'), ('Marketing');

-- Insert Projects
INSERT INTO projects (project_name, start_date, end_date) VALUES
('Website Development', '2023-01-01', NULL),
('App Development', '2023-03-01', NULL),
('Audit System', '2022-05-01', '2023-01-01');

-- 5. Insert 5 Employees
INSERT INTO employees (first_name, last_name, email, hire_date, salary, department_id) VALUES
('Rahul', 'Sharma', 'rahul@company.com', '2023-02-01', 50000, 1),
('Priya', 'Patel', 'priya@company.com', '2021-07-15', 60000, 2),
('Amit', 'Verma', 'amit@company.com', '2022-09-10', 45000, 1),
('Sneha', 'Rao', 'sneha@company.com', '2024-01-05', 70000, 3),
('Karan', 'Mehta', 'karan@company.com', '2020-11-20', 28000, 4);

-- Assign Projects
INSERT INTO employee_project VALUES
(1,1,120),
(1,2,80),
(3,1,60),
(4,3,150);

-- 6. Increase salary by 10% in IT department
UPDATE employees
SET salary = salary * 1.10
WHERE department_id = (
    SELECT department_id FROM departments WHERE department_name = 'IT'
);

-- 7. Delete employees with salary < 30000
DELETE FROM employees
WHERE salary < 30000;
-- 8. Employees hired after 2022
SELECT * FROM employees
WHERE hire_date > '2022-12-31';

-- 9. Average salary department-wise
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

-- 10. Total hours worked per project
SELECT project_id, SUM(hours_worked) AS total_hours
FROM employee_project
GROUP BY project_id;

-- 11. Highest paid employee in each department
SELECT *
FROM employees e
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = e.department_id
);

-- 12. Employee name with department name
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

-- 13. Project name with total hours worked
SELECT p.project_name, SUM(ep.hours_worked) AS total_hours
FROM projects p
JOIN employee_project ep
ON p.project_id = ep.project_id
GROUP BY p.project_name;

-- 14. Employees not assigned to any project
SELECT e.first_name, e.last_name
FROM employees e
LEFT JOIN employee_project ep
ON e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL;

-- 15. Department-wise total salary expense
CREATE VIEW department_salary_expense AS
SELECT d.department_name, SUM(e.salary) AS total_salary
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_name;

-- 16. Employees earning above average salary
CREATE VIEW high_salary_employees AS
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

  -- 17. Procedure to get employees by department
DELIMITER //
CREATE PROCEDURE get_employees_by_department(IN dept_id INT)
BEGIN
    SELECT * FROM employees
    WHERE department_id = dept_id;
END //
DELIMITER ;

-- 18. Procedure to increase salary by given percentage
DELIMITER //
CREATE PROCEDURE increase_salary(IN percentage DECIMAL(5,2))
BEGIN
    UPDATE employees
    SET salary = salary + (salary * percentage / 100);
END //
DELIMITER ;

-- 19. Function to calculate annual salary
DELIMITER //
CREATE FUNCTION annual_salary(monthly_salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN monthly_salary * 12;
END //
DELIMITER ;
-- 20. Rank employees by salary within department
SELECT employee_id, first_name, department_id, salary,
RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees;

-- 21. Second highest salary in each department
SELECT *
FROM (
    SELECT *, 
    DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 2;

-- 22. Running total of salaries department-wise
SELECT employee_id, department_id, salary,
SUM(salary) OVER (PARTITION BY department_id ORDER BY salary) AS running_total
FROM employees;


 
