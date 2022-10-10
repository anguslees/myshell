FROM debian:testing@sha256:1259c7959ad6824834c9075c3cbd0dde3977680dd334c58de5b8a06ec121c9a1
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
