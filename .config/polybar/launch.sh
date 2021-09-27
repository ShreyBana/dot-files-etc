#!/usr/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

polybar fullbar 2>&1 | tee -a /tmp/polybar-fullbar.log & disown
echo "bar launched..."
