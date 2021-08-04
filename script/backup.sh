#!/bin/bash

# 10 3 * * * /bin/bash -l -c 'cd ~/drawing && script/backup.sh >> log/crontab.log 2>&1'

set -e

cd $(dirname ${0})
cd ..

mkdir -p backup/system

echo tar: start - $(date '+%Y/%m/%d %H:%M:%S')

tar zcf backup/system/$(date '+%Y%m%d_%H%M').tar.gz public/system

cd backup/system
# 新しいの5個だけ残して削除する
find . -name "*.tar.gz" | sort -r | tail -n +6 | xargs -i rm {}

echo tar: end - $(date '+%Y/%m/%d %H:%M:%S')
