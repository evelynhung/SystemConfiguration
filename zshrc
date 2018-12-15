# -*- mode: sh; sh-shell: zsh; -*-

WORDCHARS='*?_-.[]~&;!#$%^(){}<>'
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000
setopt hist_reduce_blanks hist_no_functions hist_ignore_space
setopt inc_append_history histignorealldups
setopt notify prompt_subst nobeep correct
bindkey -e
autoload edit-command-line && zle -N edit-command-line
bindkey '\ee' edit-command-line

# ZSH COMPLETION
autoload -U compinit && compinit
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' completer _complete _correct _complete:foo
zstyle ':completion:*:complete:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:foo:*' matcher-list 'm:{a-zA-Z}={A-Za-z} r:|[-_./]=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '_*'
hosts=(`hostname`)
zstyle '*' hosts $hosts
# use ~/.ssh/known_hosts for completion
[ -f "$HOME/.ssh/known_hosts" ] && \
    hosts=(${${${(f)"$(<$HOME/.ssh/known_hosts)"}%%\ *}%%,*}) && \
    zstyle ':completion:*:hosts' hosts $hosts

zle_highlight=(region:standout special:standout suffix:fg=red isearch:underline)
# Include aliases and hashes
#[ -e ~/.zshalias  ] && source ~/.zshalias
#[ -e ~/.zshhashes ] && source ~/.zshhashes

# vcs_info
autoload -U vcs_info
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
precmd () { vcs_info }

# Prompt
autoload -U colors && colors
EXITCODE="%(?. . [%?]%1v)"
JOBS="%(1j.%j .)"
PS2='`%_> '
PS3='?# '
PS4='+%N:%i:%_> '
PROMPT="%{$fg[cyan]%}${JOBS}%{$fg_bold[green]%}${debian_chroot:+($debian_chroot)}%n%{$fg[magenta]%}@%m:%{$fg_bold[cyan]%}%50<...<%~%<<"'${vcs_info_msg_0_}'"%{$fg_no_bold[red]%}${EXITCODE}%{$reset_color%}
%{$fg_bold[yellow]%}$ %{$reset_color%}"

# Directory based profile, taken from grmlzshrc
CHPWD_PROFILE='default'
function chpwd_profiles() {
    local -x profile
    zstyle -s ":chpwd:profiles:${PWD}" profile profile || profile='default'
    if (( ${+functions[chpwd_profile_$profile]} )) &&
        [ "$profile" != "$CHPWD_PROFILE" ] ; then
        print -u 2 "Switching to profile: $profile"
        CHPWD_PROFILE="${profile}"
    fi
    return 0
}
chpwd_functions=( ${chpwd_functions} chpwd_profiles )

function chpwd_profile_default() {
    # TODO: auto unset
    unset QUILT_PATCHES
    [ -e ~/.zshenv  ] && source ~/.zshenv
    export TERM=xterm-256color
    export EDITOR=vim
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
}

# alias
alias ll='ls -al'                   # long list format
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias grep='grep --mmap --color'

# ls when cd, it's useful
function cd ()
{
    if [ -n "$1" ]; then
        builtin cd "$@"&& ls
    else
        builtin cd ~&& ls
    fi
}

# Usage: .. [level]
# Go up $level directories
function ..() {
    num=$1
    test $1 || num=1
    cd $(seq $num|xargs printf '../%.0s')
}

# Usage: = [math expression]
function "="() { echo "$@" | bc -l; }

