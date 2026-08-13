#!/usr/bin/env bash
set -euo pipefail

echo "[$(date)] SQL Backup Started"

# Forums
backup_mysql.sh --host 172.28.0.14 --user backup_user --password ${MYSQL_BACKUP_PW} --dbname paradise_forums --backuppath /data/mysql_backups/forums
# Game DB
backup_mysql.sh --host 10.0.0.10 --user backup_user --password ${MYSQL_BACKUP_PW} --dbname paradise_gamedb --backuppath /data/mysql_backups/gamedb
# PR DB
backup_mysql.sh --host 172.28.0.14 --user backup_user --password ${MYSQL_BACKUP_PW} --dbname aa07_pr_voting --backuppath /data/mysql_backups/prs
# TGS DB
backup_mysql.sh --host 10.0.0.10 --user backup_user --password ${MYSQL_BACKUP_PW} --dbname paradise_tgs_espresso3 --backuppath /data/mysql_backups/tgs
# Wiki DB
backup_mysql.sh --host 172.28.0.14 --user backup_user --password ${MYSQL_BACKUP_PW} --dbname paradise_wiki --backuppath /data/mysql_backups/wiki
