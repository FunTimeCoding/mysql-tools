#!/bin/sh -e

usage()
{
    echo "Usage: ${0} [--with-user] DATABASE_NAME"
}

WITH_USER=false

if [ "${1}" = --with-user ]; then
    WITH_USER=true
    shift
fi

DATABASE_NAME="${1}"

if [ "${DATABASE_NAME}" = "" ]; then
    usage

    exit 1
fi

MYSQL=$(which mysql)
DATABASE_STATEMENT="DROP DATABASE IF EXISTS ${DATABASE_NAME};"

if [ "${WITH_USER}" = true ]; then
    # shellcheck disable=SC1117
    USER_STATEMENT="SET @users = NULL;
    SELECT GROUP_CONCAT('\'', user, '\'@\'', host, '\'') INTO @users FROM mysql.user WHERE user='${DATABASE_NAME}';
    SET @users = CONCAT('DROP USER ', @users);
    PREPARE delete_statement FROM @users;
    EXECUTE delete_statement;
    DEALLOCATE PREPARE delete_statement;
    DELETE FROM mysql.db WHERE Db LIKE '${DATABASE_NAME}';
    FLUSH PRIVILEGES;"
    STATEMENT="${USER_STATEMENT}${DATABASE_STATEMENT}"
else
    STATEMENT="${DATABASE_STATEMENT}"
fi

${MYSQL} --user=root --password --protocol=tcp --execute "${STATEMENT}"
