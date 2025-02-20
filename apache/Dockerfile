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

RUN apt-get update && apt-get install -y apache2 \
    && apt-get -y install libapache2-mod-fcgid \
    && a2enmod proxy_fcgi

COPY 000-default.conf /etc/apache2/sites-available
COPY index.php dwes.css /var/www/html/

EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]