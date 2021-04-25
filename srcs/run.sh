# !/bin/bash
service nginx start
service mysql start
service php7.3-fpm start
cd /
mysql < mysql-config.sql
cd /var/www/html
mkdir -p ./phpmyadmin/tmp && chown www-data:www-data ./phpmyadmin/tmp && chmod 700 ./phpmyadmin/tmp
sleep infinity