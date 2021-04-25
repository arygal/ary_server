FROM debian:buster

#upd
RUN apt-get update && apt-get upgrade -y
#wget & wim
RUN	apt-get install -y vim && apt-get install -y wget
#nginx
RUN apt-get install -y nginx
#php
RUN apt-get install -y php7.3 php7.3-fpm php7.3-xml php7.3-mysql php7.3-mbstring
#sql
RUN apt-get install -y default-mysql-server
#phpmyadmin
RUN wget -P /var/www/html/ https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz \
&& tar -xzf /var/www/html/phpMyAdmin*.tar.gz \
&& rm -r /var/www/html/phpMyAdmin*.tar.gz \
&& mv phpMyAdmin* /var/www/html/phpmyadmin
#wp
RUN wget -P  /var/www/html https://wordpress.org/wordpress-5.7.1.tar.gz \
&& tar -xzf /var/www/html/wordpress-5.7.1.tar.gz \
&& rm -r /var/www/html/wordpress-5.7.1.tar.gz
#ssl
RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
-keyout /etc/ssl/megen.key -out /etc/ssl/megen.crt \
-subj "/C=RU/ST=Moscow/L=Moscow/O=42/CN=megen"
#src

COPY srcs/default /etc/nginx/sites-available/
COPY srcs/*.sh ./
COPY srcs/mysql-config.sql ./
COPY srcs/wp-config.php /var/www/html/wordpress/
COPY srcs/config.inc.php /var/www/html/phpmyadmin/
#dir
WORKDIR /var/www/html/
#rights & ownership
RUN chmod -R 755 ./* && chown -R www-data ./*
#script
#ENTRYPOINT cd / && bash ./run.sh && cd /var/www/html/
#ports
EXPOSE 80 443
#±±±±cheatsheet±±±±
#docker build -t ft_server .
#docker run -it -p 80:80 -p 443:443 ft_server
#docker system prune -a
#docker run -t -i ft_server bash