FROM ubuntu:bionic as builder

ARG NAGIOS_VERSION=4.4.3
ARG LIVESTATUS_VERSION=1.2.8
ARG MOD_GEARMAN_COMMIT=d9d01c7626e3ac23b323d4e2ac5a79f1f3e6968a

ENV NAGIOS_HOME            /opt/nagios
ENV NAGIOS_USER            nagios
ENV NAGIOS_GROUP           nagios
ENV NAGIOS_CMDUSER         nagios
ENV NAGIOS_CMDGROUP        nagios


RUN apt-get update && apt-get install -y  \
    build-essential                       \
    wget                                  \
    libltdl-dev                           \
    ncurses-dev                           \
    pkg-config                            \
    libgearman-dev                        \
    git                                   \
    gettext                               \
    autoconf2.64                          \
    unzip

RUN ( egrep -i "^${NAGIOS_GROUP}"    /etc/group || groupadd $NAGIOS_GROUP    )                         && \
    ( egrep -i "^${NAGIOS_CMDGROUP}" /etc/group || groupadd $NAGIOS_CMDGROUP )
RUN ( id -u $NAGIOS_USER    || useradd --system -d $NAGIOS_HOME -g $NAGIOS_GROUP    $NAGIOS_USER    )  && \
    ( id -u $NAGIOS_CMDUSER || useradd --system -d $NAGIOS_HOME -g $NAGIOS_CMDGROUP $NAGIOS_CMDUSER )


WORKDIR /tmp/
RUN wget https://github.com/NagiosEnterprises/nagioscore/archive/nagios-${NAGIOS_VERSION}.tar.gz
RUN tar zxvf nagios-${NAGIOS_VERSION}.tar.gz
WORKDIR /tmp/nagioscore-nagios-${NAGIOS_VERSION}


RUN ./configure --prefix=${NAGIOS_HOME}                  \
        --exec-prefix=${NAGIOS_HOME}             \
        --enable-event-broker                    \
        --with-command-user=${NAGIOS_CMDUSER}    \
        --with-command-group=${NAGIOS_CMDGROUP}  \
        --with-nagios-user=${NAGIOS_USER}        \
        --with-nagios-group=${NAGIOS_GROUP}
RUN make all
RUN make install
RUN make install-config
RUN make install-commandmode
RUN make clean

RUN git clone --single-branch --branch ${LIVESTATUS_VERSION} https://github.com/tribe29/checkmk/ /tmp/checkmk
WORKDIR /tmp/checkmk/livestatus
RUN autoheader &&  aclocal && automake --add-missing  && autoconf
# LOL
RUN autoheader &&  aclocal && automake --add-missing  && autoconf

RUN ./configure --with-nagios4
RUN make
RUN make install


WORKDIR /tmp
RUN git clone https://github.com/sni/mod_gearman
WORKDIR /tmp/mod_gearman
#RUN git checkout ${MOD_GEARMAN_COMMIT}
RUN ./autogen.sh
RUN ./configure --disable-nagios3-neb-module --enable-nagios4-neb-module --disable-naemon-neb-module
RUN make install

FROM ubuntu:bionic
ENV NAGIOS_HOME            /opt/nagios
ENV NAGIOS_USER            nagios
ENV NAGIOS_GROUP           nagios
COPY --from=builder /opt/nagios /opt/nagios
COPY --from=builder /etc/ /etc/
COPY --from=builder /usr/local/lib/mk-livestatus/livestatus.o /usr/local/lib/mk-livestatus/livestatus.o
COPY --from=builder /usr/local/lib/mod_gearman/ /usr/local/lib/mod_gearman/

# XXX copy from build container
RUN apt-get update && apt install -y libltdl-dev  \
      gettext                                     \
      libgearman-dev &&                           \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /opt/nagios/etc/conf.d
RUN chown -R ${NAGIOS_USER}:${NAGIOS_GROUP} ${NAGIOS_HOME}
ADD data/module.conf /etc/mod-gearman/module.conf
ADD data/nagios.cfg /opt/nagios/etc/nagios.cfg
ADD data/resource.cfg /opt/nagios/etc/resource.cfg
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
