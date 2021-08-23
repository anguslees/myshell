FROM debian:testing@sha256:b1a25a4b2dac3cbba059687d3c759f76ceb474ff2aa53b3d6a11fdd9b2b52f00
MAINTAINER Angus Lees <gus@inodes.org>

RUN \
    adduser --disabled-password --gecos '' user

RUN \
    set -e -x; \
    echo deb http://cdn-fastly.deb.debian.org/debian testing main contrib non-free > /etc/apt/sources.list.d/testing.list; \
    echo deb http://cdn-fastly.deb.debian.org/debian unstable main contrib non-free > /etc/apt/sources.list.d/unstable.list; \
    echo 'APT::Default-Release "testing";' > /etc/apt/apt.conf.d/50default-release

RUN \
    set -e -x; \
    apt-get -qy update; \
    apt-get -qy upgrade

RUN \
    set -e -x; \
    apt-get -qy update; \
    apt-get -qy install \
    vim-tiny emacs-nox git \
    zsh bash \
    sudo manpages procps man-db less rsync \
    docker.io kubernetes-client \
    telnet netcat-openbsd curl tcpdump strace inetutils-ping bind9-host mtr-tiny openssh-client dnsutils

RUN echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

USER user
WORKDIR /home/user
