FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update && apt-get install -y \
  mod-gearman-worker                     \
  monitoring-plugins

ADD data/worker.conf /etc/mod-gearman/worker.conf
ENTRYPOINT ["/bin/sh", "-c", "rm -rf /run/worker.pid; /usr/sbin/mod_gearman_worker --config=/etc/mod-gearman/worker.conf --pidfile=/run/worker.pid"]

