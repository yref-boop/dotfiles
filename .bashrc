#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

TOMCAT_JAVA_HOME=/usr/lib/jvm/java-19-openjdk

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
alias dots='/usr/bin/git --git-dir=/home/yref-boop/.dots/ --work-tree=/home/yref-boop'

eval "$(starship init bash)"

alias nvide='WINIT_UNIX_BACKEND=x11 neovide --multigrid'

export PATH="$HOME/.ghcup/bin:$PATH"
