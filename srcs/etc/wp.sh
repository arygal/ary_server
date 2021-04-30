# !/bin/bash
service mysql start
mysql < /inst/mysql-config.sql
service mysql stop