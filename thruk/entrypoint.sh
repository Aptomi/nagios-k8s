#!/bin/sh
rm /var/run/apache2/apache2.pid
apachectl -DFOREGROUND
