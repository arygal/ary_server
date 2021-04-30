FROM debian:buster

WORKDIR /var/www

RUN mkdir -p /run/php && \
    apt-get update && apt-get install -y \
    curl \
    nginx \
    supervisor \
    php-fpm php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip php-mbstring php-mysql \
    libmariadb-dev \
    mariadb-server \
    mariadb-client

COPY srcs/conf/default.conf /etc/nginx/sites-available/default
COPY srcs/supervisord/conf /etc/supervisor/conf.d
COPY srcs/supervisord/supervisord.conf /etc
COPY srcs/etc /inst

RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld && \
    bash /inst/wp.sh && \
    rm -rf /var/www/* && \
    curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz && \
    curl -O -L https://phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz && \
    tar -xzf phpMyAdmin*.tar.gz && \
    rm phpMyAdmin*.tar.gz && \
    mv /inst/config.inc.php /var/www/phpMyAdmin* && \
    openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
    -keyout /etc/ssl/megen.key -out /etc/ssl/megen.crt \
    -subj "/C=RU/ST=Moscow/L=Moscow/O=42/CN=megen" && \
    chown -R www-data:www-data /var/www

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
