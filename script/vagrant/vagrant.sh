#!/bin/sh -e

bin/create-database.sh example
bin/restore-database.sh example configuration/example.sql
bin/statement.sh "GRANT ALL PRIVILEGES ON `example2`.* TO 'example'@'%'"
#bin/statement.sh "SELECT * FROM guest" example
#bin/statement.sh "DESC example.guest"
echo "EXIT_CODE: $?"
