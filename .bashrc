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

# To run a program with arguments, insert aliases here:

alias anki="anki --base=${HOME}/pgms/anki/Documents/Anki"

alias ls='ls --color=auto'
alias ll='ls -AFlh --group-directories-first'

function ssh_alias() {
    ssh $@;
    setterm --default --clear rest;
}

alias ssh=ssh_alias

pb () {
  curl -F "c=@${1:--}" https://ptpb.pw/
}

#  #----------------------
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
