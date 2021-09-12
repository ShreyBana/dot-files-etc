#!/usr/bin/bash
headphones=""
speaker="蓼"

choice=$(printf "%s\n%s" $headphones $speaker| rofi -dmenu -p "Switch Source")

case $choice in

  $headphones)
    pacmd set-sink-port 1 analog-output-headphones
  ;;

  $speaker)
    pacmd set-sink-port 1 analog-output-lineout
  ;;

  *)
    echo "default"
  ;;
esac

