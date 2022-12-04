#!/bin/bash

LOGPATH=logs
BACKUPPATH=/data

failcounter=0

mkdir -p $LOGPATH
echo "[$(date)] Starting backup..."
for device in $DEVICES
do
    config=(${device//;/ })
    PASSWORD=${config[1]}
    HOST=${config[0]}
    DESTINATION_DIR=${BACKUPPATH}/${HOST}
    DESTINATION=${DESTINATION_DIR}/$(date +%s).dmp

    
    echo -n "Backing up ${HOST} ..."
    mkdir -p ${DESTINATION_DIR}
    decode-config.py --source http://${HOST} --password ${PASSWORD} --backup-type dmp --backup-file ${DESTINATION} &> ${LOGPATH}/${HOST}.log
    if [ $? -ne 0 ]; then
        echo "failed"
        let "failcounter+=1" 
    else
        echo "ok"
    fi
done
echo -e "Backup finished\n"
exit $failcounter