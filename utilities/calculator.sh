#!/bin/bash

# ============================================
# calculator.sh
# Native bash calculator (no bc required)
# Supports: + - * /
# Author: Fabrizio Fiorilli
# ============================================

show_menu() {
    echo "===================================="
    echo "        BASH CALCULATOR"
    echo "===================================="
    echo "[1] Addition"
    echo "[2] Subtraction"
    echo "[3] Multiplication"
    echo "[4] Division"
    echo "[5] Exit"
    echo "===================================="
}

get_numbers() {
    read -rp "Enter first number:  " num1
    read -rp "Enter second number: " num2

    if ! [[ "$num1" =~ ^-?[0-9]+$ ]] || ! [[ "$num2" =~ ^-?[0-9]+$ ]]; then
        echo "[ERROR] Please enter valid integers."
        exit 1
    fi
}

calculate() {
    local choice="$1"

    case "$choice" in
        1)
            echo "[RESULT] $num1 + $num2 = $(( num1 + num2 ))"
            ;;
        2)
            echo "[RESULT] $num1 - $num2 = $(( num1 - num2 ))"
            ;;
        3)
            echo "[RESULT] $num1 * $num2 = $(( num1 * num2 ))"
            ;;
        4)
            if [[ "$num2" -eq 0 ]]; then
                echo "[ERROR] Division by zero is not allowed."
                exit 1
            fi
            echo "[RESULT] $num1 / $num2 = $(( num1 / num2 ))"
            ;;
        5)
            echo "Goodbye."
            exit 0
            ;;
        *)
            echo "[ERROR] Invalid option."
            exit 1
            ;;
    esac
}

show_menu
read -rp "Choose an option: " option
get_numbers
calculate "$option"
