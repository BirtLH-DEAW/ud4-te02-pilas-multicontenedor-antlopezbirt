FROM mysql:5.7

ARG WP_URL WP_DB_NAME WP_DB_PREFIX WP_DB_USER WP_DB_PASS WP_ADMIN_USER WP_ADMIN_EMAIL

COPY crearBD_php.sql crearBD_wp.sql inserts_php.sql inserts_wp.sql /

# Se sustituyen los placeholders de los ficheros por los valores de los argumentos

RUN sed -i "s|WP_DB_NAME|${WP_DB_NAME}|g" crearBD_wp.sql
RUN sed -i "s|WP_DB_NAME|${WP_DB_NAME}|g" inserts_wp.sql
RUN sed -i "s|WORDPRESS_DB_PREFIX|${WP_DB_PREFIX}|g" inserts_wp.sql
RUN sed -i "s|WP_DB_USER|${WP_DB_USER}|g" crearBD_wp.sql
RUN sed -i "s|WP_DB_PASS|${WP_DB_PASS}|g" crearBD_wp.sql
RUN sed -i "s|WORDPRESS_BASE_URL|${WP_URL}|g" inserts_wp.sql
RUN sed -i "s|WORDPRESS_ADMIN_USER|${WP_ADMIN_USER}|g" inserts_wp.sql
RUN sed -i "s|WORDPRESS_ADMIN_EMAIL|${WP_ADMIN_EMAIL}|g" inserts_wp.sql

RUN mv *.sql /docker-entrypoint-initdb.d/

EXPOSE 3306