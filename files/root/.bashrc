# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export PS1='\[\033[01;32m\]\u\[\033[01;33m\]@\[\033[01;32m\]\h\[\033[01;33m\]:\[\033[01;36m\]\w\[\033[01;33m\]\[\033[01;33m\]\$\[\033[00m\] '
export EDITOR="vim"
export PAGER="less"
umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'

if [ -f $HOME/.bash_aliases ]; then
	source $HOME/.bash_aliases
fi

if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi
