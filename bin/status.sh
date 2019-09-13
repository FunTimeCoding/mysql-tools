#!/bin/sh -e

bin/root-statement.sh "SHOW GLOBAL STATUS"
# Aborted_clients

bin/root-statement.sh "SHOW VARIABLES"
# wait_timeout default 28800, maybe double based on needs
# interacive_timeout default 28800, maybe double based on needs
# max_allowed_packet default 4mb, increase if application needs
