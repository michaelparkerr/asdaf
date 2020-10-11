FROM debian:buster

RUN apt update
RUN apt install -y nginx
RUN apt install -y default-mysql-server
RUN apt install -y php php-cli php-fpm php-cgi php-mysql php-mbstring
RUN apt install -y openssl
RUN apt install -y zip

RUN openssl req -new -newkey rsa:2048 -nodes \
 -subj='/C=KR/ST=Seoul/L=Yangcheon/O=42Seoul/OU=student' \
 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.csr
RUN openssl x509 -req -days 365 -in /etc/ssl/certs/localhost.csr -signkey /etc/ssl/certs/localhost.key \
-out /etc/ssl/certs/localhost.crt 

COPY ./srcs/default /etc/nginx/sites-available

COPY ./srcs/phpMyAdmin-5.0.2-all-languages.zip /var/www/html
RUN unzip /var/www/html/phpMyAdmin-5.0.2-all-languages.zip -d /var/www/html
RUN mv /var/www/html/phpMyAdmin-5.0.2-all-languages /var/www/html/phpmyadmin

COPY ./srcs/wp-init.sql /tmp
COPY ./srcs/wordpress.zip /var/www/html
COPY ./srcs/start.sh /var/start.sh

RUN unzip /var/www/html/wordpress.zip -d /var/www/html
RUN service mysql start && mysql -u root < /tmp/wp-init.sql

CMD bash /var/start.sh
