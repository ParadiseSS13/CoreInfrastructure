#!/bin/bash
set -euo pipefail
source backup_lib.sh

parse_sql_args "$@"
TARGET_PREFIX=$(prepare_backup_dir)

mysqldump --quick --single-transaction -h "${SQL_HOST}" \
   -P "${SQL_PORT}" \
   -u "${SQL_USER}" \
   -p"${SQL_PASSWORD}" \
   "${SQL_DBNAME}" | gzip > "${TARGET_PREFIX}.sql.gz"

# Handled here so we dont delete old backups if new fail to create
prune_old_backups