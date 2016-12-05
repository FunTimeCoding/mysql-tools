#!/bin/sh -e

~/Code/Personal/jenkins-tools/bin/delete-job.sh mysql-tools || true
~/Code/Personal/jenkins-tools/bin/put-job.sh mysql-tools job.xml
