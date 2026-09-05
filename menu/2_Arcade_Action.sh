#!/usr/bin/env bash
set -euo pipefail

MENU_TXT="/opt/brickdos/menu/2_Arcade_Action.txt"

# --- Kategorie-Skripte (hier hardcodiert verdrahten) ---
KEY1="/opt/brickdos/dos/start-pi-x/Budokan.sh"
KEY2="/opt/brickdos/dos/start-pi-x/Demon Stalkers.sh"
KEY3="/opt/brickdos/dos/start-pi-x/Grand Theft Auto 1.sh"
KEY4="/opt/brickdos/dos/start-pi-x/Grand Theft Auto 1 - London 1961.sh"
KEY5="/opt/brickdos/dos/start-pi-x/Grand Theft Auto 1 - London 1969.sh"
KEY6="/opt/brickdos/dos/start-pi-x/Wing Commander 1 with Secrect Missions.sh"
KEY7="/opt/brickdos/dos/start-pi-x/Wing Commander 1 - The Secrect Missions 2 - Crusade.sh"
KEY8="/opt/brickdos/dos/start-pi-x/Wing Commander 2 - Vengeance of the Kilrathi.sh"
KEY9="/opt/brickdos/dos/start-pi-x/Wing Commander 2 - Special Operation 1.sh"
KEYA="/opt/brickdos/dos/start-pi-x/Wing Commander 2 - Special Operation 2.sh"
KEYB="/opt/brickdos/dos/start-pi-x/Pirates! Gold.sh"
KEYC="/opt/brickdos/dos/start-pi-x/Shooting Gallery.sh"
KEYD="/opt/brickdos/dos/start-pi-x/Silverball.sh"
KEYE="/opt/brickdos/dos/start-pi-x/Star Goose.sh"
KEYF="/opt/brickdos/dos/start-pi-x/Window Wizard.sh"
KEYG="/opt/brickdos/dos/start-pi-x/Alley Cat.sh"
KEYH="/opt/brickdos/dos/start-pi-x/Arkanoid 1.sh"
KEYI="/opt/brickdos/dos/start-pi-x/Arkanoid 2.sh"
KEYJ="/opt/brickdos/dos/start-pi-x/Blasteroids.sh"
KEYK="/opt/brickdos/dos/start-pi-x/Nibbles.sh"
KEYL="/opt/brickdos/dos/start-pi-x/Gorillas.sh"
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
    j) run_script "$KEYJ" ;;
    k) run_script "$KEYK" ;;
    l) run_script "$KEYL" ;;
    0) run_script "$KEY0" ;;
    esc) : ;; # im Hauptmenü: ESC macht nix
    *) : ;;   # alles andere ignorieren
  esac
done