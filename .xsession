#! /bin/sh
# Then *xdm* runs the Xsession script as the user.  This system
# session file may do some additional startup and typically runs the
# .xsession script in the user's home directory.  When the Xsession
# script exits, the session is over.
. $HOME/.profile
xrdb -load $HOME/.Xdefaults

setup_kbd.sh 
sleep 1

vid-setup.sh
sleep 1

WALLP=$HOME/movies/Wallpapers-room_com___Radia8_by_yt458_1440x900.xpm

PATH=$HOME/bin:$PATH

IBM_FIFO=$HOME/.acpi-ibm-display
XSTATUS_FIFO_0=$HOME/.xmonad-status.0
XSTATUS_FIFO_1=$HOME/.xmonad-status.1
FIFO_PERM=0600
FIFO_LST="${IBM_FIFO} ${XSTATUS_FIFO_0} ${XSTATUS_FIFO_1}"
FIFO_LST="${IBM_FIFO} ${XSTATUS_FIFO_0}"
#FG='#a8a3f7' 
#BG='#3f3c6d' 
FG='grey90'
BG='#233b5a' 
FONT="-xos4-terminus-medium-r-normal--16-160-72-72-c-80-iso8859-1"

for fifo in ${FIFO_LST}; do
    rm -f $fifo 2>/dev/null
    mkfifo -m ${FIFO_PERM} $fifo
    [ -p $fifo ] || exit
done

[ -e $WALLP ] && /usr/local/bin/xpmroot -r $WALLP
xscreensaver-command -exit
xscreensaver &

# launch the external 60 second clock, and launch the workspace status bar
status.sh > $XSTATUS_FIFO_0 &
dzen2 -e '' -x 760 -w 1140 -ta r -fg $FG -bg $BG -fn $FONT < $XSTATUS_FIFO_0 &

# and a workspace status bar
dzen2 -e '' -w 300 -ta l -fg $FG -bg $BG -fn $FONT < $XSTATUS_FIFO_1 &
sleep 1

urxvtd -q -f -o
urxvtc &
tpb &

sleep 1


xmonad
#awesome

wait $!

pkill -HUP dzen2
pkill -HUP -f status.sh

#wait
#exec wmaker
#xterm &
#exec twm
#exec wmii

