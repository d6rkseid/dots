#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

    xrdb -merge $sysresources

fi

#if [ -f $sysmodmap ]; then
#    xmodmap $sysmodmap
#fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


if [ -f $HOME/.Xmodmap ]; then
            /usr/bin/xmodmap $HOME/.Xmodmap
   
fi

# screen powersave
   xset +dpms
   xset dpms 0 0 300
 
#  exec i3 
#  exec budgie-desktop
#  exec gnome-session
#  exec startkde #plasma
   exec startxfce4 #xfce
#  exec startdde #deepin
#  exec env GNOME_SHELL_SESSION_MODE=classic gnome-session --session gnome-classicc
#  exec kodi-standalone
