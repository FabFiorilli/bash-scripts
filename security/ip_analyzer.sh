#!/bin/bash
# Analizza le occorrenze di un IP in un file di log
# Uso: bash ip_analyzer.sh <file_log> <indirizzo_ip>

LOG="$1"
IP="$2"

if [ -z "$LOG" ] || [ -z "$IP" ]; then
    echo "Uso: $0 <file_log> <indirizzo_ip>"
    exit 1
fi

CONTA=$(grep -oE "$IP" "$LOG" | wc -l)
echo "$IP appare $CONTA volte in $LOG"

if [ $CONTA -gt 2 ]; then
    echo "[ALLERTA] $IP comportamento sospetto"
else
    echo "[OK] $IP nessuna anomalia"
fi
