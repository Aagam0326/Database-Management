CREATE DATABASE Prac13;
USE Prac13;

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10, 2)
);


INSERT INTO Employee VALUES (1, 'Hitesh', 'Manager', 50000);
INSERT INTO Employee VALUES (2, 'Raju', 'Engineer', 35000);
INSERT INTO Employee VALUES (3, 'Ravi', 'Clerk', 25000);
INSERT INTO Employee VALUES (4, 'Arjun', 'Analyst', 60000);
INSERT INTO Employee VALUES (5, 'Charlie', 'HR', 45000);



-- QUESTION 1


DELIMITER //
CREATE PROCEDURE prac13_q1()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE emp_id INT;
    DECLARE emp_name VARCHAR(100);
    DECLARE emp_position VARCHAR(100);
    DECLARE emp_salary DECIMAL(10, 2);
    DECLARE cur CURSOR FOR SELECT EmpID, Name, Position, Salary FROM Employee;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO emp_id, emp_name, emp_position, emp_salary;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT emp_id, emp_name, emp_position, emp_salary;
    END LOOP;
    CLOSE cur;
END 
// DELIMITER ;

CALL prac13_q1();




-- QUESTION 2



CREATE TABLE EmployeeInfo (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10, 2)
);



DELIMITER //
CREATE PROCEDURE prac13_q2()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE emp_id INT;
    DECLARE emp_name VARCHAR(100);
    DECLARE emp_position VARCHAR(100);
    DECLARE emp_salary DECIMAL(10, 2);
    DECLARE cur CURSOR FOR SELECT EmpID, Name, Position, Salary FROM Employee;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO emp_id, emp_name, emp_position, emp_salary;
        IF done THEN
            LEAVE read_loop;
        END IF;
        INSERT INTO EmployeeInfo (EmpID, Name, Position, Salary)
        VALUES (emp_id, emp_name, emp_position, emp_salary);
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;

CALL prac13_q2();
SELECT * FROM EmployeeInfo;



-- QUESTION 3


CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Course VARCHAR(50)
);


CREATE TABLE BDA_Student (StudentID INT PRIMARY KEY, Name VARCHAR(100));
CREATE TABLE CBA_Student (StudentID INT PRIMARY KEY, Name VARCHAR(100));
CREATE TABLE CS_Student (StudentID INT PRIMARY KEY, Name VARCHAR(100));


INSERT INTO Student VALUES (1, 'Alice', 'BDA');
INSERT INTO Student VALUES (2, 'Bob', 'CBA');
INSERT INTO Student VALUES (3, 'Charlie', 'CS');
INSERT INTO Student VALUES (4, 'David', 'BDA');
INSERT INTO Student VALUES (5, 'Eva', 'CS');

SELECT * FROM Student;

DELIMITER //
CREATE PROCEDURE prac13_q3()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE student_id INT;
    DECLARE student_name VARCHAR(100);
    DECLARE student_course VARCHAR(50);
    DECLARE cur CURSOR FOR SELECT StudentID, Name, Course FROM Student;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO student_id, student_name, student_course;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        IF student_course = 'BDA' THEN
            INSERT INTO BDA_Student (StudentID, Name) VALUES (student_id, student_name);
        ELSEIF student_course = 'CBA' THEN
            INSERT INTO CBA_Student (StudentID, Name) VALUES (student_id, student_name);
        ELSEIF student_course = 'CS' THEN
            INSERT INTO CS_Student (StudentID, Name) VALUES (student_id, student_name);
        END IF;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;

CALL prac13_q3();
SELECT * FROM CS_Student;
SELECT * FROM BDA_Student;
SELECT * FROM CBA_Student;


-- QUESTION 4



DELIMITER //
CREATE PROCEDURE prac13_q4()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE emp_id INT;
    DECLARE emp_salary DECIMAL(10, 2);
    DECLARE cur CURSOR FOR SELECT EmpID, Salary FROM Employee;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO emp_id, emp_salary;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        IF emp_salary > 40000 THEN
            UPDATE Employee SET Salary = Salary + 5000 WHERE EmpID = emp_id;
        ELSE
            UPDATE Employee SET Salary = Salary + 1000 WHERE EmpID = emp_id;
        END IF;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;

SELECT * FROM Employee;
CALL prac13_q4();
SELECT * FROM Employee;




-- QUESTION 5



CREATE TABLE Result (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Percentage DECIMAL(5, 2)
);

INSERT INTO Result VALUES (1, 'Alice', 85.5);
INSERT INTO Result VALUES (2, 'Bob', 72.0);
INSERT INTO Result VALUES (3, 'Charlie', 65.5);
INSERT INTO Result VALUES (4, 'David', 45.0);
INSERT INTO Result VALUES (5, 'Eva', 38.0);



CREATE TABLE Result1 (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Percentage DECIMAL(5, 2),
    Class VARCHAR(50)
);

DELIMITER //

CREATE PROCEDURE prac13_q5()
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE student_id INT;
    DECLARE student_name VARCHAR(100);
    DECLARE percentage DECIMAL(5, 2);
    DECLARE class VARCHAR(50);
    DECLARE cur CURSOR FOR SELECT StudentID, Name, Result.Percentage FROM Result;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO student_id, student_name, percentage;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        IF percentage >= 70.00 THEN
            SET class = 'Distinction';
        ELSEIF percentage >= 60.00 THEN
            SET class = 'First Class';
        ELSEIF percentage >= 40.00 THEN
            SET class = 'Second Class';
        ELSE
            SET class = 'Fail';
        END IF;

        INSERT INTO Result1 (StudentID, Name, Percentage, Class)
        VALUES (student_id, student_name, percentage, class);
    END LOOP;
    CLOSE cur;
END //

DELIMITER ;

SELECT * FROM Result;
CALL prac13_q5();
SELECT * FROM Result1;

DROP TABLE Result1;

Drop PROCEDURE prac13_q5;
