#!/bin/sh -e

EXPECTED_ARGS=1
E_BAD_ARGS=1
MYSQLDUMP=$(which mysqldump)

if [ ${#} -ne ${EXPECTED_ARGS} ]; then
    echo "Usage: ${0} DATABASE_NAME"
    exit ${E_BAD_ARGS}
fi

${MYSQLDUMP} -uroot -p --databases "${1}" > "${1}.sql"
