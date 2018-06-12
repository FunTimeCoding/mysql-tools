#!/bin/sh -e

bin/create-database.sh example
bin/restore-database.sh example configuration/example.sql
#bin/statement.sh example "GRANT ALL PRIVILEGES ON `example`.* TO 'example'@'%'"
#bin/statement.sh example "SELECT * FROM guest"
#bin/statement.sh example "DESC guest"
echo "EXIT_CODE: $?"
