#!/usr/bin/env bash
set -uo pipefail

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

# Postgres config
POSTGRES_HOST=172.28.0.9
POSTGRES_PORT=5432
declare -A POSTGRES_DBS=(
    ["authentik"]="/data/postgres_backups/authentik"
    ["bab"]="/data/postgres_backups/bab"
)

FAILED=0

for db in "${!MYSQL_DBS[@]}"; do
    echo "MySQL backup started for database: ${db}"
    if backup_mysql.sh \
        --host "${MYSQL_HOST}" \
        --port "${MYSQL_PORT}" \
        --user "${SQL_USER}" \
        --password "${MYSQL_BACKUP_PW}" \
        --dbname "${db}" \
        --backuppath "${MYSQL_DBS[$db]}"
    then
        echo "MYSQL backup completed: $db"
    else
        echo "MYSQL backup failed: $db"
        FAILED=1
    fi
done

for db in "${!POSTGRES_DBS[@]}"; do
    echo "PostgreSQL backup started for database: ${db}"

    if backup_postgres.sh \
        --host "$POSTGRES_HOST" \
        --port "$POSTGRES_PORT" \
        --user "$SQL_USER" \
        --password "$POSTGRES_BACKUP_PW" \
        --dbname "$db" \
        --backuppath "${POSTGRES_DBS[$db]}"
    then
        echo "PostgreSQL backup completed: $db"
    else
        echo "PostgreSQL backup failed: $db"
        failed=1
    fi
done

exit "$FAILED"
