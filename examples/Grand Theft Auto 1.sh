#!/usr/bin/env bash
set -e
cd -- "$(dirname -- "$(readlink -f -- "$0")")"

# Launcher generated from: start-win/Grand Theft Auto 1.cmd

dosbox-x -noconsole -conf ../conf/brickdos-base-pi-x.conf -conf ../conf/gta.conf -c exit

