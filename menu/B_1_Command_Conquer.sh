#!/usr/bin/env bash
set -euo pipefail

MENU_TXT="/opt/brickdos/menu/B_1_Command_Conquer.txt"

# --- Kategorie-Skripte (hier hardcodiert verdrahten) ---
KEY1="/opt/brickdos/dos/start-pi-x/Command & Conquer - Der Tiberiumkonflikt - GDI.sh"
KEY2="/opt/brickdos/dos/start-pi-x/Command & Conquer - Der Tiberiumkonflikt - Der Ausnahmezustand.sh"
KEY3="/opt/brickdos/dos/start-pi-x/Command & Conquer - Alarmstufe Rot - Allianz.sh"
KEY4="/opt/brickdos/dos/start-pi-x/Command & Conquer - Alarmstufe Rot - Gegenangriff.sh"
KEY5="/opt/brickdos/dos/start-pi-x/Command & Conquer - Der Tiberiumkonflikt - NOD.sh"
KEY6="/opt/brickdos/dos/start-pi-x/Command & Conquer - Alarmstufe Rot - Sowjets.sh"
KEY7="/opt/brickdos/dos/start-pi-x/Command & Conquer - Alarmstufe Rot - Vergeltungsschlag.sh"
KEY0="/opt/brickdos/menu/B_Strategie_Echtzeit.sh"

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
    0) run_script "$KEY0" ;;
    esc) : ;; # im Hauptmenü: ESC macht nix
    *) : ;;   # alles andere ignorieren
  esac
done