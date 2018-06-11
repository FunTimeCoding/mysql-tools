#!/bin/sh -e

HOST_NAME=$(hostname -s)
STATEMENT="DROP USER IF EXISTS ''@'localhost';
DROP USER IF EXISTS ''@'${HOST_NAME}';
DELETE FROM mysql.db WHERE Db LIKE 'test%';
FLUSH PRIVILEGES;
DROP DATABASE IF EXISTS test;"
mysql --user=root --password --protocol=tcp --execute "${STATEMENT}"
