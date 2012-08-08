#!/bin/bash

# System-wide .bashrc file for interactive bash(1) shells.


# If not running interactively, don't do anything.
# This snippet helps to fix scp, sftp "Received message too long" issue..
[ -z "$PS1" ] && return

# Source global definitions

[ -f /etc/bashrc ] && . /etc/bashrc
[ -f /etc/profile ] && . /etc/profile


export TERM=xterm-256color
export EDITOR=vim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


exist () { type "$1" &> /dev/null; }

###############################
# Different OS specific stuff #
###############################

OS=$(uname)             # for resolving pesky os differing switches

case $OS in
    Darwin|*BSD)
        # MacPorts stuff
        if [ -x /opt/local/bin/port ]; then
            export PATH=/opt/local/bin:/opt/local/sbin:$PATH
            export MANPATH=/opt/local/share/man:$MANPATH

            # bash_completion if installed
            if [ -x /opt/local/etc/bash_completion ]; then
                . /opt/local/etc/bash_completion
            fi
        fi

        # Homebrew stuff
        if [ -x /usr/local/bin/brew ]; then
            export PATH=/usr/local/bin:/usr/local/sbin:$PATH
            export MANPATH=/usr/local/share/man:$MANPATH

            # bash_completion if installed
            if [ -f `brew --prefix`/etc/bash_completion ]; then
                . `brew --prefix`/etc/bash_completion
            fi
        fi

        ;;

    Linux)
        # enable color support of ls and also add handy aliases
        if [ "$TERM" != "dumb" ]; then
            eval `dircolors -b`
        fi

        # Note that, Ubuntu have been already done sourcing /etc/bash_completion 
        # in /etc/profile,
        # Source this file twice will cause user fail to login GNOME.
        # You can check this file ~/.xsession-errors to find out why you login 
        # GNOME failed.
        IsUbuntu=$(lsb_release -a 2>/dev/null | grep -P 'Ubuntu || Mint' )
        # enable bash completion
        if [ -z "$IsUbuntu" ] && [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
        ;;

    *)
        echo "Your OS Type is : `uname -s`"
        # openbsd doesn't do much for color, some others may..
        export CLICOLOR=1
        ;;
esac

#######################
# Alias               #
#######################

# enable color for LS
case $OS in
    Darwin|*BSD)
        export CLICOLOR=1
        export LSCOLORS=ExFxCxDxBxegedabagacad
        alias ls='ls -G'
        # By installing Macports: GNU coreutils, alias as Linux-way
        alias ls='ls -N --color=auto --time-style=long-iso'
        ;;
    Linux)
        alias ls='ls -N --color=auto --time-style=long-iso'
        ;;
esac

alias ll='ls -al'                   # long list format
#alias lk='ls -lk'                   # --block-size=1K
#alias lt='ls -ltr'                  # sort by date (mtime)
#alias lc='ls -ltcr'                 # sort by and show change time
#alias la='ls -ltur'                 # sort by and show access time
#alias lx='ls -lXB'                  # sort by extension
#alias lz='ls -lSr'                  # sort by size
alias dir='ls -d */'                # ls only Dirs
alias ls.='ls -dAh .[^.]*'         # ls only Dotfiles
#alias lst='ls -hFtal | grep $(date +%Y-%m-%d)' #ls Today

#alias tree='tree -Cs'              # nice alternative to 'ls'
#alias vim='vim -X -p'
#alias vi='vim'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
#alias df='df -kTh'
#alias ln='ln -i -n'
#alias psg='ps -ef | grep $1'
#alias h='history | grep $1'
#alias j='jobs'
alias less='less -R --tabs=4'       # colorful 'less', tab stops = 4
#alias more='less'
#alias mkdir='mkdir -p -v'
#alias reload='source ~/.bashrc'
alias wget='wget -c'
#alias which='type -a'
alias quota='quota -vs'
alias grep='grep --mmap --color'

# Moving around & all that jazz
#alias cd='pushd > /dev/null'
#alias back='popd > /dev/null'
alias cdb='cd -' # back to $OLDPWD

#alias path='echo -e ${PATH//:/\\n}'

#delete
#alias del='mv --target-directory=$HOME/.Trash/'

#######################
# Bash SHell opts     #
#######################

#history control, ignorespace & ignoredups
export HISTCONTROL=ignoreboth
export HISTSIZE=100000
export HISTTIMEFORMAT="%Y-%m-%d_%H:%M:%S_%a  "
export HISTIGNORE="&:bg:fg:ll:h"

#Specify that it (Ctrl+D) must pressed twice to exit Bash
export IGNOREEOF=1

set -o noclobber
set -o notify
#set -o xtrace          # Useful for debuging.

