FROM debian:testing@sha256:2103138a247b932eb43ee5375e7f7b7d25ad90e95ea4325d7b1b2ff88db8afea
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
