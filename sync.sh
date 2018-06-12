#!/bin/sh -e

pt-table-sync --execute --user root --password root h=localhost,D=example,t=guest h=localhost,D=example2,t=guest && EXIT_CODE=$? || EXIT_CODE=$?

if [ "${EXIT_CODE}" = 0 ]; then
    echo "No difference."
elif [ "${EXIT_CODE}" = 2 ]; then
    echo "Synchronized."
else
    echo "Unexpected exit code: ${EXIT_CODE}"
fi

bin/statement.sh "SELECT * FROM guest;" example
bin/statement.sh "SELECT * FROM guest;" example2
