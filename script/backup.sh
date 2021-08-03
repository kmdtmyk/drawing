#!/bin/bash

#  0 3 * * * /bin/bash -l -c 'cd ~/drawing && script/backup.sh >> log/crontab.log 2>&1'

cd $(dirname ${0})
cd ..

mkdir -p log
mkdir -p backup/db
mkdir -p backup/system

echo tar: start - $(date '+%Y/%m/%d %H:%M:%S')
tar zcf backup/system/$(date '+%Y%m%d_%H%M').tar.gz public/system
echo tar: end - $(date '+%Y/%m/%d %H:%M:%S')

echo pg_dump: start - $(date '+%Y/%m/%d %H:%M:%S')
/usr/local/bin/docker-compose exec -T db pg_dump -U app -v -Fc app_production -f /backup/db/$(date '+%Y%m%d_%H%M').dump
echo pg_dump: end - $(date '+%Y/%m/%d %H:%M:%S')
