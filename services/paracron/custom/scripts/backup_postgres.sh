#!/usr/bin/env bash
set -euo pipefail
source backup_lib.sh

parse_sql_args "$@"
TARGET_PREFIX=$(prepare_backup_dir)

export PGPASSWORD="${POSTGRES_BACKUP_PW}"
pg_dump \
    --host="$SQL_HOST" \
    --port="$SQL_PORT" \
    --username="$SQL_USER" \
    "$SQL_DBNAME" | gzip > "${TARGET_PREFIX}.sql.gz"
unset PGPASSWORD
# Handled here so we dont delete old backups if new fail to create
prune_old_backups
