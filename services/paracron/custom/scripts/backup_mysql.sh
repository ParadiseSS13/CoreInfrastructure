#!/usr/bin/env bash

################################################################
##
##   MySQL Database Backup Script
##   Written By: Rahul Kumar
##   URL: https://tecadmin.net/bash-script-mysql-database-backup/
##   Last Update: Jan 05, 2019
##
################################################################

export PATH=/bin:/usr/bin:/usr/local/bin
TODAY=`date +"%d%b%Y"`

################################################################
################## Update below values  ########################

DB_BACKUP_PATH=''
MYSQL_HOST=''
MYSQL_PORT='3306'
MYSQL_USER=''
MYSQL_PASSWORD=''
DATABASE_NAME=''

## AA07 EDIT - Makes these work as script args instead of hardcoded vars
while [[ $# -gt 0 ]]; do
  case "$1" in
    --host|-h)
      MYSQL_HOST="$2"
      shift 2
      ;;
    --port)
      MYSQL_PORT="$2"
      shift 2
      ;;
    --user|-u)
      MYSQL_USER="$2"
      shift 2
      ;;
    --password|-p)
      MYSQL_PASSWORD="$2"
      shift 2
      ;;
    --dbname|-d)
      DATABASE_NAME="$2"
      shift 2
      ;;
    --backuppath|-b)
      DB_BACKUP_PATH="$2"
      shift 2
      ;;
    --help)
      echo "Usage: $0 --host <host> --port <port> --user <user> --password <pass> --dbname <name> --backuppath <dir> "
      exit 0
      ;;
    *)
      echo "Error: Unknown argument: $1" >&2
      exit 1
      ;;
  esac
done

#################################################################

mkdir -p ${DB_BACKUP_PATH}/${TODAY}
echo "Backup started for database - ${DATABASE_NAME}"


mysqldump --quick --single-transaction -h ${MYSQL_HOST} \
   -P ${MYSQL_PORT} \
   -u ${MYSQL_USER} \
   -p${MYSQL_PASSWORD} \
   ${DATABASE_NAME} | gzip > ${DB_BACKUP_PATH}/${TODAY}/${DATABASE_NAME}-${TODAY}.sql.gz

if [ $? -eq 0 ]; then
  echo "Database backup successfully completed"
else
  echo "Error found during backup"
  exit 1
fi


##### Remove backups older than 7 days  #####
DBDELDATE=$(date -d "@$(( $(date +%s) - 604800 ))" +"%d%b%Y")

if [ ! -z ${DB_BACKUP_PATH} ]; then
      cd ${DB_BACKUP_PATH}
      if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
            rm -rf ${DBDELDATE}
      fi
fi

### End of script ####
