DROP DATABASE IF EXISTS example;
CREATE DATABASE example;
USE example;
CREATE TABLE guest (
    id INT(2) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(32) NOT NULL,
    lastname VARCHAR(32) NOT NULL,
    email VARCHAR(64),
    registration_date TIMESTAMP
);
INSERT INTO guest (firstname, lastname, email, registration_date) VALUES ('Example', 'User', 'example@example.org', NOW());

DROP DATABASE IF EXISTS example2;
CREATE DATABASE example2;
USE example2;
CREATE TABLE guest (
    id INT(2) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(32) NOT NULL,
    lastname VARCHAR(32) NOT NULL,
    email VARCHAR(64),
    registration_date TIMESTAMP
);
INSERT INTO guest (firstname, lastname, email, registration_date) VALUES ('Example2', 'User', 'example@example.org', NOW());
