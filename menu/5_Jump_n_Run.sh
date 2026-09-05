#!/usr/bin/env bash
set -euo pipefail

MENU_TXT="/opt/brickdos/menu/5_Jump_n_Run.txt"

# --- Kategorie-Skripte (hier hardcodiert verdrahten) ---
KEY1="/opt/brickdos/dos/start-pi-x/Aladdin.sh"
KEY2="/opt/brickdos/dos/start-pi-x/Commander Keen 1.sh"
KEY3="/opt/brickdos/dos/start-pi-x/Commander Keen 2.sh"
KEY4="/opt/brickdos/dos/start-pi-x/Commander Keen 3.sh"
KEY5="/opt/brickdos/dos/start-pi-x/Commander Keen 4.sh"
KEY6="/opt/brickdos/dos/start-pi-x/Commander Keen 5.sh"
KEY7="/opt/brickdos/dos/start-pi-x/Duke Nukem 1 - Episode 1.sh"
KEY8="/opt/brickdos/dos/start-pi-x/Duke Nukem 1 - Episode 2.sh"
KEY9="/opt/brickdos/dos/start-pi-x/Duke Nukem 1 - Episode 3.sh"
KEYA="/opt/brickdos/dos/start-pi-x/Duke Nukem 2.sh"
KEYB="/opt/brickdos/dos/start-pi-x/Prince of Persia 1.sh"
KEYC="/opt/brickdos/dos/start-pi-x/Prince of Persia 2.sh"
KEYD="/opt/brickdos/dos/start-pi-x/Lion King.sh"
KEYE="/opt/brickdos/dos/start-pi-x/Cool Spot.sh"
KEYF="/opt/brickdos/dos/start-pi-x/Giana Sisters.sh"
KEYG="/opt/brickdos/dos/start-pi-x/Mario.sh"
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
    0) run_script "$KEY0" ;;
    esc) : ;; # im Hauptmenü: ESC macht nix
    *) : ;;   # alles andere ignorieren
  esac
done