#!/bin/sh -x
rm /var/run/apache2/apache2.pid
envsubst < /etc/thruk/thruk_local.conf | tee /etc/thruk/thruk_local.conf
test -n "${THRUK_ADMIN_PASSWORD}" && htpasswd -b -c /etc/thruk/htpasswd thrukadmin ${THRUK_ADMIN_PASSWORD}
apachectl -DFOREGROUND
