#!/bin/sh -e

EXPECTED_ARGS=1
E_BAD_ARGS=1
E_FILE_NOT_FOUND=2
MYSQL=$(which mysql)

if [ ${#} -ne ${EXPECTED_ARGS} ]; then
    echo "Usage: ${0} DATABASE_NAME"

    exit ${E_BAD_ARGS}
fi

DATABASE_NAME="${1}"
FILE="${DATABASE_NAME}.sql"

if [ ! -f "${FILE}" ]; then
    echo "File not found: ${FILE}"

    exit ${E_FILE_NOT_FOUND}
fi

${MYSQL} --user=root --password --protocol=tcp "${DATABASE_NAME}" < "${FILE}"
