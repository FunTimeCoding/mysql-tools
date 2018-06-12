#!/bin/sh -e

CONFIGURATION=''

while true; do
    case ${1} in
        --help)
            echo "Global usage: ${0} [--help][--configuration CONFIGURATION]"

            if command -v usage > /dev/null; then
                usage
            fi

            exit 0
            ;;
        --configuration)
            CONFIGURATION=${2-}
            shift 2
            ;;
        *)
            break
            ;;
    esac
done

OPTIND=1

if [ "${CONFIGURATION}" = '' ]; then
    CONFIGURATION="${HOME}/.mysql-tools.sh"
fi

if [ ! -f "${CONFIGURATION}" ]; then
    echo "Config missing: ${CONFIGURATION}"

    exit 1
fi

# shellcheck source=/dev/null
. "${CONFIGURATION}"

if [ "${ROOT_PASSWORD}" = '' ]; then
    MYSQL="mysql --user=root --password --protocol=tcp"
    #MYSQL="mysql --user=root --password --protocol=socket --socket /var/run/mysqld/mysqld.sock"
else
    MYSQL_PWD="${ROOT_PASSWORD}"
    export MYSQL_PWD
    MYSQL="mysql --user=root --protocol=tcp"
fi

export MYSQL
