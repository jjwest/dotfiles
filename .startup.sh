#!/bin/bash

setxkbmap -option caps:escape
xset mouse 0 0
xrandr --output HDMI-1 --off
xrandr --output DVI-I-1 --mode 1920x1080 --rate 144
xset r rate 200 60
xflux -l 58.4108
