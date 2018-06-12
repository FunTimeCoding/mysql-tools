#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)

usage()
{
    echo "Usage: ${0} [--user-host USER_HOST] DATABASE_NAME [USERNAME] [PASSWORD]"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/mysql_tools.sh"
USER_HOST=%

while true; do
    case ${1} in
        --user-host)
            USER_HOST="${2-}"
            shift 2
            ;;
        *)
            break
            ;;
    esac
done

DATABASE="${1}"
USERNAME="${2}"
PASSWORD="${3}"

if [ "${DATABASE}" = "" ]; then
    usage

    exit 1
fi

if [ "${USERNAME}" = "" ]; then
    USERNAME="${DATABASE}"
fi

if [ "${PASSWORD}" = "" ]; then
    PASSWORD="${USERNAME}"
fi

STATEMENT="CREATE DATABASE IF NOT EXISTS ${DATABASE};
GRANT USAGE ON *.* TO ${USERNAME}@'${USER_HOST}' IDENTIFIED BY '${PASSWORD}';
GRANT ALL PRIVILEGES ON ${DATABASE}.* TO ${USERNAME}@'${USER_HOST}';
FLUSH PRIVILEGES;"
${MYSQL} --execute "${STATEMENT}"
