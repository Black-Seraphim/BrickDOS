#!/usr/bin/env bash
set -euo pipefail

MENU_TXT="/opt/brickdos/menu/7_Puzzle.txt"

# --- Kategorie-Skripte (hier hardcodiert verdrahten) ---
KEY1="/opt/brickdos/dos/start-pi-x/Lemmings 1.sh"
KEY2="/opt/brickdos/dos/start-pi-x/Lemmings 1 - Holiday Lemmings.sh"
KEY3="/opt/brickdos/dos/start-pi-x/Lemmings 1 - Oh No! More Lemmings.sh"
KEY4="/opt/brickdos/dos/start-pi-x/Lemmings 1 - XMAS Lemmings.sh"
KEY5="/opt/brickdos/dos/start-pi-x/Lemmings 2 - The Tribes.sh"
KEY6="/opt/brickdos/dos/start-pi-x/Lemmings 3 - All New World of Lemmings.sh"
KEY7="/opt/brickdos/dos/start-pi-x/The Incredible Machine.sh"
KEY8="/opt/brickdos/dos/start-pi-x/Boulder Dash 2.sh"
KEY9="/opt/brickdos/dos/start-pi-x/Mah Jongg.sh"
KEYA="/opt/brickdos/dos/start-pi-x/The Game of Robot Junior.sh"
KEYB="/opt/brickdos/dos/start-pi-x/The Game of Robot 1.sh"
KEYC="/opt/brickdos/dos/start-pi-x/The Game of Robot 2.sh"
KEYD="/opt/brickdos/dos/start-pi-x/The Game of Robot 3.sh"
KEYE="/opt/brickdos/dos/start-pi-x/The Game of Robot 4.sh"
KEYF="/opt/brickdos/dos/start-pi-x/Arkanoid 1.sh"
KEYG="/opt/brickdos/dos/start-pi-x/Arkanoid 2.sh"
KEYH="/opt/brickdos/dos/start-pi-x/Brix.sh"
KEYI="/opt/brickdos/dos/start-pi-x/Sokoban.sh"
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
    5) run_script "$KEY5" ;;
    6) run_script "$KEY6" ;;
    7) run_script "$KEY7" ;;
    8) run_script "$KEY8" ;;
    9) run_script "$KEY9" ;;
    a) run_script "$KEYA" ;;
    b) run_script "$KEYB" ;;
    c) run_script "$KEYC" ;;
    d) run_script "$KEYD" ;;
    e) run_script "$KEYE" ;;
    f) run_script "$KEYF" ;;
    g) run_script "$KEYG" ;;
    h) run_script "$KEYH" ;;
    i) run_script "$KEYI" ;;
    0) run_script "$KEY0" ;;
    esc) : ;; # im Hauptmenü: ESC macht nix
    *) : ;;   # alles andere ignorieren
  esac
done