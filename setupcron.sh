#!/bin/bash

echo "Setting up cronjob..."
mkdir -p /etc/cron.d/
CRONFILE=/etc/cron.d/tasmota-backup
echo -e "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\n${CRON_EXPRESSION} /usr/local/bin/backup.sh 2>&1 > /var/log/backup.log\n" > $CRONFILE
cat $CRONFILE
chmod 0644 $CRONFILE
crontab $CRONFILE
echo Starting cron
touch /var/log/cron.log
touch /var/log/backup.log
echo "Scheduled backups according to expression ${CRON_EXPRESSION}."
crond
echo "Listening to backup.log"
tail -f /var/log/backup.log /var/log/cron.log 

