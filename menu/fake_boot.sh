#!/usr/bin/env bash
set -euo pipefail

MENU="/opt/brickdos/menu/0_Main.sh"

CLS() { clear 2>/dev/null || printf "\033c"; }

ram_count() { # total_kb step_kb delay
  local total="${1:-65536}" step="${2:-256}" d="${3:-0.02}"
  local n=0
  while (( n < total )); do
    n=$((n + step))
    (( n > total )) && n="$total"
    printf "\rMemory Testing : %6dK OK" "$n"
    sleep "$d"
  done
  printf "\n"
}

# Single-line loader: overwrites same line while dots grow and tasks change
loader() {
  local -a tasks=(
    "Loading BrickDOS kernel extensions"
    "Mounting C: drive"
    "Calibrating phosphor glow"
    "Warming up CRT coils"
    "Reticulating splines"
    "Syncing DOS vibes"
    "Buffering chiptunes"
    "Enabling turbo button"
  )

  local i t dots dcount maxdots
  maxdots=12

  for i in "${!tasks[@]}"; do
    t="${tasks[$i]}"
    # each task: animate dots for a short moment
    for dcount in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
      dots="$(printf "%*s" "$dcount" "" | tr ' ' '.')"
      # pad dots to constant width so line length stays stable
      dots="$(printf "%-12s" "$dots")"
      printf "\r%-52s %s" "$t" "$dots"
      sleep 0.1
    done
    # little "commit" pause between tasks
    sleep 0.30
  done

  printf "\r%-52s %s\n" "System ready, entering main menu" "............"
  sleep 2.50
}

CLS

# --- BIOS header (kurz, zackig) ---
printf "Award Modular BIOS v4.51PG, An Energy Star Ally\n"
sleep 0.20
printf "Copyright (C) 1984-1999, Award Software, Inc.\n"
sleep 0.25
printf "\n"
sleep 0.15

# --- POST CPU (kurze Pausen) ---
printf "Pentium(R) MMX CPU at 200MHz\n"
sleep 0.22
printf "CPU Clock: 200MHz    Cache: 256KB\n"
sleep 0.28
printf "\n"
sleep 0.15

# --- RAM test ---
ram_count 65536 256 0.02
sleep 0.35
printf "\n"
sleep 0.80

# --- IDE Detect ---
printf "Detecting IDE Primary Master  ...  SanDisk SD128GB\n"
sleep 0.40
printf "Detecting IDE Primary Slave   ...  None\n"
sleep 0.18
printf "Detecting IDE Secondary Master...  None\n"
sleep 0.18
printf "Detecting IDE Secondary Slave ...  None\n"
sleep 0.22
printf "\n"
sleep 0.12

# --- PnP / Input ---
printf "Initializing Plug and Play Cards... OK\n"
sleep 0.32
printf "Mouse Initialized\n"
sleep 0.16
printf "Keyboard... OK\n"
sleep 0.20
printf "\n"
sleep 0.12

# --- Sound ---
printf "Sound Blaster 16 detected at A220 I5 D1 H5\n"
sleep 0.34
printf "AdLib FM Synth: OPL3 present\n"
sleep 0.30
printf "\n"
sleep 0.15

# --- DOS start ---
printf "Starting MS-DOS...\n"
sleep 1.8
printf "\n"
sleep 0.15

# --- CONFIG/AUTOEXEC vibe ---
printf "HIMEM is testing extended memory...done.\n"
sleep 0.28
printf "DOS=HIGH,UMB\n"
sleep 0.12
printf "DEVICE=C:\\DOS\\EMM386.EXE NOEMS\n"
sleep 0.18
printf "SET BLASTER=A220 I5 D1 H5 T6\n"
sleep 0.14
printf "SET SOUND=C:\\SB16\n"
sleep 0.14
printf "LH C:\\DOS\\SMARTDRV.EXE\n"
sleep 0.22
printf "\n"
sleep 0.18

# --- One-line loader instead of "Press any key" ---
loader

exec "$MENU"