# Enable options:
# check the window size after each command and, if necessary, 
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s histappend
shopt -s no_empty_cmd_completion
shopt -s cdspell
shopt -s checkhash

#######################
# Default             #
#######################

# Define Colors {{{
TXTBLK="\[\033[0;30m\]" # Black - Regular
TXTRED="\[\033[0;31m\]" # Red
TXTGRN="\[\033[0;32m\]" # Green
TXTYLW="\[\033[0;33m\]" # Yellow
TXTBLU="\[\033[0;34m\]" # Blue
TXTPUR="\[\033[0;35m\]" # Purple
TXTCYN="\[\033[0;36m\]" # Cyan
TXTWHT="\[\033[0;37m\]" # White
BLDBLK="\[\033[1;30m\]" # Black - Bold
BLDRED="\[\033[1;31m\]" # Red
BLDGRN="\[\033[1;32m\]" # Green
BLDYLW="\[\033[1;33m\]" # Yellow
BLDBLU="\[\033[1;34m\]" # Blue
BLDPUR="\[\033[1;35m\]" # Purple
BLDCYN="\[\033[1;36m\]" # Cyan
BLDWHT="\[\033[1;37m\]" # White
UNDBLK="\[\033[4;30m\]" # Black - Underline
UNDRED="\[\033[4;31m\]" # Red
UNDGRN="\[\033[4;32m\]" # Green
UNDYLW="\[\033[4;33m\]" # Yellow
UNDBLU="\[\033[4;34m\]" # Blue
UNDPUR="\[\033[4;35m\]" # Purple
UNDCYN="\[\033[4;36m\]" # Cyan
UNDWHT="\[\033[4;37m\]" # White
BAKBLK="\[\033[40m\]"   # Black - Background
BAKRED="\[\033[41m\]"   # Red
BAKGRN="\[\033[42m\]"   # Green
BAKYLW="\[\033[43m\]"   # Yellow
BAKBLU="\[\033[44m\]"   # Blue
BAKPUR="\[\033[45m\]"   # Purple
BAKCYN="\[\033[46m\]"   # Cyan
BAKWHT="\[\033[47m\]"   # White
TXTRST="\[\033[0m\]"    # Text Reset
# }}}

case $OS in
    Darwin|*BSD)
        PROMPT_HOSTCOLOR=$TXTRED
        ;;
    Linux)
        PROMPT_HOSTCOLOR=$TXTPUR
        ;;
esac

if [ "$WINDOW" ]; then
	PS1='\[\033[1;32m\]\u\[\033[1;35m\]@\h\[\033[0;36m\](${WINDOW})\[\033[1;34m\]:\[\033[1;36m\]\w\[\033[1;33m\]\$\[\033[0;37m\] '
else
	PS1='\[\033[1;32m\]\u\[\033[1;35m\]@\h:\[\033[1;36m\]\w\[\033[1;33m\]\$\[\033[0;37m\] '
fi

#PS1=$TXTYLW'\u'$TXTWHT'@'${PROMPT_HOSTCOLOR}'\h'$TXTWHT':'$TXTGRN'\W'$TXTWHT${PROMPT_GIT}$BLDBLK'$(counter)'$TXTGRN' >'$BLDGRN'>'$BLDWHT'> '$TXTWHT

# add for screen to dynamically update title
#PROMPT_COMMAND='echo -n -e "\033k\033\134"'

#export PROMPT_COMMAND='history -a'

# make less more friendly for non-text input files, see lesspipe(1)
# [ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

#######################
# Functions           #
#######################

# Easy extract
extract ()
{
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

# easy compress - archive wrapper
compress ()
{
    if [ -n "$1" ] ; then
        FILE=$1
        case $FILE in
        *.tar) shift && tar cf $FILE $* ;;
        *.tar.bz2) shift && tar cjf $FILE $* ;;
        *.tar.gz) shift && tar czf $FILE $* ;;
        *.tgz) shift && tar czf $FILE $* ;;
        *.zip) shift && zip $FILE $* ;;
        *.rar) shift && rar $FILE $* ;;
        esac
    else
        echo "usage: compress <foo.tar.gz> ./foo ./bar"
    fi
}

# get current host related info
function sysinfo()
{
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    echo -e "\n${RED}Local IP Address :$NC" ; myip
}

# Get IP (call with myip)
function myip
{
    myip=`elinks -dump http://checkip.dyndns.org:8245/`
    echo "${myip}"
}


# ls when cd, it's useful
function cd ()
{
    if [ -n "$1" ]; then
        builtin cd "$@"&& ls
    else
        builtin cd ~&& ls
    fi
}


