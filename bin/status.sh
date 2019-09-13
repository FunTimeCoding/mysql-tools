#!/bin/sh -e

bin/root-statement.sh "SHOW GLOBAL STATUS WHERE variable_name IN ('Aborted_clients', 'Bytes_received', 'Bytes_sent');"

bin/root-statement.sh "SHOW VARIABLES WHERE variable_name IN ('wait_timeout', 'interactive_timeout', 'max_allowed_packet');"
# wait_timeout default 28800, maybe double based on needs
# interacive_timeout default 28800, maybe double based on needs
# max_allowed_packet default 4mb, increase if application needs
