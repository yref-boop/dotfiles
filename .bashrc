#
# ~/.bashrc
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"

alias dots='/usr/bin/git --git-dir=/home/yref-boop/.dots/ --work-tree=/home/yref-boop'
