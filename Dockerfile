FROM debian:testing
MAINTAINER Angus Lees <gus@inodes.org>

RUN \
    echo deb http://cdn-fastly.deb.debian.org/debian testing main contrib non-free > /etc/apt/sources.list.d/testing.list && \
    echo deb http://cdn-fastly.deb.debian.org/debian unstable main contrib non-free > /etc/apt/sources.list.d/unstable.list && \
    echo 'APT::Default-Release "testing";' > /etc/apt/apt.conf.d/50default-release

RUN \
    apt-get -qy update && \
    apt-get -qy upgrade && \
    apt-get -qy install \
    vim-tiny emacs-nox git \
    zsh \
    manpages man-db less rsync docker.io \
    telnet netcat-openbsd tcpdump strace inetutils-ping bind9-host mtr-tiny procps
