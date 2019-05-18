FROM ubuntu:bionic

RUN apt-get update && apt-get install -y  \
	gearman-job-server

RUN apt-get clean; \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "gearmand" ]
