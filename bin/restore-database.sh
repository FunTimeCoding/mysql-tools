#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)

usage()
{
    echo "Usage: ${0} [--with-user] DATABASE_NAME"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/mysql_tools.sh"
EXPECTED_ARGS=1
E_BAD_ARGS=1
E_FILE_NOT_FOUND=2

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

${MYSQL} "${DATABASE_NAME}" < "${FILE}"
