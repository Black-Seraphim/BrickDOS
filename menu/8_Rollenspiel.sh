#!/usr/bin/env bash
set -euo pipefail

MENU_TXT="/opt/brickdos/menu/8_Rollenspiel.txt"

# --- Kategorie-Skripte (hier hardcodiert verdrahten) ---
KEY1="/opt/brickdos/dos/start-pi-x/Abandoned Places.sh"
KEY2="/opt/brickdos/dos/start-pi-x/Dungeon Master 1.sh"
KEY3="/opt/brickdos/dos/start-pi-x/Dungeon Master 2.sh"
KEY4="/opt/brickdos/dos/start-pi-x/Fallout.sh"
KEY5="/opt/brickdos/dos/start-pi-x/Das Schwarze Auge 1 - Die Schicksalsklinge.sh"
KEY6="/opt/brickdos/dos/start-pi-x/Das Schwarze Auge 2 - Sternenschweif.sh"
KEY7="/opt/brickdos/dos/start-pi-x/Das Schwarze Auge 3 - Schatten über Riva.sh"
KEY8="/opt/brickdos/dos/start-pi-x/Ravenloft - Stone Prophet.sh"
KEY9="/opt/brickdos/dos/start-pi-x/The Elder Scrolls II - Daggerfall.sh"
KEYA="/opt/brickdos/menu/8_5_Ultima.sh"
KEYB="/opt/brickdos/dos/start-pi-x/Ultima Underworld 1.sh"
KEYC="/opt/brickdos/dos/start-pi-x/Ultima Underworld 2.sh"
KEYD="/opt/brickdos/dos/start-pi-x/Might & Magic 1.sh"
KEYE="/opt/brickdos/dos/start-pi-x/Might & Magic 2.sh"
KEYF="/opt/brickdos/dos/start-pi-x/Might & Magic 3.sh"
KEYG="/opt/brickdos/dos/start-pi-x/Might & Magic 4.sh"
KEYH="/opt/brickdos/dos/start-pi-x/Might & Magic 5.sh"
KEYI="/opt/brickdos/dos/start-pi-x/Ravenloft - Strahd's Possession.sh"
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