USE sakila;

-- 1 
DELIMITER //
CREATE PROCEDURE PrintDetails(IN your_name VARCHAR(100), IN enrolment_number INT)
BEGIN
    SELECT CONCAT('Hi, your name is ', your_name, ' and your enrolment number is ', enrolment_number) AS message;
END //
DELIMITER ;

-- 2
DELIMITER //
CREATE PROCEDURE GetFirst10Actors()
BEGIN
    SELECT CONCAT(first_name, ' ', last_name) AS full_name
    FROM actor
    LIMIT 10;
END //
DELIMITER ;

-- 3 
DELIMITER //
CREATE PROCEDURE GetFilmDetails(IN film_title VARCHAR(100))
BEGIN
    SELECT * 
    FROM film
    WHERE title = film_title;
END //
DELIMITER ;

-- 4 
DELIMITER //
CREATE PROCEDURE GetFilmsByTitleString(IN search_string VARCHAR(100))
BEGIN
    SELECT * 
    FROM film
    WHERE title LIKE CONCAT('%', search_string, '%');
END //
DELIMITER ;

-- 5
DELIMITER //
CREATE PROCEDURE GetFilmsByCategoryId(IN category_id INT)
BEGIN
    SELECT f.*
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    WHERE fc.category_id = category_id;
END //
DELIMITER ;

-- 6
DELIMITER //
CREATE PROCEDURE GetFilmsByCategoryName(IN category_name VARCHAR(100))
BEGIN
    SELECT f.*
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = category_name;
END //
DELIMITER ;

-- 7
DELIMITER //
CREATE PROCEDURE GetFilmsByRentalRate(IN min_rate DECIMAL(4, 2), IN max_rate DECIMAL(4, 2))
BEGIN
    SELECT * 
    FROM film
    WHERE rental_rate BETWEEN min_rate AND max_rate;
END //
DELIMITER ;

-- 8
DELIMITER //
CREATE PROCEDURE GetActorNameById(IN actor_id INT)
BEGIN
    SELECT CONCAT(first_name, ' ', last_name) AS full_name
    FROM actor
    WHERE actor_id = actor_id;
END //
DELIMITER ;

-- 9 
DELIMITER //
CREATE PROCEDURE GetTotalFilmsByCategoryId(IN category_id INT)
BEGIN
    SELECT COUNT(f.film_id) AS total_films
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    WHERE fc.category_id = category_id;
END //
DELIMITER ;

-- 10 
DELIMITER //
CREATE PROCEDURE GetCountriesByCityCount(IN min_cities INT)
BEGIN
    SELECT co.country, COUNT(ci.city_id) AS total_cities
    FROM country co
    JOIN city ci ON co.country_id = ci.country_id
    GROUP BY co.country
    HAVING COUNT(ci.city_id) > min_cities;
END //
DELIMITER ;

-- 11 
DELIMITER //
CREATE PROCEDURE GetTotalCustomersByActiveStatus(IN active_status TINYINT)
BEGIN
    SELECT COUNT(customer_id) AS total_customers
    FROM customer
    WHERE active = active_status;
END //
DELIMITER ;

-- 12
DELIMITER //
CREATE PROCEDURE UpdateActorFirstName(IN new_first_name VARCHAR(50), IN actor_id INT)
BEGIN
    UPDATE actor
    SET first_name = new_first_name
    WHERE actor_id = actor_id;

    SELECT CONCAT('Updated name: ', first_name, ' ', last_name) AS updated_name
    FROM actor
    WHERE actor_id = actor_id;
END //
DELIMITER ;

-- 13
DELIMITER //
CREATE PROCEDURE GetRentalDurationByFilmId(INOUT film_id INT)
BEGIN
    SELECT rental_duration
    INTO film_id
    FROM film
    WHERE film_id = film_id;
    
    SELECT CONCAT('Film ID: ', film_id, ', Rental Duration: ', rental_duration) AS details;
END //
DELIMITER ;
