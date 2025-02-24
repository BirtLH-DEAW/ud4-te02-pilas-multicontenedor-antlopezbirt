# FROM httpd:latest

# #RUN apt-get update && apt-get install -y libapache2-mod-fcgid
# RUN sed -r -e 's/^#(LoadModule proxy_fcgi_module)/\1/' /usr/local/apache2/conf/httpd.conf
# RUN rm /usr/local/apache2/htdocs/index.html

# COPY 000-default.conf /usr/local/apache2/sites-available/
# COPY index.php /usr/local/apache2/htdocs/

# EXPOSE 80
# CMD ["apachectl", "-D", "FOREGROUND"]
# #CMD ["/bin/sh", "-c", "sleep infinity"]


FROM ubuntu:18.04

ARG WP_DB_HOST WP_DB_NAME WP_DB_USER WP_DB_PASS WP_DB_PREFIX

RUN apt-get update && apt-get install -y apache2 \
    && apt-get -y install libapache2-mod-fcgid unzip wget \
    && a2enmod proxy_fcgi

# ------------------------- Proyecto Wordpress ----------------------------

# Descarga y descomprime Wordpress

RUN wget -O /var/www/html/wordpress.zip https://wordpress.org/latest.zip \
    && cd /var/www/html && unzip wordpress.zip && cd wordpress && cp wp-config-sample.php wp-config.php \
    && sed -i "s|database_name_here|${WP_DB_NAME}|g" wp-config.php \
    && sed -i "s|username_here|${WP_DB_USER}|g" wp-config.php \
    && sed -i "s|password_here|${WP_DB_PASS}|g" wp-config.php \
    && sed -i "s|localhost|${WP_DB_HOST}|g" wp-config.php \
    && sed -i "s|wp_|${WP_DB_PREFIX}_|g" wp-config.php

# ------------------------ Proyecto PHP -----------------------------------

COPY 000-default.conf /etc/apache2/sites-available/
COPY index.php dwes.css /var/www/html/php/

EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]