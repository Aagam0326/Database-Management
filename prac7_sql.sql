USE bda_23162121020;

CREATE TABLE Employee(
Eid VARCHAR(15) PRIMARY KEY, Ename VARCHAR(15),
Address VARCHAR(20), Dept VARCHAR(15), Salary NUMERIC(10,2)
);

CREATE TABLE Project(
Eid VARCHAR(15), FOREIGN KEY(Eid) REFERENCES Employee(Eid), Pid VARCHAR(15),
Pname VARCHAR(15), Location VARCHAR(20)
);

INSERT INTO Employee VALUES('1','Ram','chd','HR',10000);
INSERT INTO Employee VALUES('2','Amit','delhi','MRKT',20000);
INSERT INTO Employee VALUES('3','Ravi','pune','HR',30000);
INSERT INTO Employee VALUES('4','Nitin','bang','MRKT',40000);
INSERT INTO Employee VALUES('5','Varun','chd','IT',50000);

INSERT INTO Project VALUES('1','P1','IOT','bang');
INSERT INTO Project VALUES('5','P2','BIG Data','delhi');
INSERT INTO Project VALUES('3','P3','Retail','mumbai');
INSERT INTO Project VALUES('4','P4','Android','hyderabad');

SELECT * FROM employee;
SELECT * FROM project;

SELECT MAX(salary) AS max_salary
FROM Employee;
SELECT ename
FROM Employee
WHERE salary = (SELECT MAX(salary) FROM Employee);
SELECT MAX(salary) AS second_highest_salary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);
SELECT ename
FROM Employee
WHERE salary = (SELECT MAX(salary) FROM Employee WHERE salary < (SELECT MAX(salary) FROM Employee));
SELECT dept, COUNT(eid) AS no_of_employees
FROM Employee
GROUP BY dept;
SELECT dept , COUNT(ename)
FROM Employee
GROUP BY dept
HAVING COUNT(eid) < 2;
SELECT ename
FROM Employee
WHERE dept IN (
    SELECT dept
    FROM Employee
    GROUP BY dept
    HAVING COUNT(eid) < 2
);
SELECT dept, ename, salary
FROM Employee e
WHERE salary = (
    SELECT MAX(salary)
    FROM Employee
    WHERE dept = e.dept
);
SELECT DISTINCT ename
FROM Employee e
JOIN Project p ON e.eid = p.eid;
SELECT e.*
FROM Employee e
WHERE EXISTS (
    SELECT 1
    FROM Project p
    WHERE e.eid = p.eid
);
