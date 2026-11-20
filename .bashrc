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
export GREP_COLOR="mt=1;31"
alias grep="grep --color=auto"

# color hex print

             
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
export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/bash_history" 

  #----------------------
#  # Global Variables
#  #----------------------

# To setup global variables at startup, insert here:
for dir in "$HOME/.local/bin" "$HOME/bin"; do     
    if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then         
    export PATH="$dir:$PATH"     
    fi done 

#  #----------------------
#  # Terminal Prompt
#  #----------------------
#PS1='[\u@\h \W]\$ '
set_gradient_prompt() {
  local dir="${PWD/#$HOME/\~}"
  local raw="[${USER}@${HOSTNAME%%.*} ${dir}]\$ "

  # Solid #395573 blue (slot 4) with low-white text (slot 252) across the entire path
  local main="\[\033[48;5;4m\033[38;5;252m\]${raw}"

  # Compact 4-column fade tail (slot 4 -> slot 60 -> slot 237)
  local tail="\[\033[48;5;60m\033[38;5;4m\]▓░\[\033[48;5;237m\033[38;5;60m\]▓░"

  PS1="${main}${tail}\[\033[0m\] "
}
PROMPT_COMMAND=set_gradient_prompt

export EDITOR="vim"
export VISUAL="$EDITOR"
export PAGER="less -RFX"
export PATH="$HOME/scripts:$PATH"

#  #----------------------
#  # Bash Setup
#  #----------------------

# To alter the bash behavior, insert  here:


set -o vi
colorscript random

# Colorized ls -l permission triads (User, Group, Others)
ls() {
  local has_l=0 arg
  for arg in "$@"; do
    case "$arg" in
      --format=long|--format=verbose) has_l=1 ;;
      --*) ;;
      -*l*) has_l=1 ;;
    esac
  done

  # Bypass awk if piped/redirected or if -l flag isn't present
  if [[ ! -t 1 ]] || [[ $has_l -eq 0 ]]; then
    command ls --color=auto "$@"
    return
  fi

  command ls --color=always "$@" | awk '
  function color_triad(str, col,    gray, out, i, c) {
    gray = "\033[38;5;245m"   # Light gray for dashes (-)
    out = ""
    for (i = 1; i <= length(str); i++) {
      c = substr(str, i, 1)
      if (c == "-") {
        out = out gray c
      } else {
        out = out col c
      }
    }
    return out "\033[0m"
  }

  /^total / { print; next }
  {
    type  = substr($0, 1, 1)    # File type (d, l, -, etc.)
    user  = substr($0, 2, 3)    # User triad
    group = substr($0, 5, 3)    # Group triad
    other = substr($0, 8, 3)    # Others triad
    rest  = substr($0, 11)      # Links, owner, group, size, date, filename

    c_blue   = "\033[38;5;117m" # Light blue (directories)
    c_yellow = "\033[38;5;229m" # Light yellow (links)
    c_gray   = "\033[38;5;245m" # Light gray (dashes)
    c_green  = "\033[38;5;120m" # Light green (User)
    c_purple = "\033[38;5;183m" # Light purple (Group)
    c_pink   = "\033[38;5;218m" # Light pink (Others)
    reset    = "\033[0m"

    if (type == "d")      type_str = c_blue type reset
    else if (type == "l") type_str = c_yellow type reset
    else if (type == "-") type_str = c_gray type reset
    else                  type_str = type

    u_str = color_triad(user, c_green)
    g_str = color_triad(group, c_purple)
    o_str = color_triad(other, c_pink)

    printf "%s %s %s %s%s\n", type_str, u_str, g_str, o_str, rest
  }'
}

alias ll='ls -hAFl --group-directories-first --time-style="+%Y-%m-%d %H:%M:%S"'

