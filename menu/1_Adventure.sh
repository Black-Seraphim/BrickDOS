#!/usr/bin/env bash
set -euo pipefail

MENU_TXT="/opt/brickdos/menu/1_Adventure.txt"

# --- Kategorie-Skripte (hier hardcodiert verdrahten) ---
KEY1="/opt/brickdos/scummvm/start-pi/Beneath a Steel Sky.sh"
KEY2="/opt/brickdos/scummvm/start-pi/Discworld 1.sh"
KEY3="/opt/brickdos/scummvm/start-pi/Discworld 2.sh"
KEY4="/opt/brickdos/dos/start-pi-x/Dune 1.sh"
KEY5="/opt/brickdos/menu/1_5_Gobliiins.sh"
KEY6="/opt/brickdos/menu/1_J_Space_Quest.sh"
KEY7="/opt/brickdos/scummvm/start-pi/Black Cauldron.sh"
KEY8="/opt/brickdos/menu/1_8_Kings_Quest.sh"
KEY9="/opt/brickdos/scummvm/start-pi/Indiana Jones and the Last Crusade.sh"
KEYA="/opt/brickdos/scummvm/start-pi/Myst.sh"
KEYB="/opt/brickdos/menu/1_F_Police_Quest.sh"
KEYC="/opt/brickdos/scummvm/start-pi/Sam and Max - Hit the Road.sh"
KEYD="/opt/brickdos/scummvm/start-pi/Simon the Sorcerer 1.sh"
KEYE="/opt/brickdos/scummvm/start-pi/Simon the Sorcerer 2.sh"
KEYF="/opt/brickdos/menu/1_M_The_Legend_Of_Kyrandia.sh"
KEYG="/opt/brickdos/scummvm/start-pi/Maniac Mansion.sh"
KEYH="/opt/brickdos/scummvm/start-pi/Day Of The Tentacle.sh"
KEYI="/opt/brickdos/scummvm/start-pi/Loom.sh"
KEYJ="/opt/brickdos/scummvm/start-pi/The Dig.sh"
KEYK="/opt/brickdos/scummvm/start-pi/Zak McKracken and the Alien Mindbenders.sh"
KEYL="/opt/brickdos/menu/1_D_Monkey_Island.sh"
KEYM="/opt/brickdos/menu/1_9_Leisure_Suit_Larry.sh"
KEYN="/opt/brickdos/dos/start-pi-x/Vision 1.sh"
KEYO="/opt/brickdos/dos/start-pi-x/Vision 2.sh"
KEYP="/opt/brickdos/scummvm/start-pi/Indiana Jones and the Fate of Atlantis.sh"
KEYQ="/opt/brickdos/dos/start-pi-x/Castle Adventure.sh"
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
    m) run_script "$KEYM" ;;
    n) run_script "$KEYN" ;;
    o) run_script "$KEYO" ;;
    p) run_script "$KEYP" ;;
    q) run_script "$KEYQ" ;;
    0) run_script "$KEY0" ;;
    esc) : ;; # im Hauptmenü: ESC macht nix
    *) : ;;   # alles andere ignorieren
  esac
done