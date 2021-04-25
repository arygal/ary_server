CREATE DATABASE data_base;
CREATE USER 'megen'@'megensite' IDENTIFIED BY '42';
GRANT ALL PRIVILEGES ON data_base.* TO 'megen'@'megensite';
FLUSH PRIVILEGES;