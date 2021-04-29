CREATE DATABASE wordpress;
CREATE USER 'admin'@'localhost' IDENTIFIED BY '42';
GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;