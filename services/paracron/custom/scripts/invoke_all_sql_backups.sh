#!/usr/bin/env bash
set -euo pipefail

echo "[$(date)] SQL Backup Started"

SQL_USER=backup_user

# MYSQL config
MYSQL_HOST=172.28.0.14
MYSQL_PORT=3306
declare -A MYSQL_DBS=(
    # Forums
    ["paradise_forums"]="/data/mysql_backups/forums" 
    # Game DB
    ["paradise_gamedb"]="/data/mysql_backups/gamedb"
    # PR DB
    ["aa07_pr_voting"]="/data/mysql_backups/prs"
    # TGS DB
    ["paradise_tgs_espresso3"]="/data/mysql_backups/tgs"
    # Wiki DB
    ["paradise_wiki"]="/data/mysql_backups/wiki"
    )

for db in "${!MYSQL_DBS[@]}"; do
    echo "MySQL Backup started for database - ${db}"
    backup_mysql.sh --host ${MYSQL_HOST} --port ${MYSQL_PORT} --user ${SQL_USER} --password ${MYSQL_BACKUP_PW} --dbname ${db} --backuppath ${MYSQL_DBS[$db]};
    if [ $? -eq 0 ]; then
        echo "Database backup successfully completed"
    else
        echo "Error found during backup"
    fi
done
