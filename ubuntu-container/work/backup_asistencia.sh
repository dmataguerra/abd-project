#!/bin/bash

FECHA=$(date +'%Y%m%d_%H%M')
DB_NAME="asistencia_db"
DB_USER="postgres"
DB_HOST="127.0.0.1"
BACKUP_DIR="/var/backups/postgres"
LOG_FILE="/var/log/pg_backups.log"

mkdir -p "$BACKUP_DIR"

FILE_NAME="${DB_NAME}_${FECHA}.backup"
FULL_PATH="${BACKUP_DIR}/${FILE_NAME}"

echo "[$(date +'%Y-%m-%d %H:%M:%S')] Iniciando backup de ${DB_NAME}" >> "$LOG_FILE"

pg_dump -h "$DB_HOST" -U "$DB_USER" -F c -f "$FULL_PATH" "$DB_NAME"

if [ $? -eq 0 ]; then
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] Backup completado: $FULL_PATH" >> "$LOG_FILE"
else
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] ERROR en el backup de ${DB_NAME}" >> "$LOG_FILE"
fi

find "$BACKUP_DIR" -type f -name "${DB_NAME}_*.backup" -mtime +7 -delete
