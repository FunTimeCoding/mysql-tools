#!/bin/sh -e

bin/create-database.sh example
bin/restore-database.sh example configuration/example.sql
#bin/statement.sh "SELECT * FROM guest" example
#bin/statement.sh "DESC example.guest"
echo "EXIT_CODE: $?"
