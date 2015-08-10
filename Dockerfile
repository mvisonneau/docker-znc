# ZNC 1.6.1
# VERSION 1.0

FROM ubuntu:latest
MAINTAINER Maxime VISONNEAU

ADD http://znc.in/releases/znc-1.6.1.tar.gz /tmp/

RUN apt-get update; \
	apt-get -y install build-essential libssl-dev libperl-dev pkg-config ca-certificates; \
	cd /tmp && tar -xzvf /tmp/znc* && cd znc*; \
	./configure; \
	make; \
	make install; \
	apt-get -y purge binutils build-essential cpp cpp-4.8 dpkg-dev fakeroot \
    g++ g++-4.8 gcc gcc-4.8 libalgorithm-diff-perl libalgorithm-diff-xs-perl \
    libalgorithm-merge-perl libasan0 libatomic1 libc-dev-bin libc6-dev \
    libcloog-isl4 libdpkg-perl libfakeroot libfile-fcntllock-perl \
    libgcc-4.8-dev libglib2.0-0 libglib2.0-data libgmp10 libgomp1 libisl10 \
    libitm1 libmpc3 libmpfr4 libperl-dev libperl5.18 libquadmath0 libssl-dev \
    libssl-doc libstdc++-4.8-dev libtimedate-perl libtsan0 libxml2 \
    linux-libc-dev make manpages manpages-dev patch pkg-config sgml-base \
    shared-mime-info xml-core xz-utils zlib1g-dev; \
    apt-get clean && apt-get autoclean; \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*
	
# Create a 'znc' user so we don't run znc as root. HOME=/var/znc
RUN adduser --system --group --home /var/znc --shell /bin/bash znc
USER znc
ENV HOME /var/znc

# Add data volume to hold ZNC config files
VOLUME ["/var/znc"]

ENTRYPOINT ["/usr/local/bin/znc"]
CMD ["--foreground"]