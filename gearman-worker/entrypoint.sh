#!/bin/sh

envsubst < /etc/mod-gearman/worker.conf | tee /etc/mod-gearman/worker.conf

/usr/sbin/mod_gearman_worker --config=/etc/mod-gearman/worker.conf --pidfile=/run/worker.pid

