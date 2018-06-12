#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)

usage()
{
    echo "Usage: ${0} DATABASE STATEMENT"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/mysql_tools.sh"

DATABASE="${1}"
STATEMENT="${2}"

if [ "${DATABASE}" = "" ] || [ "${STATEMENT}" = "" ]; then
    usage

    exit 1
fi

${MYSQL} "${DATABASE}" --execute "${STATEMENT}"
