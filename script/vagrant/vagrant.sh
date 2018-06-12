#!/bin/sh -e

/vagrant/bin/create-database.sh example
cd /vagrant/configuration
../bin/restore-database.sh example
#../bin/query.sh example "SELECT * FROM guest"
#../bin/query.sh example "DESC guest"
echo "EXIT_CODE: $?"
