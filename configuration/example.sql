DROP DATABASE IF EXISTS example;
CREATE DATABASE example;
USE example;

CREATE TABLE guest (
    id INT(2) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(32) NOT NULL,
    lastname VARCHAR(32) NOT NULL,
    email VARCHAR(64),
    registration_date TIMESTAMP
)
