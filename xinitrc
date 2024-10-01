#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Run some xinit scripts, there be stuff in here

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# twm &
# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
# exec xterm -geometry 80x66+0+0 -name login

# Set sensitivity on trackpoint -.5 - 1+?, default 0
# xinput --set-prop "16" "libinput Accel Speed" .5

# Scale display, at least for programs that behave
xrandr --dpi 120&

# Disabling screen blanking and power saving
xset s 0 0
xset s off
xset dpms 0 0 0
xset -dpms

# start some nice programs
xmodmap ~/.Xmodmap&
xbindkeys&
volumeicon&
qpwgraph -m&
# batterymon&
redshift-gtk&
#caffeine&
megasync&
# xss-lock -- i3lock -n -c 000000&
XSECURELOCK_PASSWORD_PROMPT=time_hex xss-lock -- xsecurelock&
# nm-applet
exec awesome
