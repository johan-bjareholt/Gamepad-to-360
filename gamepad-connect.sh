#!/bin/bash

# Choose /dev/input device
echo "Which input device would you like to configure?"
echo "(eg. /dev/input/eventX)"
read -p "Choice: " INPUT

INPUT="/dev/input/event$INPUT"

# Controller selection
prompt="Please select a controller configuration: "
options=( $(find $PWD/controllers/*.cfg -maxdepth 1 -print0 | xargs -0) )

cd controllers
PS3="File num: "
select FILENAME in *;
do
    CONFIG_FILE="$PWD/$FILENAME"
    echo "You picked $FILENAME"
    break
done
cd ..

# Read config file
FIRSTLINE=true
while read -r LINE; do
    if [ $FIRSTLINE != "true" ] 
      then 
        FIRSTLINE="false"
    else
        KEY_SETUP+=","
    fi
    KEY_SETUP+="$LINE"
done < $CONFIG_FILE

function start() {
    RUN=false
    FLAGS="--silent"
    ABS_CONFIG="ABS_#0=x1,ABS_#1=y1,ABS_#2=x2,ABS_#5=y2,ABS_#16=dpad_x,ABS_#17=dpad_y"
    sudo xboxdrv $FLAGS --evdev $INPUT --mimic-xpad \
    --evdev-keymap $KEY_SETUP --evdev-absmap $ABS_CONFIG --axismap -Y1=Y1,-Y2=Y2 
}

function test () {
    sudo xboxdrv --evdev $INPUT --evdev-debug
}

function debug () {
    sudo evtest $INPUT
}

function menu () {
    echo ""
    echo "1: start"
    echo "2: test"
    echo "3: debug"
    echo "q: quit"

    read -n1 -p "Choice: " doit 
    echo ""
    case $doit in  
        1) start ;; 
        2) test ;;
        3) debug ;;
        q) RUN=false ;; 
        *) echo "invalid choice";; 
    esac
}

case $1 in
    start) start ;;
    test)  test  ;;
    debug) debug ;;
    *)     menu  ;;
esac
