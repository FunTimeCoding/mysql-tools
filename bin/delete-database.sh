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
DATABASE_SQL="DROP DATABASE IF EXISTS ${DATABASE_NAME};"

if [ "${WITH_USER}" = true ]; then
    USER_SQL="SET @users = NULL;
    SELECT GROUP_CONCAT('\'', user, '\'@\'', host, '\'') INTO @users FROM mysql.user WHERE user='${DATABASE_NAME}';
    SET @users = CONCAT('DROP USER ', @users);
    PREPARE delete_statement FROM @users;
    EXECUTE delete_statement;
    DEALLOCATE PREPARE delete_statement;
    DELETE FROM mysql.db WHERE Db LIKE '${DATABASE_NAME}';
    FLUSH PRIVILEGES;"
    SQL="${USER_SQL}${DATABASE_SQL}"
else
    SQL="${DATABASE_SQL}"
fi

${MYSQL} -uroot -p --protocol=tcp -e "${SQL}"
