#!/usr/bin/env bash
set -euo pipefail

MENU_TXT="/opt/brickdos/menu/E_Taktik.txt"

# --- Kategorie-Skripte (hier hardcodiert verdrahten) ---
KEY1="/opt/brickdos/dos/start-pi-x/Scorched Earth.sh"
KEY2="/opt/brickdos/dos/start-pi-x/Worms United.sh"
KEY3="/opt/brickdos/dos/start-pi-x/Z.sh"
KEY4="/opt/brickdos/dos/start-pi-x/Gorillas.sh"
KEY0="/opt/brickdos/menu/0_Main.sh"

read_key() {
  local k
  IFS= read -rsn1 k || true
  if [[ "$k" == $'\x1b' ]]; then
    echo "ESC"
  else
    echo "$k"
  fi
}

pause_any() { read -rsn1 >/dev/null 2>&1 || true; }

run_script() {
  local s="$1"
  if [[ -x "$s" ]]; then
    "$s" || true
  else
    echo
    echo "Script fehlt oder nicht ausführbar:"
    echo "  $s"
    echo
    echo "Taste drücken..."
    pause_any
  fi
}

while true; do
  clear || true
  cat "$MENU_TXT"

  # Kein Enter. Direkt Taste.
  k="$(read_key)"
  k="${k,,}"  # lowercase

  case "$k" in
    1) run_script "$KEY1" ;;
    2) run_script "$KEY2" ;;
    3) run_script "$KEY3" ;;
    4) run_script "$KEY4" ;;
    0) run_script "$KEY0" ;;
    esc) : ;; # im Hauptmenü: ESC macht nix
    *) : ;;   # alles andere ignorieren
  esac
done