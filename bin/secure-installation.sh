#!/bin/sh -e

MYSQL=$(which mysql)
HOST_NAME=$(hostname -s)
SQL="DROP USER IF EXISTS ''@'localhost';
DROP USER IF EXISTS ''@'${HOST_NAME}';
DELETE FROM mysql.db WHERE Db LIKE 'test%';
FLUSH PRIVILEGES;
DROP DATABASE IF EXISTS test;"
${MYSQL} -uroot -p --protocol=tcp -e "${SQL}"
