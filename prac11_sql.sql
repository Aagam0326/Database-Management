USE bda_23162121020;

-- 1
DELIMITER //

CREATE FUNCTION findmax(a INT, b INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN IF(a > b, a, b);
END //

DELIMITER ;

CREATE TABLE student (
    rollno INT PRIMARY KEY,          
    name VARCHAR(100),               
    marks INT,                       
    branch VARCHAR(50)               
);

INSERT INTO student (rollno, name, marks, branch) VALUES
(101, 'Alice', 92, 'Science'),
(102, 'Bob', 85, 'Arts'),
(103, 'Charlie', 78, 'Commerce'),
(104, 'David', 65, 'Science'),
(105, 'Eva', 54, 'Arts'),
(106, 'Frank', 39, 'Commerce');

-- 2 
DELIMITER //

CREATE FUNCTION findgrade(marks INT)
RETURNS CHAR(2)
DETERMINISTIC
BEGIN
    DECLARE grade CHAR(2);
    IF marks >= 90 THEN
        SET grade = 'A+';
    ELSEIF marks >= 80 THEN
        SET grade = 'A';
    ELSEIF marks >= 70 THEN
        SET grade = 'B+';
    ELSEIF marks >= 60 THEN
        SET grade = 'B';
    ELSEIF marks >= 50 THEN
        SET grade = 'C+';
    ELSEIF marks >= 40 THEN
        SET grade = 'C';
    ELSE
        SET grade = 'F';
    END IF;
    RETURN grade;
END //

DELIMITER ;

-- 3
DELIMITER //

CREATE FUNCTION get_percentage(rollno INT)
RETURNS DECIMAL(5, 2)
DETERMINISTIC
BEGIN
    DECLARE percentage DECIMAL(5, 2);
    SELECT marks INTO percentage FROM student WHERE rollno = get_percentage.rollno;
    RETURN percentage;
END //

DELIMITER ;

-- 4
DELIMITER //

CREATE FUNCTION count_students_by_branch(branch_name VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE student_count INT;
    SELECT COUNT(*) INTO student_count FROM student WHERE branch = branch_name;
    RETURN student_count;
END //

DELIMITER ;

-- 5
DELIMITER //

CREATE FUNCTION get_yesterdays_date()
RETURNS DATE
DETERMINISTIC
BEGIN
    RETURN CURDATE() - INTERVAL 1 DAY;
END //

DELIMITER ;

-- 6
DELIMITER //

CREATE FUNCTION get_tomorrows_date()
RETURNS DATE
DETERMINISTIC
BEGIN
    RETURN CURDATE() + INTERVAL 1 DAY;
END //

DELIMITER ;

-- 7
DELIMITER //

CREATE FUNCTION days_between(date1 DATE, date2 DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN ABS(DATEDIFF(date1, date2));
END //

DELIMITER ;

-- 8
DELIMITER //

CREATE FUNCTION days_since_birth(birthdate DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN ABS(DATEDIFF(CURDATE(), birthdate));
END //

DELIMITER ;

-- 9
DELIMITER //

CREATE FUNCTION calculate_age(birthdate DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, birthdate, CURDATE());
END //

DELIMITER ;

SELECT findmax(10, 20) AS MaxVal;
SELECT findgrade(85) AS Grade;
SELECT get_percentage(101) AS Percentage;
SELECT count_students_by_branch('Science') AS StudentCount;
SELECT get_yesterdays_date() AS YesterdaysDate;
SELECT get_tomorrows_date() AS TomorrowsDate;
SELECT days_between('2024-01-01', '2024-12-31') AS DaysBetween;
SELECT days_since_birth('2000-01-01') AS DaysSinceBirth;
SELECT calculate_age('2000-01-01') AS Age;
