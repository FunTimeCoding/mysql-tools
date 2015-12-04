#!/bin/sh -e

usage()
{
    echo "Usage: ${0} [-h|--help][-d|--debug][-u|--user-host USER_HOST] DATABASE_NAME [USERNAME] [PASSWORD]"
}

USER_HOST="%"
VERBOSE=false

while true; do
    case ${1} in
        -h|--help)
            usage

            exit 0
            ;;
        -d|--debug)
            set -x
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -u|--user-host)
            USER_HOST="${2-}"
            shift 2
            ;;
        *)
            break
            ;;
    esac
done

MYSQL=$(which mysql)
DATABASE_NAME="${1}"
USERNAME="${2}"
PASSWORD="${3}"

if [ "${DATABASE_NAME}" = "" ]; then
    usage

    exit 1
fi

if [ "${USERNAME}" = "" ]; then
    USERNAME="${DATABASE_NAME}"
fi

if [ "${PASSWORD}" = "" ]; then
    PASSWORD="${USERNAME}"
fi

SQL="CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};
GRANT USAGE ON *.* TO ${USERNAME}@'${USER_HOST}' IDENTIFIED BY '${PASSWORD}';
GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO ${USERNAME}@'${USER_HOST}';
FLUSH PRIVILEGES;"

if [ "${VERBOSE}" = true ]; then
    echo "DATABASE_NAME: ${DATABASE_NAME}"
    echo "USERNAME: ${USERNAME}"
    echo "USER_HOST: ${USER_HOST}"

    if [ "${USERNAME}" = "${PASSWORD}" ]; then
        echo "Password is equal to username."
    fi
fi

${MYSQL} -uroot -p --protocol=tcp -e "${SQL}"
