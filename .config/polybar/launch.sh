#!/usr/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

polybar swift3bar 2>&1 | tee -a /tmp/polybar-swift3bar.log & disown
echo "Bars launched..."
