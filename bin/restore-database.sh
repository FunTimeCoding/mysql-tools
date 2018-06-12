#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)

usage()
{
    echo "Usage: ${0} NAME [FILE]"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/mysql_tools.sh"
DATABASE="${1}"
FILE="${2}"

if [ "${DATABASE}" = "" ]; then
    usage

    exit 1
fi

if [ "${FILE}" = "" ]; then
    FILE="${DATABASE}.sql"
fi

if [ ! -f "${FILE}" ]; then
    echo "File not found: ${FILE}"

    exit 1
fi

${MYSQL} "${DATABASE}" < "${FILE}"
