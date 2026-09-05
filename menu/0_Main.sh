#!/usr/bin/env bash
set -euo pipefail

MENU_TXT="/opt/brickdos/menu/0_Main.txt"

# --- Kategorie-Skripte (hier hardcodiert verdrahten) ---
KEY1="/opt/brickdos/menu/1_Adventure.sh"
KEY2="/opt/brickdos/menu/2_Arcade_Action.sh"
KEY3="/opt/brickdos/menu/3_Autorennen.sh"
KEY4="/opt/brickdos/menu/4_Ego-Shooter.sh"
KEY5="/opt/brickdos/menu/5_Jump_n_Run.sh"
KEY6="/opt/brickdos/menu/6_Party.sh"
KEY7="/opt/brickdos/menu/7_Puzzle.sh"
KEY8="/opt/brickdos/menu/8_Rollenspiel.sh"
KEY9="/opt/brickdos/menu/9_Simulation.sh"
KEYA="/opt/brickdos/menu/A_Strategie_Aufbau.sh"
KEYB="/opt/brickdos/menu/B_Strategie_Echtzeit.sh"
KEYC="/opt/brickdos/menu/C_Strategie_Rundenbasiert.sh"
KEYD="/opt/brickdos/menu/D_Strategie_Wirtschaft.sh"
KEYE="/opt/brickdos/menu/E_Taktik.sh"

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

shutdown_pi() {
  clear || true
  echo
  echo "Wirklich herunterfahren?"
  echo "  y = Ja"
  echo "  n/ESC/andere Taste = Abbruch"
  local k; k="$(read_key)"
  if [[ "${k,,}" == "y" ]]; then
    sudo shutdown -h now
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
    0) shutdown_pi ;;
    esc) : ;; # im Hauptmenü: ESC macht nix
    *) : ;;   # alles andere ignorieren
  esac
done