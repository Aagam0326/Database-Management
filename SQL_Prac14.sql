USE new_sakila;
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE language (
    language_id NUMERIC(4) NOT NULL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    last_update TIMESTAMP NOT NULL
);

DELIMITER $$
CREATE TRIGGER ConvertLanguageNameToUppercase
BEFORE INSERT ON language
FOR EACH ROW
BEGIN
    SET NEW.name = UPPER(NEW.name);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER DisplayInsertSuccessMessage
AFTER INSERT ON language
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '01000'
    SET MESSAGE_TEXT = 'The record has been inserted successfully';
END$$
DELIMITER ;

CREATE TABLE audit_language_update (
    language_id NUMERIC(4) NOT NULL,
    name VARCHAR(20) NOT NULL,
    last_update TIMESTAMP NOT NULL,
    status CHAR(20) NOT NULL CHECK (status IN ('Before Update', 'After Update'))
);

DELIMITER $$
CREATE TRIGGER AuditLanguageUpdate
AFTER UPDATE ON language
FOR EACH ROW
BEGIN
    INSERT INTO audit_language_update (language_id, name, last_update, status)
    VALUES (OLD.language_id, OLD.name, OLD.last_update, 'Before Update');
    INSERT INTO audit_language_update (language_id, name, last_update, status)
    VALUES (NEW.language_id, NEW.name, NEW.last_update, 'After Update');
END$$
DELIMITER ;

CREATE TABLE language_before_delete (
    language_id NUMERIC(4) NOT NULL,
    name VARCHAR(20) NOT NULL,
    last_update TIMESTAMP NOT NULL,
    status CHAR(20) DEFAULT 'Before Delete'
);

DELIMITER $$
CREATE TRIGGER BackupBeforeDelete
BEFORE DELETE ON language
FOR EACH ROW
BEGIN
    INSERT INTO language_before_delete (language_id, name, last_update, status)
    VALUES (OLD.language_id, OLD.name, OLD.last_update, 'Before Delete');
END$$
DELIMITER ;

CREATE TABLE language_after_delete (
    language_id NUMERIC(4) NOT NULL,
    name VARCHAR(20) NOT NULL,
    status VARCHAR(200) NOT NULL
);

DELIMITER $$
CREATE TRIGGER MaintainDeletedRecordStatus
AFTER DELETE ON language
FOR EACH ROW
BEGIN
    INSERT INTO language_after_delete (language_id, name, status)
    VALUES (
        OLD.language_id,
        OLD.name,
        CONCAT('Language ', OLD.name, ' with ID ', OLD.language_id, ' was deleted on ', NOW())
    );
END$$
DELIMITER ;

SHOW TRIGGERS;

-- Test the script with sample operations
INSERT INTO language (language_id, name, last_update)
VALUES (1, 'english', NOW()), (2, 'french', NOW()), (3, 'spanish', NOW());

SELECT * FROM language;

UPDATE language
SET name = 'SPANISH UPDATED'
WHERE language_id = 3;

INSERT INTO language (language_id, name, last_update)
VALUES (4, 'german', NOW());

DELETE FROM language WHERE language_id = 4;

INSERT INTO language (language_id, name, last_update)
VALUES (5, 'italian', NOW());

SELECT * FROM audit_language_update;
SELECT * FROM language_before_delete;
SELECT * FROM language_after_delete;

DELETE FROM language WHERE language_id = 5;

