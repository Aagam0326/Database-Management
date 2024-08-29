USE sakila;

-- DROP VIEW name_actor;
DESC language;

CREATE VIEW name_actor AS
SELECT actor_id , first_name , last_name
FROM actor
WHERE first_name LIKE 'A%' AND last_name LIKE '%A%' ;
SELECT * FROM name_actor;

CREATE VIEW actor_desc AS
SELECT *
FROM actor
ORDER BY last_name DESC;
SELECT * FROM actor_desc;

SELECT * FROM actor;

DROP VIEW actor_desc;

CREATE VIEW W_lang AS
SELECT language_id , name , last_update
FROM language;
SELECT * FROM W_lang;

INSERT INTO W_lang VALUES(8,'Hindi', '2013-07-05 12:23:05');
SELECT * FROM W_lang;

UPDATE W_lang
SET name = 'Spanish'
WHERE language_id = 8;
SELECT * FROM W_lang;

CREATE VIEW U_lang AS
SELECT * FROM language
WHERE last_update = '2006-02-15 05:02:19';
SELECT * FROM U_lang;

INSERT INTO W_lang VALUES(7,'Hindi', '2020-07-13 10:00:19');
SELECT * FROM W_lang;

INSERT INTO W_lang VALUES(9,'Hindi', '2006-02-15 05:02:19');
SELECT * FROM W_lang;

UPDATE W_lang
SET last_update = '2020-07-13 10:00:19'
WHERE language_id = 9;
SELECT * FROM W_lang;