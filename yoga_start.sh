#!/bin/bash

# touchpad
synclient TapButton1=1
synclient TapButton2=3
synclient TapButton3=1

# invert scroll
synclient VertScrollDelta=-111
synclient HorizScrollDelta=-111

synclient HorizTwoFingerScroll=1

# change language
setxkbmap -option 'grp:alt_shift_toggle'
setxkbmap -layout us,ru
