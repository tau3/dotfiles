#!/bin/sh
# shell script to prepend i3status with more stuff

i3status | while :
do
    read line
    layouts=$(setxkbmap -query | awk '/layout/{print $2}')
    current=$(dbus-send --print-reply=literal --dest=ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.getCurrentLayout | awk '{ print $2 }')
    index=$(($current+1))
    lang=$(echo $layouts | cut -d, -f$index)
    echo "LANG: $lang | $line" || exit 1
done
