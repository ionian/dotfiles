#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

#conky | while read -r; do xsetroot -name "$REPLY"; done &

# exec gnome-session
# exec startkde
# exec startxfce4
#exec dwm
# ...or the Window Manager of your choice

# external monitor
# external=$(xrandr -q | awk '/HDMI1/ {print $2}')
# if [ "$external" = connected ]; then
#   xrandr --output eDP1 --mode 1600x900 --pos 0x0 --below HDMI1 \
    #     --output HDMI1 --mode 1680x1050 --pos 0x900
#     fi
#
# jasonwryan .xinitrc
#
     # load .Xresources
     xrdb -merge $HOME/.Xresources

     # enable restart X
     setxkbmap -option terminate:ctrl_alt_bksp

#     # disable CapsLock & map to Escape
     setxkbmap -option caps:swapescape

#     # compose key
#     setxkbmap -option compose:ralt

 # add font paths
xset fp default
 [[ -d /usr/share/fonts/local ]] && xset +fp /usr/share/fonts/local
 [[ -d /usr/share/fonts/OTF ]] && xset +fp /usr/share/fonts/OTF
 [[ -d $HOME/.local/share/fonts ]] && xset +fp $HOME/.local/share/fonts
 [[ -d $HOME/.local/share/fonts/misc ]] && xset +fp $HOME/.local/share/fonts/misc

xset fp rehash

#     # additional keybinds
     xbindkeys 

     # brightness
     xbacklight -set 45% &

#     # set wallpaper
     imlibsetroot -s $XDG_CONFIG_HOME/background.jpg &

     # set cursor
     xsetroot -cursor_name left_ptr &

#     # hide cursor
     unclutter -noevents -idle 3 &

     # start terminal emulation daemon
     urxvtd -q -o -f

     # clipboard synching
     autocutsel -fork &
     autocutsel -selection PRIMARY -fork &

     # auto{u}mount drives
     udiskie -qN &

     # ---- window manager ----
     # launch VBoxClient
     /usr/bin/VBoxClient-all &
     # launch dwm
     exec $HOME/scripts/dwm-start
#
#
# w0ng .xinitrc
#
# load .Xresources
# [[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

# # remap caps lock to control, remap right alt to window key
# setxkbmap -option ctrl:nocaps
# xmodmap -e "keycode 108 = Super_L"
# xmodmap -e "remove mod1 = Super_L"
#
# # add font paths
#xset fp default
# [[ -d /usr/share/fonts/local ]] && xset +fp /usr/share/fonts/local
# [[ -d /usr/share/fonts/OTF ]] && xset +fp /usr/share/fonts/OTF
# [[ -d $HOME/.local/share/fonts ]] && xset +fp $HOME/.local/share/fonts
#xset fp rehash

# # turn monitor off after 60min
# xset s off
# xset dpms 3600 3600 3600
#
# # increase mouse acceleration
# xset m 3
#
 # set WM to a name with Java recognises
# wmname LG3D
#
# # set background
# sh $HOME/.fehbg
#
# # start WM
# exec $HOME/Scripts/dwm-start
