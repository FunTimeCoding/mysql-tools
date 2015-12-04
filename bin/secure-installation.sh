#!/bin/sh -e

MYSQL=$(which mysql)
HOST_NAME=$(hostname -s)
Q1="DROP USER IF EXISTS ''@'localhost';";
Q2="DROP USER IF EXISTS ''@'${HOST_NAME}';";
Q3="DELETE FROM mysql.db WHERE Db LIKE 'test%';"
Q4="FLUSH PRIVILEGES;"
Q5="DROP DATABASE IF EXISTS test;"
SQL="${Q1}${Q2}${Q3}${Q4}${Q5}"

${MYSQL} -uroot -p --protocol=tcp -e "${SQL}"
