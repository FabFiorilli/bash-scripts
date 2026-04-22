#!/bin/bash

# ============================================
# file_checker.sh
# Checks if a file exists, its type and size
# Author: Fabrizio Fiorilli
# ============================================

check_file() {
    local target="$1"

    if [[ -z "$target" ]]; then
        echo "[ERROR] No file specified."
        exit 1
    fi

    if [[ ! -e "$target" ]]; then
        echo "[INFO] '$target' does not exist."
        exit 0
    fi

    echo "===================================="
    echo " File Report: $target"
    echo "===================================="

    if [[ -f "$target" ]]; then
        echo "[TYPE]  Regular file"
    elif [[ -d "$target" ]]; then
        echo "[TYPE]  Directory"
    elif [[ -L "$target" ]]; then
        echo "[TYPE]  Symbolic link"
    else
        echo "[TYPE]  Unknown"
    fi

    local size
    size=$(du -sh "$target" 2>/dev/null | cut -f1)
    echo "[SIZE]  $size"

    local perms
    perms=$(stat -c "%A" "$target" 2>/dev/null)
    echo "[PERMS] $perms"

    echo "===================================="
}

check_file "$1"
