#!/bin/bash

# 10 3 * * * /bin/bash -l -c 'cd ~/drawing && script/backup.sh >> log/crontab.log 2>&1'

set -e

cd $(dirname ${0})
cd ..

mkdir -p backup/system

echo tar: start - $(date '+%Y/%m/%d %H:%M:%S')
tar zcf backup/system/$(date '+%Y%m%d_%H%M').tar.gz public/system
echo tar: end - $(date '+%Y/%m/%d %H:%M:%S')
