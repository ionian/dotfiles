#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function my_ip() # Get IP adress on ethernet.
{
        MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' |
              sed -e s/addr://)
                  echo ${MY_IP:-"Not connected"}
              }

# colour coreutils
eval $(dircolors -b ~/.dir_colors)
export GREP_COLOR="1;31"
alias grep="grep --color=auto"
alias ls="ls --color=auto"
             
#============================================================
#
#  ALIASES AND FUNCTIONS
#
#============================================================

#  #----------------------
#  # Program Start Aliases
#  #----------------------

alias yt='ytfzf --subs=50'
alias mpv="devour mpv"
alias mpv="devour sxiv"

#  #----------------------
#  # Program Start Functions
#  #----------------------
#function mpsyt {
#    rm -f /home/${USER}/.config/mps-youtube/cache*
# You might have to change these lines according to your install location
#    /usr/bin/youtube-dl --rm-cache-dir
#    /usr/bin/mpsyt
#}

# To run a program with arguments, insert aliases here:

alias anki="anki --base=${HOME}/pgms/anki/Documents/Anki"

alias ls='ls --color=auto'
alias ll='ls -AFlh --group-directories-first --time-style="+%Y-%m-%d %H:%M:%S"'

function ssh_alias() {
    ssh $@;
    setterm --default --clear rest;
}

alias ssh=ssh_alias

# Git Aliases
alias gitpf='git log --pretty=format:"%C(auto,red) %h %Creset %an %as %s"'

#  #----------------------
#  # PasteBins
#  #----------------------

#0x0 pastebin function -- currently possible ban on my IP address.  If want to reinitialize, send mail to 'mim@0x0.st' to lift ban
pb () {
  curl -F'file=@${1:--}' https://0x0.st
}

#ix pastebin function
ix() {
            local opts
            local OPTIND
            [ -f "$HOME/.netrc" ] && opts='-n'
            while getopts ":hd:i:n:" x; do
                case $x in
                    h) echo "ix [-d ID] [-i ID] [-n N] [opts]"; return;;
                    d) $echo curl $opts -X DELETE ix.io/$OPTARG; return;;
                    i) opts="$opts -X PUT"; local id="$OPTARG";;
                    n) opts="$opts -F read:1=$OPTARG";;
                esac
            done
            shift $(($OPTIND - 1))
            [ -t 0 ] && {
                local filename="$1"
                shift
                [ "$filename" ] && {
                    curl $opts -F f:1=@"$filename" $* ix.io/$id
                    return
                }
                echo "^C to cancel, ^D to send."
            }
            curl $opts -F f:1='<-' $* ix.io/$id
        }

#  #----------------------
#  # History
#  #----------------------
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTSIZE=10000
export HISTFILESIZE=10000

  #----------------------
#  # Global Variables
#  #----------------------

# To setup global variables at startup, insert here:


PS1='[\u@\h \W]\$ '
EDITOR="vim"

#  #----------------------
#  # Bash Setup
#  #----------------------

# To alter the bash behavior, insert  here:


set -o vi
