FROM debian:testing@sha256:6e4f6fef9ab54627c1d7224d90259a0d059ac16ab0e37d35862449b41a8dd483
MAINTAINER Angus Lees <gus@inodes.org>

RUN \
    set -e -x; \
    echo deb http://cdn-fastly.deb.debian.org/debian testing main contrib non-free > /etc/apt/sources.list.d/testing.list; \
    echo deb http://cdn-fastly.deb.debian.org/debian unstable main contrib non-free > /etc/apt/sources.list.d/unstable.list; \
    echo 'APT::Default-Release "testing";' > /etc/apt/apt.conf.d/50default-release

RUN \
    set -e -x; \
    apt-get -qy update; \
    apt-get -qy upgrade; \
    apt-get -qy install \
    vim-tiny emacs-nox git \
    zsh bash adduser \
    sudo manpages procps man-db less rsync \
    docker.io kubernetes-client \
    telnet netcat-openbsd curl tcpdump strace inetutils-ping bind9-host mtr-tiny openssh-client dnsutils

RUN \
    set -e -x; \
    adduser --disabled-password --gecos '' user; \
    echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

USER user
WORKDIR /home/user
