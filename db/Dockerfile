FROM mysql:5.7

ARG WP_URL WP_DB_NAME WP_DB_PREFIX WP_DB_USER WP_DB_PASS WP_ADMIN_USER WP_ADMIN_PASS WP_ADMIN_EMAIL

# Copia los scripts SQL volcados de la instalación Wordpress de la tarea anterior
COPY sql/crearBD_wp.sql sql/inserts_wp.sql /

# Se descarga de GitHub los scripts SQL para el proyecto PHP
RUN \
    curl -o crearBD_php.sql https://raw.githubusercontent.com/deaw-birt/UD4-despliegue-PHP/refs/heads/main/mysql/crearBBDD.sql \
    && curl -o inserts_php.sql https://raw.githubusercontent.com/deaw-birt/UD4-despliegue-PHP/refs/heads/main/mysql/InsertarDatos.sql

# Se adaptan los scripts y se mueven al entrypoint para su ejecución
RUN \
    # Se añade el IF NOT EXISTS para que no haya conflictos al crear BD o usuarios
    sed -i "s|CREATE DATABASE `dwes`|CREATE DATABASE IF NOT EXISTS `${WP_DB_NAME}`|g" crearBD_php.sql \
    && sed -i "s|CREATE USER `dwes`|CREATE USER IF NOT EXISTS `${WP_DB_USER}`|g" crearBD_php.sql \
    # Se sustituyen los placeholders por los valores de los argumentos
    && sed -i "s|WP_DB_NAME|${WP_DB_NAME}|g" crearBD_wp.sql \
    && sed -i "s|WP_DB_NAME|${WP_DB_NAME}|g" inserts_wp.sql \
    && sed -i "s|WORDPRESS_DB_PREFIX|${WP_DB_PREFIX}|g" inserts_wp.sql \
    && sed -i "s|WP_DB_USER|${WP_DB_USER}|g" crearBD_wp.sql \
    && sed -i "s|WP_DB_PASS|${WP_DB_PASS}|g" crearBD_wp.sql \
    && sed -i "s|WORDPRESS_BASE_URL|${WP_URL}|g" inserts_wp.sql \
    && sed -i "s|WORDPRESS_ADMIN_USER|${WP_ADMIN_USER}|g" inserts_wp.sql \
    # Se calcula el checksum de la contraseña y se sustituye en el sript SQL
    && passhash="$(echo -n "${WP_ADMIN_PASS}" | md5sum | tr -d ' -')" && sed -i "s|WORDPRESS_ADMIN_PASS|$passhash|g" inserts_wp.sql \
    && sed -i "s|WORDPRESS_ADMIN_EMAIL|${WP_ADMIN_EMAIL}|g" inserts_wp.sql \
    && mv *.sql /docker-entrypoint-initdb.d/

# Por último se expone el puerto
EXPOSE 3306