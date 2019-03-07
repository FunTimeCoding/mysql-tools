#!/bin/sh -e

export DEBIAN_FRONTEND='noninteractive'
apt-get --quiet 2 install neovim multitail htop tree git shellcheck hunspell devscripts ruby-ronn

# dirmngr is required to import the key
apt-get --quiet 2 install dirmngr
apt-key adv --keyserver keys.gnupg.net --recv-keys 8507EFA5
echo 'deb http://repo.percona.com/apt stretch main' > /etc/apt/sources.list.d/percona.list
echo 'deb-src http://repo.percona.com/apt stretch main' > /etc/apt/sources.list.d/percona-source.list
apt-get --quiet 2 update
apt-get --quiet 2 install percona-toolkit debconf-utils
DISTRIBUTION='mariadb'
ROOT_PASSWORD='root'

if [ "${DISTRIBUTION}" = 'debian' ]; then
    apt-get --quiet 2 install mariadb-server
    mysqladmin --user root password "${ROOT_PASSWORD}"
    # Remove unix_socket plugin to allow root login via localhost.
    mysql --user=root --execute "UPDATE mysql.user SET plugin = '' WHERE User = 'root';
    FLUSH PRIVILEGES;"
    cp /vagrant/configuration/60-development.cnf /etc/mysql/mariadb.conf.d
    systemctl restart mariadb
elif [ "${DISTRIBUTION}" = 'mariadb' ]; then
    apt-key adv --keyserver keys.gnupg.net --recv-keys 0xF1656F24C74CD1D8
    # Known versions: 10.1, 10.2, 10.3, 10.4
    MARIADB_VERSION='10.3'
    echo "deb [arch=amd64] http://downloads.mariadb.com/MariaDB/mariadb-${MARIADB_VERSION}/repo/debian stretch main" > /etc/apt/sources.list.d/mariadb.list
    apt-get --quiet 2 update
    echo "mariadb-server-${MARIADB_VERSION} mysql-server/root_password password ${ROOT_PASSWORD}" | debconf-set-selections
    echo "mariadb-server-${MARIADB_VERSION} mysql-server/root_password_again password ${ROOT_PASSWORD}" | debconf-set-selections
    apt-get --quiet 2 install mariadb-server
elif [ "${DISTRIBUTION}" = 'percona' ]; then
    # Known versions: 5.5, 5.6, 5.7, 8.0
    PERCONA_VERSION='5.5'
    echo "percona-server-server-${PERCONA_VERSION} percona-server-server/root_password password ${ROOT_PASSWORD}" | debconf-set-selections
    echo "percona-server-server-${PERCONA_VERSION} percona-server-server/root_password_again password ${ROOT_PASSWORD}" | debconf-set-selections
    apt-get --quiet 2 install "percona-server-server-${PERCONA_VERSION}"
elif [ "${DISTRIBUTION}" = 'oracle' ]; then
    apt-key adv --keyserver keys.gnupg.net --recv-keys 5072E1F5
    # Known versions: 5.6, 5.7, 8.0
    echo 'deb http://repo.mysql.com/apt/debian/ stretch mysql-5.6' > /etc/apt/sources.list.d/mysql.list
    echo "mysql-community-server mysql-community-server/root-pass password ${ROOT_PASSWORD}" | debconf-set-selections
    echo "mysql-community-server mysql-community-server/re-root-pass password ${ROOT_PASSWORD}" | debconf-set-selections
    apt-get --quiet 2 update
    apt-get --quiet 2 install mysql-server
else
    echo "Unexpected distribution: ${DISTRIBUTION}"

    exit 1
fi
