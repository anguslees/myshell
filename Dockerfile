FROM debian:testing@sha256:e3137473f15c063761b0e3b710e2f243c981012b466497a51e8a5e44e07a0b57
MAINTAINER Angus Lees <gus@inodes.org>

RUN \
    set -e -x; \
    echo deb http://cdn-fastly.deb.debian.org/debian testing main contrib non-free > /etc/apt/sources.list.d/testing.list; \
    echo deb http://cdn-fastly.deb.debian.org/debian unstable main contrib non-free > /etc/apt/sources.list.d/unstable.list; \
    echo 'APT::Default-Release "testing";' > /etc/apt/apt.conf.d/50default-release

RUN \
    set -e -x; \
    mkdir -p --mode=0755 /usr/share/keyrings; \
    curl -fsSL https://pkgs.tailscale.com/stable/debian/forky.noarmor.gpg | tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null; \
    chmod 0644 /usr/share/keyrings/tailscale-archive-keyring.gpg; \
    curl -fsSL https://pkgs.tailscale.com/stable/debian/forky.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list; \
    chmod 0644 /etc/apt/sources.list.d/tailscale.list

RUN \
    set -e -x; \
    apt-get -qy update; \
    apt-get -qy upgrade; \
    apt-get -qy install \
    vim-tiny emacs-nox git \
    zsh bash adduser \
    sudo manpages procps man-db less rsync \
    docker.io kubernetes-client \
    telnet netcat-openbsd curl tcpdump strace inetutils-ping bind9-host mtr-tiny openssh-client dnsutils \
    tailscale tailscale-archive-keyring

RUN \
    set -e -x; \
    adduser --disabled-password --gecos '' user; \
    echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

USER user
WORKDIR /home/user
