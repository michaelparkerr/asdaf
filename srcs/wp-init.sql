CREATE DATABASE wp_db;
CREATE USER wp_user@localhost;
SET PASSWORD FOR wp_user@localhost=PASSWORD('hello');
GRANT ALL PRIVILEGES ON wp_db.* TO wp_user@localhost IDENTIFIED BY 'hello';
FLUSH PRIVILEGES;
