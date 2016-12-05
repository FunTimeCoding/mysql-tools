#!/bin/sh -e

CONFIG=~/.mysql-tools.conf

function_exists()
{
    declare -f -F "${1}" > /dev/null

    return $?
}

while true; do
    case ${1} in
        --config)
            CONFIG=${2-}
            shift 2
            ;;
        --help)
            echo "Global usage: ${0} [--help][--config CONFIG]"

            if function_exists usage; then
                usage
            fi

            exit 0
            ;;
        *)
            break
            ;;
    esac
done

CONFIG=$(realpath "${CONFIG}")

if [ -f "${CONFIG}" ]; then
    . "${CONFIG}"
fi

if [ "${ROOT_PASSWORD}" = "" ]; then
    MYSQL="${MYSQL} -uroot -p --protocol=tcp"
else
    MYSQL_PWD="${ROOT_PASSWORD}"
    export MYSQL_PWD
    MYSQL="${MYSQL} -uroot --protocol=tcp"
fi

export MYSQL
OPTIND=1
export CONFIG
