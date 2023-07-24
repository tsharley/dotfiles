#!/usr/bin/env bash

# common
alias ..='cd ..'
alias ss="sudo "
alias c="clear"
alias l="ls -lAhF --color=auto"
alias ll="exa -TFlahi -L=2 --color=always --header --inode --group-directories-first --sort=name"
alias lll="exa -TFlahi -L=3 --color=always --header --inode --group-directories-first --sort=name"
alias gc="git clone"
alias p8="ping 8.8.8.8"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias pubkey="pbcopy < ~/.ssh/id_rsa.pub && echo \"Public key copied to pasteboard.\""
alias cfgb="nano ~/.bashrc"
alias cfga='nano ${XDG_CONFIG_HOME}/aliases'
alias cfgf='nano ${XDG_CONFIG_HOME}/functions'
alias cfgx='nano ${XDG_CONFIG_HOME}/exports'
alias cfgd='code ${XDG_CONFIG_HOME}'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# docker
alias dpsa='docker ps -a'
alias dils='docker image ls'
alias dcls='docker container ls'
alias dcup='docker compose -f $DOCKER_FILE_DIR/docker-compose.yml up -d' #brings up all containers if one is not defined after dcup
alias dcdown='docker compose -f $DOCKER_FILE_DIR/docker-compose.yml stop' #brings down all containers if one is not defined after dcdown
alias dcpull='docker compose -f $DOCKER_FILE_DIR/docker-compose.yml pull' #pulls all new images is specified after dcpull
alias dclogs='docker compose -f $DOCKER_FILE_DIR/docker-compose.yml logs -tf --tail="50"'
function dtail() {
  docker logs -tf --tail="50" "$@"
}

# proxmox ve

# secrets ctl
