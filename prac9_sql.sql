USE new_sakila;
SET SQL_SAFE_UPDATES = 0;


CREATE VIEW Department_Addresses AS
SELECT
    departments.department_name,
    departments.location_id,
    street_address,
    city,
    state_province,
    country_name
FROM
    departments
JOIN
    locations ON departments.location_id = locations.location_id
JOIN
    countries ON locations.country_id = countries.country_id;

SELECT * FROM Department_Addresses;

CREATE VIEW Employee_Full_Names_Countries AS
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    country_name
FROM
    employees
JOIN
    departments ON employees.department_id = departments.department_id
JOIN
    locations ON departments.location_id = locations.location_id
JOIN
    countries ON locations.country_id = countries.country_id;
SELECT * FROM Employee_Full_Name_Countries;

CREATE VIEW High_Salary_Employees AS
SELECT
    first_name,
    last_name,
    salary
FROM
    employees
WHERE
    salary > (SELECT AVG(salary) FROM employees);
SELECT * FROM High_Salary_Employees;

CREATE VIEW High_Paying_Jobs AS
SELECT
    job_id,
    job_title,
    max_salary
FROM
    jobs
WHERE
    max_salary >= 4000;
SELECT * FROM High_Paying_Jobs;

CREATE VIEW Managers AS
SELECT
    first_name,
    last_name
FROM
    employees
WHERE
    employee_id IN (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL);
SELECT * FROM Managers;

CREATE VIEW Empty_Departments AS
SELECT
    d.department_id,
    d.department_name,
    l.city
FROM
    departments d
JOIN
    locations l ON d.location_id = l.location_id
LEFT JOIN
    employees e ON d.department_id = e.department_id
WHERE
    e.employee_id IS NULL;
SELECT * FROM Empty_Departments;

CREATE VIEW Employees_Before_Susan AS
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    hire_date
FROM
    employees
WHERE
    hire_date < (SELECT hire_date FROM employees WHERE first_name = 'Susan' AND last_name = 'Mavris');

CREATE VIEW Job_Durations AS
SELECT
    employee_id,
    job_title,
    DATEDIFF(ending_date, starting_date) AS duration_days
FROM
    job_history
JOIN
    jobs ON job_history.job_id = jobs.job_id
WHERE
    department_id IN (80, 90);

CREATE VIEW Salary_Range_Departments AS
SELECT
    d.department_name
FROM
    departments d
JOIN
    employees e ON d.department_id = e.department_id
GROUP BY
    d.department_name
HAVING
    MAX(salary) - MIN(salary) > 4000;

-- Before update
SELECT * FROM departments WHERE department_name = 'Example Department';

UPDATE locations  -- For 1st
SET street_address = '123 New Address'
WHERE location_id = (SELECT location_id FROM departments WHERE department_name = 'Example Department');
UPDATE employees  -- For 2nd
SET first_name = 'John'
WHERE employee_id = (SELECT employee_id FROM employees WHERE CONCAT(first_name, ' ', last_name) = 'Steven King');
UPDATE employees  -- For 3rd
SET salary = salary * 1.1
WHERE salary > (SELECT AVG(salary) FROM employees);
UPDATE jobs
SET max_salary = 4500
WHERE job_id = 'IT_PROG';
UPDATE employees
SET first_name = 'Updated Name'
WHERE employee_id = (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL LIMIT 1);
UPDATE departments
SET department_name = 'New Name'
WHERE department_id = (SELECT department_id FROM departments LEFT JOIN employees ON departments.department_id = employees.department_id WHERE employees.employee_id IS NULL LIMIT 1);
UPDATE employees
SET hire_date = '2000-01-01'
WHERE hire_date < (SELECT hire_date FROM employees WHERE first_name = 'Susan' AND last_name = 'Mavris');
UPDATE job_history
SET ending_date = DATE_ADD(starting_date, INTERVAL 365 DAY)
WHERE department_id IN (80, 90) LIMIT 1;
UPDATE employees
SET salary = salary + 1000
WHERE department_id IN (SELECT department_id FROM departments JOIN employees ON departments.department_id = employees.department_id GROUP BY departments.department_name HAVING MAX(salary) - MIN(salary) > 4000);

-- After update
SELECT * FROM locations WHERE location_id = (SELECT location_id FROM departments WHERE department_name = 'Example Department');