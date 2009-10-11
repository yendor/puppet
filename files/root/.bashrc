# ~/.bashrc: executed by bash(1) for non-login shells.

export PS1='\[\033[01;32m\]\u\[\033[01;33m\]@\[\033[01;32m\]\h\[\033[01;33m\]:\[\033[01;36m\]\w\[\033[01;33m\]\[\033[01;33m\]\$\[\033[00m\] '
export EDITOR="vim"
umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
