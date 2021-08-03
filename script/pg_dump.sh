#!/bin/bash

# 0 3 * * * /bin/bash -l -c 'cd ~/drawing && script/pg_dump.sh >> log/crontab.log 2>&1'

set -e

cd $(dirname ${0})
cd ..

echo pg_dump: start - $(date '+%Y/%m/%d %H:%M:%S')

/usr/local/bin/docker-compose exec -T db pg_dump -U app -v app_production -f /tmp/backup.sql
docker cp drawing_db_1:/tmp/backup.sql backup/$(date "+%Y%m%d_%H%M").sql

cd backup
# 新しいの5個だけ残して削除する
find . -name "*.sql" | sort -r | tail -n +6 | xargs -i rm {}

echo pg_dump: end - $(date '+%Y/%m/%d %H:%M:%S')

