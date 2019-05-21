#FROM ubuntu:xenial
FROM ubuntu:bionic
RUN apt-get update && apt install -y \
  gettext                            \
	gpg
RUN  gpg --keyserver ipv4.pool.sks-keyservers.net --recv-keys F8C1CA08A57B9ED7 && gpg --armor --export F8C1CA08A57B9ED7 | apt-key add -
#RUN echo "deb http://labs.consol.de/repo/stable/ubuntu xenial main" > /etc/apt/sources.list.d/labs-consol-stable.list
RUN  echo "deb http://labs.consol.de/repo/stable/ubuntu bionic main" > /etc/apt/sources.list.d/labs-consol-stable.list

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true


RUN apt-get update
ENV TZ 'Europe/Samara'
RUN echo $TZ > /etc/timezone
RUN apt-get install -y thruk tzdata
RUN a2enmod ldap
RUN a2enmod authnz_ldap
#ADD htpasswd /etc/thruk/htpasswd
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
ADD data/thruk_local.conf /etc/thruk/thruk_local.conf
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
