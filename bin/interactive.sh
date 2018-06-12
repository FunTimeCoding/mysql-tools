#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)

usage()
{
    echo "Usage: ${0} [DATABASE]"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/mysql_tools.sh"
DATABASE="${1}"

if [ "${DATABASE}" = "" ]; then
    ${MYSQL}
else
    ${MYSQL} "${DATABASE}"
fi
