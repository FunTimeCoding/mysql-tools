#!/bin/sh -e

export DEBIAN_FRONTEND=noninteractive
CODENAME=$(lsb_release --codename --short)

if [ "${CODENAME}" = jessie ]; then
    echo Europe/Berlin > /etc/timezone
    dpkg-reconfigure --frontend noninteractive tzdata
    apt-get --quiet 2 install vim multitail htop tree git
elif [ "${CODENAME}" = stretch ]; then
    apt-get --quiet 2 install neovim multitail htop tree git shellcheck

    # dirmngr is required to import the key
    apt-get --quiet 2 install dirmngr
    apt-key adv --keyserver keys.gnupg.net --recv-keys 8507EFA5
    echo "deb http://repo.percona.com/apt stretch main" > /etc/apt/sources.list.d/percona-source.list
    echo "deb-src http://repo.percona.com/apt stretch main" > /etc/apt/sources.list.d/percona-source.list
    apt-get --quiet 2 update
    apt-get --quiet 2 install percona-toolkit

    # TODO: How to install MySQL and not MariaDB? This still installs mariadb-server.
    #apt-get --quiet 2 install mysql-server
    apt-get --quiet 2 install mariadb-server

    mysqladmin --user root password 'root'
    cp /vagrant/configuration/mysql-tools.sh /home/vagrant/.mysql-tools.sh
    chmod 700 /home/vagrant/.mysql-tools.sh
    chown vagrant:vagrant /home/vagrant/.mysql-tools.sh
fi
