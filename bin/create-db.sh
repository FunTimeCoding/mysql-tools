#!/bin/sh -e

USER_HOST="%"
#USER_HOST="localhost"
EXPECTED_ARGS=3
E_BAD_ARGS=1
MYSQL=$(which mysql)
Q1="CREATE DATABASE IF NOT EXISTS ${1};"
Q2="GRANT USAGE ON *.* TO ${2}@'${USER_HOST}' IDENTIFIED BY '${3}';"
Q3="GRANT ALL PRIVILEGES ON ${1}.* TO ${2}@'${USER_HOST}';"
Q4="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}"

if [ ${#} -ne ${EXPECTED_ARGS} ]; then
    echo "Usage: ${0} DATABASE_NAME USERNAME PASSWORD"

    exit ${E_BAD_ARGS}
fi

${MYSQL} -uroot -p --protocol=tcp -e "${SQL}"
