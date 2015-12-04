#!/bin/sh -e

EXPECTED_ARGS=1
E_BAD_ARGS=1
E_FILE_EXISTS=2
MYSQLDUMP=$(which mysqldump)

if [ ${#} -ne ${EXPECTED_ARGS} ]; then
    echo "Usage: ${0} DATABASE_NAME"

    exit ${E_BAD_ARGS}
fi

DATABASE_NAME="${1}"
FILE="${DATABASE_NAME}-full.sql"

if [ -f "${FILE}" ]; then
    echo "File exists: ${FILE}"

    exit ${E_FILE_EXISTS}
fi

${MYSQLDUMP} -uroot -p --protocol=tcp --databases "${DATABASE_NAME}" > "${FILE}"
