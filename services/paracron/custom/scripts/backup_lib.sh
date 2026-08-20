#!/bin/bash
# Shared 'library' for SQL backups.
export PATH=/bin:/usr/bin:/usr/local/bin

# Parse common arguments into global SQL_* variables
parse_sql_args() {
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --host|-h) SQL_HOST="$2"; shift 2 ;;
        --port) SQL_PORT="$2"; shift 2 ;;
        --user|-u) SQL_USER="$2"; shift 2 ;;
        --password|-p) SQL_PASSWORD="$2"; shift 2 ;;
        --dbname|-d) SQL_DBNAME="$2"; shift 2 ;;
        --backuppath|-b) SQL_BACKUP_PATH="$2"; shift 2 ;;
        --help)
          echo "Usage: <script> --host <host> --port <port> --user <user> --password <pass> --dbname <name> --backuppath <dir>"
          exit 0
          ;;
        *)
          echo "Error: Unknown argument: $1" >&2
          exit 1
          ;;
      esac
    done
}

# Prepare the backup directory and return the target file path prefix
prepare_backup_dir() {
    local today
    today=$(date +"%d%b%Y")
    mkdir -p "${SQL_BACKUP_PATH}/${today}"
    echo "${SQL_BACKUP_PATH}/${today}/${SQL_DBNAME}-${today}"
}

# Prune backups older than 7 days (604800 seconds)
prune_old_backups() {
    local del_date
    del_date=$(date -d "@$(( $(date +%s) - 604800 ))" +"%d%b%Y")

    if [ ! -z "${SQL_BACKUP_PATH}" ]; then
          if [ ! -z "${del_date}" ] && [ -d "${SQL_BACKUP_PATH}/${del_date}" ]; then
                echo "Pruning old backups from: ${SQL_BACKUP_PATH}/${del_date}"
                rm -rf "${SQL_BACKUP_PATH}/${del_date}"
          fi
    fi
}