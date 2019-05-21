#!/bin/sh

envsubst < /etc/mod-gearman/module.conf | tee /etc/mod-gearman/module.conf
su - nagios -c "/opt/nagios/bin/nagios /opt/nagios/etc/nagios.cfg"
