#!/bin/bash

# ============================================
# backup.sh
# Creates a compressed tar backup of a target
# directory with timestamp
# Author: Fabrizio Fiorilli
# ============================================

create_backup() {
    local source="$1"
    local dest="$2"

    if [[ -z "$source" ]] || [[ -z "$dest" ]]; then
        echo "[ERROR] Usage: ./backup.sh <source_dir> <dest_dir>"
        exit 1
    fi

    if [[ ! -d "$source" ]]; then
        echo "[ERROR] Source directory '$source' does not exist."
        exit 1
    fi

    if [[ ! -d "$dest" ]]; then
        echo "[INFO] Destination '$dest' not found. Creating it..."
        mkdir -p "$dest"
    fi

    local timestamp
    timestamp=$(date +"%Y%m%d_%H%M%S")

    local source_name
    source_name=$(basename "$source")

    local archive_name="${source_name}_backup_${timestamp}.tar.gz"
    local archive_path="${dest}/${archive_name}"

    echo "===================================="
    echo " Backup started"
    echo "===================================="
    echo "[SOURCE]  $source"
    echo "[DEST]    $archive_path"
    echo "[TIME]    $timestamp"
    echo "===================================="

    if tar -czf "$archive_path" -C "$(dirname "$source")" "$source_name" 2>/dev/null; then
        local size
        size=$(du -sh "$archive_path" | cut -f1)
        echo "[OK]  Backup completed successfully."
        echo "[SIZE]    $size"
    else
        echo "[ERROR] Backup failed."
        exit 1
    fi

    echo "===================================="
}

create_backup "$1" "$2"
