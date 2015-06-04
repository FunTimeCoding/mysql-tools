#!/bin/sh

EXPECTED_ARGS=1
E_BAD_ARGS=1
MYSQL=$(which mysql)

if [ ${#} -ne ${EXPECTED_ARGS} ]; then
    echo "Usage: ${0} DATABASE_NAME"

    exit ${E_BAD_ARGS}
fi

${MYSQL} -uroot -p -e "DROP DATABASE ${1}"
