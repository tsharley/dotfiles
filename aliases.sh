#!/usr/bin/env bash

# Cross-platform Aliases
set_common_aliases(){
  alias ..='cd ..'
  alias ss="sudo "
  alias c="clear"
  alias gc="git clone"
  alias p8="ping 8.8.8.8"
  alias pubkey="pbcopy < ~/.ssh/id_rsa.pub && echo \"Public key copied to pasteboard.\""
  #alias l="exa -TFla -L=1 --header --inode --icons"
  alias l="exa -TFlahi -L=2 --group-directories-first --sort=name --color=always"
  alias l3="exa -TFa --level=3 --color=always --header --inode"
  alias pinstall="python3 -m pip install --upgrade"
  alias cfgd="code ${XDG_CONFIG_HOME}"
  alias cfgb="nano ~/.bashrc"
  alias cfga="nano ${XDG_CONFIG_HOME}/aliases"
  alias cfgf="nano ${XDG_CONFIG_HOME}/functions"
  alias cfgx="nano ${XDG_CONFIG_HOME}/exports"
  alias dot=". $HOME/.config/startup.rc"
  alias sbrc='. ~/.bashrc'
}

set_docker_aliases(){
  alias dpsa='docker ps -a'
  alias dils='docker image ls'
  alias dcls='docker container ls'
  alias dcup="docker compose -f $DOCKER_FILE_DIR/docker-compose.yml up -d" #brings up all containers if one is not defined after dcup
  alias dcdown="docker compose -f $DOCKER_FILE_DIR/docker-compose.yml stop" #brings down all containers if one is not defined after dcdown
  alias dcpull="docker compose -f $DOCKER_FILE_DIR/docker-compose.yml pull" #pulls all new images is specified after dcpull
  alias dclogs='docker compose -f '"$DOCKER_FILE_DIR"'/docker-compose.yml logs -tf --tail="50"'
  alias dtail='docker logs -tf --tail="50" "$@"'
}

set_macos_aliases(){
  alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
  alias flushdns="dscacheutil -flushcache"
  alias bs="brew search"
  alias bfo="brew info"
  alias bi="brew install"
  alias bd="brew update"
  alias bu="brew upgrade"
  alias brews='echo "Brews: bd=update, bu=upgrade, bs=search, binfo=info, bi=install"'
  alias nano="/opt/homebrew/bin/nano"
  alias cfgs="nano ${HOME}/Library/CloudStorage/Box-Box/SSH/config"
  alias tssh="/Applications/Tailscale.app/Contents/MacOS/Tailscale up --ssh"
  alias ssv="ssh git.charm.sh"
  alias python="python3.11"
  alias postg="$/Applications/Postgres.app/Contents/Versions/15/bin/psql -p5432 \"tjsharley\""
}

set_common_aliases
set_docker_aliases
[[ $(uname) == 'Darwin' ]] &&  set_macos_aliases
