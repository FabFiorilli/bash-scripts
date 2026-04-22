#!/bin/bash
# Mostra IP privato e pubblico della macchina

PRIVATO=$(hostname -I | awk '{print $1}')
PUBBLICO=$(curl -s ifconfig.me)

echo "Privato: $PRIVATO | Pubblico: $PUBBLICO"
