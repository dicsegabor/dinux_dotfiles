#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls --color=auto -la'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# load starship config
eval "$(starship init bash)"

# rust environment setup
. "$HOME/.cargo/env"
