#
# ~/.bash_profile
#
[ -z "$DISPLAY" -a "$(fgconsole)" -eq 1 ] && exec startx
[[ -f ~/.bashrc ]] && . ~/.bashrc

sleep 4 && xmodmap ~/.Xmodmap &

