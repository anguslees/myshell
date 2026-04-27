FROM debian:testing@sha256:e0c4680937ec5c89f44b977ebd8bff697e6d0d5157b46f6d6592d46fa08dbaf3
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
    telnet netcat-openbsd curl tcpdump strace inetutils-ping bind9-host mtr-tiny openssh-client dnsutils \
    gnupg wget; \
    rm -rf /var/lib/apt/lists/*

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
    apt-get -qy install \
    tailscale tailscale-archive-keyring; \
    rm -rf /var/lib/apt/lists/*

RUN \
    set -e -x; \
    adduser --disabled-password --gecos '' user; \
    echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

USER user
WORKDIR /home/user
