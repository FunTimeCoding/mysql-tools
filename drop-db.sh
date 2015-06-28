#!/bin/sh -e

EXPECTED_ARGS=1
E_BAD_ARGS=1
MYSQL=$(which mysql)

if [ ${#} -ne ${EXPECTED_ARGS} ]; then
    echo "Usage: ${0} DATABASE_NAME"

    exit ${E_BAD_ARGS}
fi

NAME="${1}"
echo "Are you sure you want to drop ${NAME}? (y/n)"
read OPT

case ${OPT} in
    y)
        echo "Dropping ${NAME}."
        ;;
    n)
        echo "Not dropping ${NAME}."

        exit 0
        ;;
    *)
        echo "Invalid choice. Not dropping ${NAME}."

        exit 1
        ;;
esac

${MYSQL} -uroot -p -e "DROP DATABASE ${NAME}"
