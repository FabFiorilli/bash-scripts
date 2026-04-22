#!/bin/bash

# ============================================
# month_converter.sh
# Converts a number (1-12) to a month name
# Author: Fabrizio Fiorilli
# ============================================

convert_month() {
    local num="$1"

    if [[ -z "$num" ]]; then
        echo "[ERROR] No number provided. Usage: ./month_converter.sh <1-12>"
        exit 1
    fi

    if ! [[ "$num" =~ ^[0-9]+$ ]]; then
        echo "[ERROR] Input must be a number."
        exit 1
    fi

    case "$num" in
        1)  echo "January" ;;
        2)  echo "February" ;;
        3)  echo "March" ;;
        4)  echo "April" ;;
        5)  echo "May" ;;
        6)  echo "June" ;;
        7)  echo "July" ;;
        8)  echo "August" ;;
        9)  echo "September" ;;
        10) echo "October" ;;
        11) echo "November" ;;
        12) echo "December" ;;
        *)  echo "[ERROR] Number out of range. Please enter a value between 1 and 12."
            exit 1 ;;
    esac
}

convert_month "$1"
