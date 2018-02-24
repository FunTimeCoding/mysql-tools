#!/bin/sh -e

CONFIG=""

while true; do
    case ${1} in
        --help)
            echo "Global usage: ${0} [--help][--config CONFIG]"

            if command -v usage > /dev/null; then
                usage
            fi

            exit 0
            ;;
        --config)
            CONFIG=${2-}
            shift 2
            ;;
        *)
            break
            ;;
    esac
done

OPTIND=1

if [ "${CONFIG}" = "" ]; then
    CONFIG="${HOME}/.mysql-tools.sh"
fi

if [ ! -f "${CONFIG}" ]; then
    echo "Config missing: ${CONFIG}"

    exit 1
fi

# shellcheck source=/dev/null
. "${CONFIG}"

if [ "${ROOT_PASSWORD}" = "" ]; then
    MYSQL="mysql --user=root --password --protocol=tcp"
else
    MYSQL_PWD="${ROOT_PASSWORD}"
    export MYSQL_PWD
    MYSQL="mysql --user=root --protocol=tcp"
fi

export MYSQL
