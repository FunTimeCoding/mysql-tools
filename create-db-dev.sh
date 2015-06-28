#!/bin/sh

EXPECTED_ARGS=1
E_BAD_ARGS=1

if [ ${#} -ne ${EXPECTED_ARGS} ]; then
    echo "Usage: ${0} NAME"

    exit ${E_BAD_ARGS}
fi

./create-db.sh "${1}" "${1}" "${1}"
