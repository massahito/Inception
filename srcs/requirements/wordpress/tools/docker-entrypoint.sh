#!/bin/bash
cp -r /var/www/wordpress/* /var/www/html/
exec "$@" -F -R
