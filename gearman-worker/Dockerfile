FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV NAGIOS_PLUGIN_DIR /usr/lib/nagios/plugins


RUN apt-get update && apt-get install -y software-properties-common



RUN apt-get update && apt-get install -y \
  mod-gearman-worker                     \
  curl                                   \
  gettext                                \
  git                                    \
  jq                                     \
  monitoring-plugins

RUN curl -Lo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x /usr/local/bin/kubectl

WORKDIR /tmp
RUN git clone https://github.com/colebrooke/kubernetes-nagios && cd kubernetes-nagios && cp *.sh ${NAGIOS_PLUGIN_DIR}

ADD data/worker.conf /etc/mod-gearman/worker.conf
ADD entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

