FROM ubuntu:18.04

ARG WP_DB_HOST WP_DB_NAME WP_DB_USER WP_DB_PASS WP_DB_PREFIX

RUN apt-get update && apt-get install -y apache2 \
    && apt-get -y install libapache2-mod-fcgid git unzip wget \
    && a2enmod proxy_fcgi && a2enmod rewrite



########################## Proyecto Wordpress ##########################

# Descarga, descomprime Wordpress y hace las sustituciones necesarias en wp-config.php

RUN wget -O /var/www/html/wordpress.zip https://wordpress.org/latest.zip \
    && cd /var/www/html && unzip wordpress.zip && cd wordpress && cp wp-config-sample.php wp-config.php \
    && sed -i "s|database_name_here|${WP_DB_NAME}|g" wp-config.php \
    && sed -i "s|username_here|${WP_DB_USER}|g" wp-config.php \
    && sed -i "s|password_here|${WP_DB_PASS}|g" wp-config.php \
    && sed -i "s|localhost|${WP_DB_HOST}|g" wp-config.php \
    && sed -i "s|wp_|${WP_DB_PREFIX}_|g" wp-config.php

#  Se replica el .htaccess original

RUN echo "<IfModule mod_rewrite.c> \n \
        RewriteEngine On  \n \
        RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]  \n \
        RewriteBase /wordpress/  \n \
        RewriteRule ^index\.php$ - [L]  \n \
        RewriteCond %{REQUEST_FILENAME} !-f  \n \
        RewriteCond %{REQUEST_FILENAME} !-d  \n \
        RewriteRule . /wordpress/index.php [L]  \n \
    </IfModule>" > /var/www/html/wordpress/.htaccess



########################## Proyecto PHP ##########################

# Se clona el proyecto de Github y se mueven los ficheros a las rutas correspondientes

RUN \
    git clone https://github.com/deaw-birt/UD4-despliegue-PHP.git /proyecto \
    && mkdir -p /var/www/html/php/ \
    && mv /proyecto/php/index.php /proyecto/php/dwes.css /var/www/html/php/ \
    && rm -r /proyecto

# RUN \ 
#     mv /proyecto/php/index.php /proyecto/php/dwes.css /var/www/html/php/

COPY config/000-default.conf /etc/apache2/sites-available/

# Al ser el sitio por defecto, no haría falta habilitarlo con a2ensite

# Se expone el puerto y se ordena el arranque del servicio

EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]