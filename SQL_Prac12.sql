USE bda_23162121020;

-- 1
DELIMITER //
CREATE PROCEDURE 23162121020_q1(IN salary DECIMAL(10, 2))
BEGIN
    DECLARE grade VARCHAR(3);
    -- Assign grade based on salary
    IF salary > 8000 THEN
        SET grade = 'A';
    ELSEIF salary BETWEEN 5000 AND 8000 THEN
        SET grade = 'B';
    ELSE
        SET grade = 'C';
    END IF;
    SELECT grade AS result;
END //
DELIMITER ;

-- 2
DELIMITER //
CREATE PROCEDURE 23162121020_q2(IN location_id INT, OUT country_name VARCHAR(50))
BEGIN
    CASE location_id
        WHEN 1000 THEN SET country_name = 'ITALY';
        WHEN 1001 THEN SET country_name = 'ARGENTINA';
        WHEN 1002 THEN SET country_name = 'AUSTRALIA';
        -- Add other cases for each location_id and country
        ELSE SET country_name = 'Location Not Found';
    END CASE;
END //
DELIMITER ;

-- 3
DELIMITER //
CREATE PROCEDURE 23162121020_q3(IN region_id INT, OUT region_name VARCHAR(50))
BEGIN
    CASE region_id
        WHEN 1 THEN SET region_name = 'You are from Europe Region';
        WHEN 2 THEN SET region_name = 'You are from Americas Region';
        WHEN 3 THEN SET region_name = 'You are from Asia Region';
        WHEN 4 THEN SET region_name = 'You are from Middle East and Africa Region';
        ELSE SET region_name = 'Region does not exist';
    END CASE;
END //
DELIMITER ;

-- 4
DELIMITER //
CREATE PROCEDURE 23162121020_q4()
BEGIN
    DECLARE num INT DEFAULT 1;
    DECLARE result VARCHAR(150);
    
    SET result = 'START -> ';
    WHILE num <= 10 DO
        SET result = concat(result,num,' -> ');
        SET num = num + 1;
    END WHILE;
    SELECT result;
END //
DELIMITER ;

-- 5
DELIMITER //
CREATE PROCEDURE 23162121020_q5()
BEGIN
    DECLARE num INT DEFAULT 1;
    DECLARE ans VARCHAR(150);
    
    SET ans = "0 ,";
    loop_label: LOOP
        IF num > 10 THEN
            LEAVE loop_label;
        END IF;
        SET ans = concat(ans,num,' ,');
        SET num = num + 1;
    END LOOP loop_label;
    SELECT ans;
END //
DELIMITER ;

-- 6
DELIMITER //
CREATE PROCEDURE 23162121020_q6()
BEGIN
    DECLARE num INT DEFAULT 2;
    DECLARE val VARCHAR(150);
    
    SET val = '0 =>';
    loop_label: LOOP
        IF num > 20 THEN
            LEAVE loop_label;
        END IF;
        SET val = concat(val,num,' =>');
        SET num = num + 2;
    END LOOP loop_label;
    SELECT val;
END //
DELIMITER ;

-- 1
CALL 23162121020_q1(8500);
-- 2
SET @country_name = '';
CALL 23162121020_q2(1000, @country_name);
SELECT @country_name AS CountryName;

-- 3
SET @region_name = '';
CALL 23162121020_q3(1, @region_name);
SELECT @region_name AS RegionName;

-- 4
CALL 23162121020_q4();

-- 5
CALL 23162121020_q5();

-- 6
CALL 23162121020_q6();
