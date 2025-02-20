-- Creamos la base de datos
CREATE DATABASE IF NOT EXISTS `wordpress` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;

CREATE USER IF NOT EXISTS 'anton'
IDENTIFIED BY 'anton';

GRANT ALL ON `wordpress`.*
TO 'anton';