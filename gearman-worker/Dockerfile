FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true


RUN apt-get update && apt-get install -y \
  mod-gearman-worker                     \
  gettext                                \
  jq                                     \
  docker.io                              \
  monitoring-plugins

ADD data/worker.conf /etc/mod-gearman/worker.conf
ADD entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

