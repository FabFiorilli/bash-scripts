#!/bin/bash

# ============================================
# net_check.sh
# Checks internet connectivity and DNS resolution
# Author: Fabrizio Fiorilli
# ============================================

HOSTS=("8.8.8.8" "1.1.1.1" "9.9.9.9")
DOMAINS=("google.com" "github.com" "cloudflare.com")
SUCCESS=0
FAIL=0

print_header() {
    echo "===================================="
    echo "     NETWORK CONNECTIVITY CHECK"
    echo "===================================="
}

check_ping() {
    echo ""
    echo "[+] Checking IP reachability..."
    echo "------------------------------------"

    for host in "${HOSTS[@]}"; do
        if ping -c 1 -W 2 "$host" &>/dev/null; then
            echo "[OK]   $host is reachable"
            (( SUCCESS++ ))
        else
            echo "[FAIL] $host is unreachable"
            (( FAIL++ ))
        fi
    done
}

check_dns() {
    echo ""
    echo "[+] Checking DNS resolution..."
    echo "------------------------------------"

    for domain in "${DOMAINS[@]}"; do
        if host "$domain" &>/dev/null; then
            echo "[OK]   $domain resolved successfully"
            (( SUCCESS++ ))
        else
            echo "[FAIL] $domain could not be resolved"
            (( FAIL++ ))
        fi
    done
}

print_summary() {
    echo ""
    echo "===================================="
    echo " Summary"
    echo "===================================="
    echo "[PASS] $SUCCESS checks passed"
    echo "[FAIL] $FAIL checks failed"

    if [[ "$FAIL" -eq 0 ]]; then
        echo "[STATUS] Full connectivity confirmed."
    elif [[ "$SUCCESS" -eq 0 ]]; then
        echo "[STATUS] No connectivity detected."
    else
        echo "[STATUS] Partial connectivity detected."
    fi

    echo "===================================="
}

print_header
check_ping
check_dns
print_summary
