FROM ubuntu:bionic

RUN apt-get update && apt-get install -y  \
	gearman-job-server                      \
  gettext

RUN apt-get clean; \
    rm -rf /var/lib/apt/lists/*


ADD data/gearmand.conf /etc/gearmand.conf

ENTRYPOINT [ "gearmand" ]
