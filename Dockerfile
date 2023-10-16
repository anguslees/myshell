FROM debian:testing@sha256:4fed7d248e6bdc5198e010113bd6869269f3f96179381e25b36a7b834e6a8a97
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
