#
# ~/.bashrc
#

export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


# statship init:

eval "$(starship init bash)"


