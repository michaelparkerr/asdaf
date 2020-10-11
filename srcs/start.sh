#!/bin/bash
service mysql start
service php7.3-fpm start
service nginx start

while true;
	do sleep 10000;
done
