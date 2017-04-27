#!/bin/sh -e

zcat /var/log/mysql/mysql.log.1.gz | grep ' Connect' | sed -e 's/.*Connect//' | sort | uniq
