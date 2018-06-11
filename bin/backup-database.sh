#!/bin/sh -e

usage()
{
    echo "Usage: ${0} [--structure-only] DATABASE_NAME"
}

STRUCTURE_ONLY=false

if [ "${1}" = --structure-only ]; then
    STRUCTURE_ONLY=true
    shift
fi

DATABASE_NAME="${1}"

if [ "${DATABASE_NAME}" = "" ]; then
    usage

    exit 1
fi

if [ "${STRUCTURE_ONLY}" = true ]; then
    FILE="${DATABASE_NAME}-structure.sql"
else
    FILE="${DATABASE_NAME}-full.sql"
fi

if [ -f "${FILE}" ]; then
    echo "File exists: ${FILE}"

    exit 1
fi

if [ "${STRUCTURE_ONLY}" = true ]; then
    mysqldump --user=root --password --protocol=tcp --no-data --databases "${DATABASE_NAME}" > "${FILE}"
else
    mysqldump --user=root --password --protocol=tcp --databases "${DATABASE_NAME}" > "${FILE}"
fi
