#!/bin/bash

# ============================================
# process_monitor.sh
# Interactive process monitor with menu
# Author: Fabrizio Fiorilli
# ============================================

print_header() {
    clear
    echo "===================================="
    echo "       PROCESS MONITOR"
    echo "===================================="
}

show_menu() {
    echo ""
    echo "[1] List all running processes"
    echo "[2] Search process by name"
    echo "[3] Show top 5 CPU consuming processes"
    echo "[4] Show top 5 RAM consuming processes"
    echo "[5] Kill a process by PID"
    echo "[6] Exit"
    echo "===================================="
    read -rp "Choose an option: " choice
}

list_processes() {
    echo ""
    echo "[+] Running processes:"
    echo "------------------------------------"
    ps aux --no-headers | awk '{printf "PID: %-8s USER: %-10s CMD: %s\n", $2, $1, $11}'
}

search_process() {
    read -rp "Enter process name: " pname
    echo ""
    echo "[+] Results for '$pname':"
    echo "------------------------------------"

    local results
    results=$(ps aux --no-headers | grep -i "$pname" | grep -v grep)

    if [[ -z "$results" ]]; then
        echo "[INFO] No process found with name '$pname'."
    else
        echo "$results" | awk '{printf "PID: %-8s USER: %-10s CMD: %s\n", $2, $1, $11}'
    fi
}

top_cpu() {
    echo ""
    echo "[+] Top 5 CPU consuming processes:"
    echo "------------------------------------"
    ps aux --no-headers --sort=-%cpu | head -5 | \
        awk '{printf "PID: %-8s CPU: %-6s CMD: %s\n", $2, $3, $11}'
}

top_ram() {
    echo ""
    echo "[+] Top 5 RAM consuming processes:"
    echo "------------------------------------"
    ps aux --no-headers --sort=-%mem | head -5 | \
        awk '{printf "PID: %-8s RAM: %-6s CMD: %s\n", $2, $4, $11}'
}

kill_process() {
    read -rp "Enter PID to kill: " pid

    if ! [[ "$pid" =~ ^[0-9]+$ ]]; then
        echo "[ERROR] Invalid PID."
        return
    fi

    if kill -0 "$pid" &>/dev/null; then
        kill "$pid"
        echo "[OK] Process $pid terminated."
    else
        echo "[ERROR] Process $pid not found or permission denied."
    fi
}

run_monitor() {
    while true; do
        print_header
        show_menu

        case "$choice" in
            1) list_processes ;;
            2) search_process ;;
            3) top_cpu ;;
            4) top_ram ;;
            5) kill_process ;;
            6) echo "Goodbye."; exit 0 ;;
            *) echo "[ERROR] Invalid option." ;;
        esac

        echo ""
        read -rp "Press ENTER to continue..." _
    done
}

run_monitor
