#!/bin/sh
rm /var/run/apache2/apache2.pid
envsubst < /etc/thruk/thruk_local.conf | tee /etc/thruk/thruk_local.conf
apachectl -DFOREGROUND
