#!/bin/sh -e

DATABASE_NAME="${1}"

if [ "${DATABASE_NAME}" = "" ]; then
    echo "Usage: ${0} DATABASE_NAME"

    exit 1
fi

MYSQL=$(which mysql)
SQL="SET @users = NULL;
SELECT GROUP_CONCAT('\'', user, '\'@\'', host, '\'') INTO @users FROM mysql.user WHERE user='${DATABASE_NAME}';
SET @users = CONCAT('DROP USER ', @users);
PREPARE delete_statement FROM @users;
EXECUTE delete_statement;
DEALLOCATE PREPARE delete_statement;
DELETE FROM mysql.db WHERE Db LIKE '${DATABASE_NAME}';
FLUSH PRIVILEGES;
DROP DATABASE IF EXISTS ${DATABASE_NAME};"
${MYSQL} -uroot -p --protocol=tcp -e "${SQL}"
