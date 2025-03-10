FROM mysql:5.7

ARG WP_URL WP_DB_NAME WP_DB_PREFIX WP_DB_USER WP_DB_PASS WP_ADMIN_USER WP_ADMIN_PASS WP_ADMIN_EMAIL

# Se descarga los scripts SQL para el proyecto PHP desde Github
RUN \
    curl -o crearBD_php.sql https://raw.githubusercontent.com/deaw-birt/UD4-despliegue-PHP/refs/heads/main/mysql/crearBBDD.sql \
    && curl -o inserts_php.sql https://raw.githubusercontent.com/deaw-birt/UD4-despliegue-PHP/refs/heads/main/mysql/InsertarDatos.sql

COPY sql/crearBD_wp.sql sql/inserts_wp.sql /

# Se adapta el script del proyecto PHP para que no haya conflictos al crear la BD o el usuario si ya existen
RUN sed -i "s|CREATE DATABASE `dwes`|CREATE DATABASE IF NOT EXISTS `dwes`|g" crearBD_php.sql
RUN sed -i "s|CREATE USER `dwes`|CREATE USER IF NOT EXISTS `dwes`|g" crearBD_php.sql


# Se sustituyen los placeholders de los scripts SQL de Wordpress por los valores de los argumentos

RUN sed -i "s|WP_DB_NAME|${WP_DB_NAME}|g" crearBD_wp.sql
RUN sed -i "s|WP_DB_NAME|${WP_DB_NAME}|g" inserts_wp.sql
RUN sed -i "s|WORDPRESS_DB_PREFIX|${WP_DB_PREFIX}|g" inserts_wp.sql
RUN sed -i "s|WP_DB_USER|${WP_DB_USER}|g" crearBD_wp.sql
RUN sed -i "s|WP_DB_PASS|${WP_DB_PASS}|g" crearBD_wp.sql
RUN sed -i "s|WORDPRESS_BASE_URL|${WP_URL}|g" inserts_wp.sql
RUN sed -i "s|WORDPRESS_ADMIN_USER|${WP_ADMIN_USER}|g" inserts_wp.sql
# Se calcula el checksum de la contraseña y se sustituye en el sript SQL
RUN passhash="$(echo -n "${WP_ADMIN_PASS}" | md5sum | tr -d ' -')" && sed -i "s|WORDPRESS_ADMIN_PASS|$passhash|g" inserts_wp.sql
RUN sed -i "s|WORDPRESS_ADMIN_EMAIL|${WP_ADMIN_EMAIL}|g" inserts_wp.sql

RUN mv *.sql /docker-entrypoint-initdb.d/

EXPOSE 3306