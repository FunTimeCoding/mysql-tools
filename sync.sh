#!/bin/sh -e

pt-table-sync --execute --user root --password root h=localhost,D=example,t=guest h=localhost,D=example2,t=guest

bin/statement.sh "SELECT * FROM guest;" example
bin/statement.sh "SELECT * FROM guest;" example2
