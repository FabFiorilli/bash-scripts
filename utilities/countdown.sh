#!/bin/bash

# ============================================
# countdown.sh
# Countdown timer from a given number of seconds
# Author: Fabrizio Fiorilli
# ============================================

countdown() {
    local seconds="$1"

    if [[ -z "$seconds" ]]; then
        echo "[ERROR] No time specified. Usage: ./countdown.sh <seconds>"
        exit 1
    fi

    if ! [[ "$seconds" =~ ^[0-9]+$ ]] || [[ "$seconds" -eq 0 ]]; then
        echo "[ERROR] Please enter a positive integer."
        exit 1
    fi

    echo "===================================="
    echo " Countdown started: ${seconds}s"
    echo "===================================="

    while [[ "$seconds" -gt 0 ]]; do
        printf "\r[TIMER] %3d seconds remaining..." "$seconds"
        sleep 1
        (( seconds-- ))
    done

    printf "\r[DONE]  Time is up!                \n"
    echo "===================================="
}

countdown "$1"
