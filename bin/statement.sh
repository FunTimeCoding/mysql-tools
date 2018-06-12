#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)

usage()
{
    echo "Usage: ${0} STATEMENT [DATABASE]"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/mysql_tools.sh"

STATEMENT="${1}"
DATABASE="${2}"

if [ "${STATEMENT}" = "" ]; then
    usage

    exit 1
fi

if [ "${DATABASE}" = "" ]; then
    ${MYSQL} --execute "${STATEMENT}"
else
    ${MYSQL} "${DATABASE}" --execute "${STATEMENT}"
fi
