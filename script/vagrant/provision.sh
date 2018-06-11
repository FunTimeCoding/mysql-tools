#!/bin/sh -e

export DEBIAN_FRONTEND=noninteractive
CODENAME=$(lsb_release --codename --short)

if [ "${CODENAME}" = jessie ]; then
    echo Europe/Berlin > /etc/timezone
    dpkg-reconfigure --frontend noninteractive tzdata
    apt-get --quiet 2 install vim multitail htop tree git
elif [ "${CODENAME}" = stretch ]; then
    apt-get --quiet 2 install neovim multitail htop tree git shellcheck

    # TODO: How to install MySQL and not MariaDB? This still installs mariadb-server.
    #apt-get --quiet 2 install mysql-server
    apt-get --quiet 2 install mariadb-server
fi
