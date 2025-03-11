FROM httpd:latest

ARG PHP_DB_NAME PHP_DB_USER PHP_DB_PASS WP_DB_HOST WP_DB_NAME WP_DB_USER WP_DB_PASS WP_DB_PREFIX

# Copia el virtualhost
COPY config/000-default.conf /

# Instalación de paquetes y módulos necesarios
RUN \
    apt-get update && apt-get install -y libapache2-mod-fcgid git unzip wget \
    && echo "LoadModule rewrite_module modules/mod_rewrite.so" >> /usr/local/apache2/conf/httpd.conf \
    && echo "LoadModule proxy_module modules/mod_proxy.so" >> /usr/local/apache2/conf/httpd.conf \
    && echo "LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so" >> /usr/local/apache2/conf/httpd.conf


########################## Proyecto Wordpress ##########################

# Descarga, descomprime Wordpress y hace las sustituciones necesarias en wp-config.php
RUN \
    wget -O /usr/local/apache2/htdocs/wordpress.zip https://wordpress.org/latest.zip \
    && cd /usr/local/apache2/htdocs && unzip wordpress.zip && cd wordpress && cp wp-config-sample.php wp-config.php \
    && sed -i "s|database_name_here|${WP_DB_NAME}|g" wp-config.php \
    && sed -i "s|username_here|${WP_DB_USER}|g" wp-config.php \
    && sed -i "s|password_here|${WP_DB_PASS}|g" wp-config.php \
    && sed -i "s|localhost|${WP_DB_HOST}|g" wp-config.php \
    && sed -i "s|wp_|${WP_DB_PREFIX}_|g" wp-config.php \
    #  Se replica el .htaccess original
    && echo "<IfModule mod_rewrite.c> \n \
        RewriteEngine On  \n \
        RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]  \n \
        RewriteBase /wordpress/  \n \
        RewriteRule ^index\.php$ - [L]  \n \
        RewriteCond %{REQUEST_FILENAME} !-f  \n \
        RewriteCond %{REQUEST_FILENAME} !-d  \n \
        RewriteRule . /wordpress/index.php [L]  \n \
    </IfModule>" > /usr/local/apache2/htdocs/wordpress/.htaccess


########################## Proyecto PHP ##########################

# Se clona el proyecto de Github y se mueven los ficheros a las rutas correspondientes, adaptando index.php a los argumentos
RUN \
    git clone https://github.com/deaw-birt/UD4-despliegue-PHP.git /proyecto \
    && mkdir -p /usr/local/apache2/htdocs/php/ \
    && mv /proyecto/php/index.php /proyecto/php/dwes.css /usr/local/apache2/htdocs/php/ \
    && sed -i "s|\$database = \"dwes\"|\$database = \"${PHP_DB_NAME}\"|g" /usr/local/apache2/htdocs/php/index.php \
    && sed -i "s|\$username = \"dwes\"|\$username = \"${PHP_DB_USER}\"|g" /usr/local/apache2/htdocs/php/index.php \
    && sed -i "s|\$password = \"dwes\"|\$password = \"${PHP_DB_PASS}\"|g" /usr/local/apache2/htdocs/php/index.php \
    && rm -r /proyecto \
    &&  cat /000-default.conf >> /usr/local/apache2/conf/httpd.conf



# Para finalizar se expone el puerto, el arranque del servicio es automático
EXPOSE 80