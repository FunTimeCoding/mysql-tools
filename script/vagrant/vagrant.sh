#!/bin/sh -e

cp /vagrant/configuration/mysql-tools.sh "${HOME}/.mysql-tools.sh"
chmod 600 /home/vagrant/.mysql-tools.sh

bin/create-database.sh example
bin/restore-database.sh example configuration/example.sql
#bin/statement.sh "SELECT * FROM guest" example
#bin/statement.sh "DESC example.guest"
